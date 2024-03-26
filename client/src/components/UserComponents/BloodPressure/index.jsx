// Importing useState hook from React for managing component state
import { useState,useEffect } from 'react'

// Importing useSelector hook from React Redux for accessing the Redux store
import { useSelector,useDispatch } from 'react-redux'

// Importing motion components from Framer Motion library for animations
import { motion } from 'framer-motion';

//cacluate function import
import { 
  groupByDatePressure,
  filterByTimeRange,
} from '../Utils';

// component
import BloodPressureModal from './BloodPressureModal';
import TimePick from '../TimePick';

//chart
import { MultiLineChart } from '../LineChart';

//caculation
import { calculateMinMaxAvgSd } from '../Utils';

// Constants for glucose range limits
import {
  SYSTOLIC_NORMAL,
  SYSTOLIC_UPPERLIMIT,
  DIASTOLIC_NORMAL,
  DIASTOLIC_UPPERLIMIT,
  PULSE_LOWERLIMITE,
  PULSE_UPPERLIMIT,

  BPLowerColor,
  BPInColor,
  BPAboveColor,

} from '../../../constants';


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

  // Accessing blood Pressure data from Redux store
  const { bloodPressure } = useSelector(state => state.profile.patientData) // Accessing blood glucose data from Redux store
  const [ data, setData ] = useState(() => filterByTimeRange(bloodPressure,dataPeriod.startTime,dataPeriod.endTime)) // State for managing data
  
  //Split the data into systolic and diastolic
  const systolicDetail = calculateMinMaxAvgSd(data.map(({ systolic }) => systolic));
  const diastolicDetail = calculateMinMaxAvgSd(data.map(({ diastolic }) => diastolic));
  const Row = ({title,min,max,avg,sd}) => (
    <div className='flex gap-3 w-full text-[0.7rem]'>
      <div className='w-16 whitespace-nowrap'>
        {title}
      </div>
      <span className='w-24 whitespace-nowrap'>
        {min} 
      </span>
      <div className='w-24  whitespace-nowrap'>
        {max}
      </div>
      <div className='w-24  whitespace-nowrap'>
        {avg}
      </div>
      <div className='w-24  whitespace-nowrap'>
        {sd}
      </div>
    </div>
  )
  const DetailTable = () => (
    <div className='flex flex-col gap-3'>
      <Row title='' min="Lowest" max="Highest" avg='Average' sd="Standard Deviation"/>
      <Row title='Systolic' min={`${systolicDetail.min} mmHg`} max={`${systolicDetail.max} mmHg`} avg={`${systolicDetail.average} mmHg`} sd={`${systolicDetail.standardDeviation} mmHg`}/>
      <Row title='Diastolic' min={`${diastolicDetail.min} mmHg`} max={`${diastolicDetail.max} mmHg`} avg={`${diastolicDetail.average} mmHg`} sd={`${diastolicDetail.standardDeviation} mmHg`}/>
    </div>
  )

  
  //when bloodPressure, start time, end time change, update the data
  useEffect(() => {
    setData(filterByTimeRange(bloodPressure,dataPeriod.startTime,dataPeriod.endTime));
  },[bloodPressure, dataPeriod.startTime, dataPeriod.endTime]);

  return(
    <div className='w-full flex gap-5'>
      <div className='bg-white rounded-lg shadow-product p-5 flex flex-col gap-3'>
        <TimePick timePicker={timePicker} setTimePicker={setTimePicker} dataPeriod={dataPeriod} setDataPeriod={setDataPeriod}/>
        <DetailTable />
      </div>
      <div className='h-[300px] flex-1 bg-white rounded-lg shadow-product p-5'>
        <MultiLineChart data={data}/>
      </div>
    </div>  
  )

}

