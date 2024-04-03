import React from 'react'
//react
import { useState } from 'react' // Importing useState hook from React

//redux
import { useSelector } from 'react-redux' // Importing useSelector hook from React Redux to access the Redux store

//motion
import { motion } from 'framer-motion'; // Importing motion components from Framer Motion library

//components
import StackBar from '../StackBar';
import { SingleLineChart } from '../LineChart';
import TimePick from '../TimePick'
import BloodGlucoseModal from './BloodGlucoseModal'

//cacluate function import
import { 
  groupByDate,
  calculatePercentage,
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

//set up axios
import axios from 'axios';


//fetch data
import { bloodGluscoseGet } from '../../../api';


const DashBoardDetails = ({data,count}) => {

  
// Extract and calculate stats from blood glucose data
  const bloodGlucoseValue = data.map(({ value }) => value);
  const { max, min, average, standardDeviation, aboveRangePercentage, inTargetRangePercentage, belowRangePercentage } = calculatePercentage(bloodGlucoseValue);

  return(
    <div className='flex gap-5'>
      <div className='w-32 flex flex-col'>
        <StackBar aboveRangePercentage = {aboveRangePercentage}  inTargetRangePercentage = {inTargetRangePercentage} belowRangePercentage = {belowRangePercentage}/>
        <span className='text-primary'>Total readings: {count}</span>
        {/* <span>80 - 180 mg/dL</span> */}
      </div>
      

      <div className='flex flex-col gap-3'>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Average: </span>
          <span className='text-sm'>{average} mmol/L</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Max: </span>
          <span className='text-sm'>{max} mmol/L</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Min: </span>
          <span className='text-sm'>{ min } mmol/L</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Standard Deviation: </span>
          <span className='text-sm'>{ standardDeviation } mmol/L</span>
        </div>
      </div>
    </div>
  )
}
// Component for data visualization
const DataVisualization = () => {

  const [ timePicker, setTimePicker ] = useState('1 week') // State for managing time picker

  const today = new Date();
  //default time should end today start last 7 day
  const [ dataPeriod, setDataPeriod ] = useState({
    startTime : today.getDate() - 7,
    endTime :   today, //TEST
    //startTime: new Date().setDate(new Date().getDate() - 7),
    //endTime: new Date(),
  }) // State for managing data period
  const { bloodGlucose } = useSelector(state => state.profile.patientData) // Accessing blood glucose data from Redux store
  const [ data, setData ] = useState(() => filterByTimeRange(bloodGlucose,dataPeriod.startTime,dataPeriod.endTime)) // State for managing data

  //when bloodGlucose, start time, end time change, update the data
  React.useEffect(() => {
    setData(filterByTimeRange(bloodGlucose,dataPeriod.startTime,dataPeriod.endTime));
  },[bloodGlucose, dataPeriod.startTime, dataPeriod.endTime]);

  
  
  return(
    <div className='w-full flex gap-5'>
      <div className='min-w-96 bg-white rounded-lg shadow-product p-5 flex flex-col gap-3'>
        <TimePick timePicker={timePicker} setTimePicker={setTimePicker} dataPeriod={dataPeriod} setDataPeriod={setDataPeriod}/>
        <DashBoardDetails data={data} count={bloodGlucose.length}/>
        
        <div className='w-full flex justify-between'>
          <div className='flex gap-1 items-center'>
            <span className={`w-3 h-3 bg-${BGBelowColor}`}></span>
            <span className='text-sm'>Below range</span>
          </div>
          <div className='flex gap-1 items-center'>
            <span className={`w-3 h-3 bg-${BGInColor }`}></span>
            <span className='text-sm'>In range</span>
          </div>
          <div className='flex gap-1 items-center'>
            <span className={`w-3 h-3 bg-${BGAboveColor}`}></span>
            <span className='text-sm'>Above range</span>
          </div>
        </div>
      </div>
      <div className='flex-1 bg-white rounded-lg shadow-product p-5'>
        <SingleLineChart data={data}/>
      </div>

    </div>  
  )

}

// Component for displaying data history
const History = () => {


  const { bloodGlucose } = useSelector(state => state.profile.patientData) // Accessing blood glucose data from Redux store
  
  //group data by date ex: Wed, March 6, 2024 data1 data2 data3
  const historyData = groupByDate(bloodGlucose);
  return (
    <div className='w-full bg-white rounded-lg shadow-product gap-7 p-5'>
      <p className='text-lg text-primary font-medium'>History</p>
      <div className='flex flex-col gap-5 h-full overflow-y-auto'>
        {historyData.map((item,index) => (
          <div key={index} className='flex flex-col gap-2'>
            <p className='text-sm text-primary'>{item.date}</p>
            <div className='flex flex-col gap-1 pl-5'>
              {item.value.map((reading,index) => {
                const color = reading.value < BGLOWERLIMITE ? `bg-${BGBelowColor}` : reading.value > BGUPPERLIMIT ? `bg-${BGAboveColor}` : `bg-${BGInColor}`;
                const label = reading.value < BGLOWERLIMITE ? 'Below range' : reading.value > BGUPPERLIMIT ? 'Above range' : 'In range';
                return (
                  <div key={index} className='flex'>
                    <p className='text-md w-32'>{reading.time}</p>
                    <p className='text-md w-32'>{reading.value} mmol/L</p>
                    <div className='flex gap-2 items-center'>
                      <span className={`w-3 h-3 ${color}`}></span>
                      <span className='text-sm'>{label}</span>
                    </div>
                  </div>
                )
              })}
            </div>
          </div>
        ))}
        </div>
    </div>
  )
}

// Component for blood glucose section
const BloodGlucose = () => {

  //modal
  const [isModalVisible, setIsModalVisible] = useState(false); // State for managing modal visibility

  return (
    <motion.div 
      initial={{ opacity: 0, x: -50 }}
      animate={{ opacity: 1, x: 0 }}
      exit={{ opacity: 0, x: 50 }}
      className='h-full flex flex-col gap-4'>
      
      <BloodGlucoseModal isModalVisible={isModalVisible} setIsModalVisible={setIsModalVisible}/>
      <div className='w-full flex justify-between items-center'>
        <p className='text-2xl text-primary font-medium'>Blood Glucose</p>
        <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.9 }}
          onClick={()=>setIsModalVisible(true)}
          className=' px-4 py-2 border border-1 shadow-product cursor-pointer'>Add Reading</motion.button>
      </div>
      <DataVisualization />
      <History />
    </motion.div>
  )
}

export default BloodGlucose
