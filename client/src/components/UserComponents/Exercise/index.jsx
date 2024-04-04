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
import ExerciseModal from './ExerciseModal';

//cacluate function import
import { 
  groupByDate,
  calculateMinMaxAvgSd,
  filterByTimeRange,
} from '../Utils';



const DashBoardDetails = ({data,count}) => {
// Extract and calculate stats from blood glucose data
  const duration = data.map(({ duration }) => duration);
  const { max, min, average } = calculateMinMaxAvgSd(duration);

  const calBurn = data.map(({ caloriesBurned }) => caloriesBurned);
  const { max: maxCal, min: minCal, average: averageCal } = calculateMinMaxAvgSd(calBurn);

  return(
    <div className='flex flex-col gap-5'>

      <div className='flex flex-col gap-3'>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Average Exercise Duration: </span>
          <span className='text-sm'>{average} minutes</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Highest Exercise Duration: </span>
          <span className='text-sm'>{max} minutes</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Lowest Exercise Duration: </span>
          <span className='text-sm'>{ min } minutes</span>
        </div>
      </div>

      <div className='flex flex-col gap-3'>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Average Calories Burned: </span>
          <span className='text-sm'>{ averageCal } calories</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Highest Calories Burned: </span>
          <span className='text-sm'>{maxCal} calories</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Lowest Calories Burned: </span>
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
  const { exercises } = useSelector(state => state.profile.patientData) // Accessing blood glucose data from Redux store
  const [ data, setData ] = useState(() => filterByTimeRange(exercises,dataPeriod.startTime,dataPeriod.endTime)) // State for managing data

  //when bloodGlucose, start time, end time change, update the data
  React.useEffect(() => {
    setData(filterByTimeRange(exercises,dataPeriod.startTime,dataPeriod.endTime));
  },[exercises, dataPeriod.startTime, dataPeriod.endTime]);

  
  
  return(
    <div className='w-full flex gap-5'>
      <div className='min-w-96 bg-white rounded-lg shadow-product p-5 flex flex-col gap-3'>
        <TimePick timePicker={timePicker} setTimePicker={setTimePicker} dataPeriod={dataPeriod} setDataPeriod={setDataPeriod}/>
        <DashBoardDetails data={data} count={exercises.length}/>
      </div>
      <div className='flex-1 bg-white rounded-lg shadow-product p-5'>
        <SingleLineChart data={data} type="exercise"/>
      </div>
    </div>  
  )

}

// Component for displaying data history
const History = () => {

  const { exercises } = useSelector(state => state.profile.patientData) // Accessing blood glucose data from Redux store
  const Row = ({date,exercise,duration,intensity,caloriesBurned}) => (
    <div className='flex gap-3 w-full text-[1rem]'>
      <div className='w-36 whitespace-nowrap'>
        {date}
      </div>
      <div className='w-36 whitespace-nowrap text-primary'>
        {exercise}
      </div>
      <div className='w-36 whitespace-nowrap text-primary'>
        {duration} minutes
      </div>
      <div className='w-36 whitespace-nowrap text-primary'>
        {intensity}
      </div>
      <div className='w-36 whitespace-nowrap text-primary'>
        {caloriesBurned} calories
      </div>
    </div>
  )
  

  return (
    <div className='w-full bg-white rounded-lg shadow-product gap-7 p-5'>
      <p className='text-lg text-primary font-medium'>History</p>
      <div className='flex flex-col gap-5 h-full overflow-y-auto'>
        <Row date='Date' exercise='Exercise' duration='Duration' intensity='Intensity' caloriesBurned='Calories Burned'/>
        {exercises.map(({ time, exercise, duration, intensity, caloriesBurned }) => (
          <Row key={time} date={time} exercise={exercise} duration={duration} intensity={intensity} caloriesBurned={caloriesBurned}/>
        ))}
      </div>
    </div>
  )
}

// Component for blood glucose section
const Exercise = () => {

  //modal
  const [isModalVisible, setIsModalVisible] = useState(false); // State for managing modal visibility

  return (
    <motion.div 
      initial={{ opacity: 0, x: -50 }}
      animate={{ opacity: 1, x: 0 }}
      exit={{ opacity: 0, x: 50 }}
      className='h-full flex flex-col gap-4'>
      
      <ExerciseModal isModalVisible={isModalVisible} setIsModalVisible={setIsModalVisible}/>
      <div className='w-full flex justify-between items-center'>
        <p className='text-2xl text-primary font-medium'>Exercises</p>
        <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.9 }}
          onClick={()=>setIsModalVisible(true)}
          className=' px-4 py-2 border border-1 shadow-product cursor-pointer'>Add Exercise</motion.button>
      </div>
      <DataVisualization />
      <History />
    </motion.div>
  )
}

export default Exercise