// Component for displaying data history
const History = () => {

  // Accessing blood pressure data from Redux store
  const { bloodPressure } = useSelector(state => state.profile.patientData)

  //group data by date ex: Wed, March 6, 2024 data1 data2 data3
  const historyData = groupByDatePressure(bloodPressure);

  const Title = () => (
    <div  className='flex p-5 border-b border-secondary'>
        <p className='text-md w-32'>Time</p>
        <p className='text-md w-32'>Systolic </p>
        <p className='text-md w-32'>Diastolic </p>
        <p className='text-md w-32'>Pulse </p>
        <span className='text-md'>Status</span>
      </div>
  )

  return (
    <div className='w-full bg-white rounded-lg shadow-product gap-7 p-5'>
      <p className='text-xl text-primary font-medium'>History</p>
      <Title />
      <div className='flex flex-col gap-5 h-full overflow-y-auto pt-4'>
        {historyData.map((item,index) => (
          <div key={index} className='flex flex-col gap-2'>
            <p className='text-sm text-primary'>{item.date}</p>
            <div className='flex flex-col gap-1 pl-5'>
              {item.value.map((reading,index) => {
                var systolicColor, diastolicColor, pulseColor, color, label;

                //Systolic
                if(reading.systolic < SYSTOLIC_NORMAL){
                  systolicColor = `text-${BPInColor}`;
                }else if(reading.systolic < SYSTOLIC_UPPERLIMIT){
                  systolicColor = `text-${BPLowerColor}`;
                }else{
                  systolicColor = `text-${BPAboveColor}`;
                }

                //Diastolic
                if(reading.diastolic < DIASTOLIC_NORMAL){
                  diastolicColor = `text-${BPInColor}`;
                }else if(reading.diastolic < DIASTOLIC_UPPERLIMIT){
                  diastolicColor = `text-${BPLowerColor}`;
                }else{
                  diastolicColor = `text-${BPAboveColor}`;
                }

                //Pulse
                if(reading.pulse < PULSE_LOWERLIMITE){
                  pulseColor = 'text-error';
                }else if(reading.pulse > PULSE_UPPERLIMIT){
                  pulseColor = 'text-error';
                }else{
                  pulseColor = 'text-success';
                }

                //color and label
                if(systolicColor == 'text-success' && diastolicColor == 'text-success' && pulseColor == 'text-success'){
                  color = 'bg-success';
                  label = 'Normal';
                }else if(systolicColor == 'text-error' || diastolicColor == 'text-error' || pulseColor == 'text-error'){
                  color = 'bg-error';
                  label = 'Risk Warning';
                }else{
                  color = 'bg-yellow';
                  label = 'Elevated';
                }
                
                return (
                    <div  className='flex' key={index}>
                      <p className='text-md w-32'>{reading.time}</p>
                      <p className={`${systolicColor} text-md w-32`}>{reading.systolic} mmHg</p>
                      <p className={`${diastolicColor} text-md w-32`}>{reading.diastolic} mmHg</p>
                      <p className={`${pulseColor} text-md w-32`}>{reading.pulse} bpm</p>
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

// Component for blood pressure section
const BloodPressure = () => {

  // State for managing modal visibility
  const [isModalVisible, setIsModalVisible] = useState(false);

  return (
    <motion.div 
    initial={{ opacity: 0, x: -50 }}
    animate={{ opacity: 1, x: 0 }}
    exit={{ opacity: 0, x: 50 }}
      className='h-full flex flex-col gap-4'>
      <BloodPressureModal isModalVisible={isModalVisible} setIsModalVisible={setIsModalVisible}/>
      <div className='w-full flex justify-between items-center'>
        <p className='text-2xl text-primary font-medium'>Blood Pressure</p>
        <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.9 }}
          onClick={() => setIsModalVisible(true)}
          className=' px-4 py-2 border border-1 shadow-product cursor-pointer'>Add Reading</motion.button>
      </div>
      <DataVisualization />
      <History />
    </motion.div>
  )
}

export default BloodPressure
