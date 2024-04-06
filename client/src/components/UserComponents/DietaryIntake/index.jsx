import React from 'react'
//react
import { useState } from 'react' // Importing useState hook from React

//redux
import { useSelector } from 'react-redux' // Importing useSelector hook from React Redux to access the Redux store

//motion
import { motion } from 'framer-motion'; // Importing motion components from Framer Motion library

//components
import StackBar from '../Charts/StackBar';
import { SingleLineChart } from '../Charts/LineChart';
import TimePick from '../TimePick'
import DietaryIntakeModal from './DietaryIntakeModal';

//cacluate function import
import { 
  groupByDate,
  calculateMinMaxAvgSd,
  filterByTimeRange,
} from '../Utils';

// Constants for glucose range limits
import { 
  BGLOWERLIMITE, 
  BGUPPERLIMIT, 
  BGBelowColor, 
  BGInColor, 
  BGAboveColor 
} from '../../../constants';


const DashBoardDetails = ({data,count}) => {
// Extract and calculate stats from blood glucose data
  const { 
    max, 
    min, 
    average 
  } = calculateMinMaxAvgSd(data.map(({ carbs }) => carbs));
  const { 
    max: maxCal, 
    min: minCal, 
    average: averageCal } = calculateMinMaxAvgSd(data.map(({ calories }) => calories));

  return(
    <div className='flex flex-col gap-5'>

      <div className='flex flex-col gap-3'>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Average Carbs Intake per Day: </span>
          <span className='text-sm'>{average} grams</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Highest Carbs Intake per Day: </span>
          <span className='text-sm'>{max} grams</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Lowest Carbs Intake per Day: </span>
          <span className='text-sm'>{ min } grams</span>
        </div>
      </div>

      <div className='flex flex-col gap-3'>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Average Calorie Intake per Day: </span>
          <span className='text-sm'>{averageCal} calories</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Highest Calorie Intake per Day: </span>
          <span className='text-sm'>{maxCal} calories</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Lowest Calorie Intake per Day: </span>
          <span className='text-sm'>{ minCal } calories</span>
        </div>
      </div>

    </div>
  )
}
// Component for data visualization
const DataVisualization = () => {

  const [ timePicker, setTimePicker ] = useState('1 day') // State for managing time picker
  //default time should end today start last 1 day
  const [ dataPeriod, setDataPeriod ] = useState({
    startTime : "2024-02-06T00:00:00", //TEST
    endTime :   "2024-06-07T00:00:00", //TEST
    //startTime: new Date().setDate(new Date().getDate() - 1),
    //endTime: new Date(),
  }) // State for managing data period
  const { dietaryIntake } = useSelector(state => state.profile.patientData) // Accessing blood glucose data from Redux store
  const [ data, setData ] = useState(() => filterByTimeRange(dietaryIntake,dataPeriod.startTime,dataPeriod.endTime)) // State for managing data

  //when bloodGlucose, start time, end time change, update the data
  React.useEffect(() => {
    setData(filterByTimeRange(dietaryIntake,dataPeriod.startTime,dataPeriod.endTime));
  },[dietaryIntake, dataPeriod.startTime, dataPeriod.endTime]);

  
  
  return(
    <div className='w-full flex gap-5'>
      <div className='min-w-96 bg-white rounded-lg shadow-product p-5 flex flex-col gap-3'>
        <TimePick timePicker={timePicker} setTimePicker={setTimePicker} dataPeriod={dataPeriod} setDataPeriod={setDataPeriod}/>
        <DashBoardDetails data={data} count={dietaryIntake.length}/>
      </div>
      <div className='flex-1 bg-white rounded-lg shadow-product p-5'>
        <SingleLineChart data={data} type="dietaryIntake"/>
      </div>
    </div>  
  )

}

// Component for displaying data history
const History = () => {

  const { dietaryIntake } = useSelector(state => state.profile.patientData) // Accessing blood glucose data from Redux store
  const Row = ({date,carbs,calories}) => (
    <div className='flex gap-3 w-full text-[1rem]'>
      <div className='w-36 whitespace-nowrap'>
        {date}
      </div>
      <div className='w-48 whitespace-nowrap text-primary'>
        {carbs} grams
      </div>
      <div className='w-36 whitespace-nowrap text-primary'>
        {calories} calories
      </div>
    </div>
  )
  

  return (
    <div className='w-full bg-white rounded-lg shadow-product gap-7 p-5'>
      <p className='text-lg text-primary font-medium'>History</p>
      <div className='flex flex-col gap-5 h-full overflow-y-auto'>
        <Row date='Date' carbs='Total Carbs /' calories='Total'/>
        {dietaryIntake.map(({ time, carbs, calories }) => (
          <Row key={time} date={time} carbs={carbs} calories={calories} />
        ))}
      </div>
    </div>
  )
}

// Component for blood glucose section
const DietaryIntake = () => {

  //modal
  const [isModalVisible, setIsModalVisible] = useState(false); // State for managing modal visibility

  return (
    <motion.div 
      initial={{ opacity: 0, x: -50 }}
      animate={{ opacity: 1, x: 0 }}
      exit={{ opacity: 0, x: 50 }}
      className='h-full flex flex-col gap-4'>
      
      <DietaryIntakeModal isModalVisible={isModalVisible} setIsModalVisible={setIsModalVisible}/>
      <div className='w-full flex justify-between items-center'>
        <p className='text-2xl text-primary font-medium'>Dietary Intake</p>
        <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.9 }}
          onClick={()=>setIsModalVisible(true)}
          className=' px-4 py-2 border border-1 shadow-product cursor-pointer'>Add Entry</motion.button>
      </div>
      <DataVisualization />
      <History />
    </motion.div>
  )
}
export default DietaryIntake