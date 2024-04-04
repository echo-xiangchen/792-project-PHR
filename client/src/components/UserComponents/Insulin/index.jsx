import React, { useEffect } from 'react'

//redux
import { useSelector } from 'react-redux'

//motion
import { motion } from 'framer-motion';

//components
import StackedBarChart from './InsulinStackedBar';
import TimePick from '../TimePick';
import InsulinInformationModal from './InsulinInformationModal';
import InsulinShotModal from './InsulinShotModal';

//react
import { useState } from 'react'

//function
import { groupByDateInsulin, summarizeInjections,timeToString } from '../Utils';

//antd
import { Button, Dropdown, Space } from 'antd';

//icons
import { DownOutlined, LeftOutlined, RightOutlined } from '@ant-design/icons';

//chart
import PieChartComponent from '../Charts/PieChart';

// Time period options for the time picker dropdown
const items = [
  { label: '1 day', key: 'day'},
  { label: '1 week', key: 'week'},
  { label: '1 month', key: 'month'},
  { label: '1 year', key: 'year'},
];

// Main component for data visualization
const DataVisualization = () => {

  const [ timePicker, setTimePicker ] = useState('1 week') // State for managing time picker
  //default time should end today start last 1 day
  const [ dataPeriod, setDataPeriod ] = useState({
    startTime : "2024-02-29T00:00:00", //TEST
    endTime :   "2024-03-06T00:00:00", //TEST
    //startTime: new Date().setDate(new Date().getDate() - 1),
    //endTime: new Date(),
  }) // State for managing data period

  //VALUE OF INSULIN
  const { insulin } = useSelector(state => state.profile.patientData)
  const insulinSummary = summarizeInjections(insulin, dataPeriod.startTime, dataPeriod.endTime)

  useEffect(() => {
    const insulinSummary = summarizeInjections(insulin, dataPeriod.startTime, dataPeriod.endTime)
  }, [insulin, dataPeriod])
  

  let divideDay;
  switch (timePicker) {
    case '1 day':
      divideDay = 1;
      break;
    case '1 week':
      divideDay = 7;
      break;
    case '1 month':
      divideDay = 30;
      break;
    case '1 year':
      divideDay = 365;
      break;
    default:
      divideDay = 1;
      break;
  }

  const { Basal, Bolus } = insulinSummary;
  //get total unit from array
  const sumUnits = array => array.reduce((sum, element) => sum + element.unit, 0);
  const totalUnits = sumUnits(Basal) + sumUnits(Bolus);
  const avgInsulinUnits = (totalUnits / divideDay).toFixed(1);
  const avgBasalUnits = (sumUnits(Basal) / divideDay).toFixed(1);
  const avgBolusUnits = (sumUnits(Bolus) / divideDay).toFixed(1);
  const barData = [
    { name: 'Basal', value: sumUnits(Basal) },
    { name: 'Bolus', value: sumUnits(Bolus) },
  ]


  return(
    <div className='w-full h-96 flex gap-5'>
      <div className='w-auto bg-white rounded-lg shadow-product p-5  flex flex-col gap-3'>
        <TimePick timePicker={timePicker} setTimePicker={setTimePicker} dataPeriod={dataPeriod} setDataPeriod={setDataPeriod}/>
        <div className='w-full flex justify-between items-center'>          
          <div className='flex flex-col gap-3'>
            <p><span className='text-primary'>Insulin/Day:</span> <span className=''>{avgInsulinUnits} units</span></p>
            <p><span className='text-primary'>Basal/Day: </span> <span className=''>{avgBasalUnits} units</span></p>
            <p><span className='text-primary'>Bolus/Day: </span> <span className=''>{avgBolusUnits} units</span></p>
            <p><span className='text-primary'>#Bolus/Day: </span> <span className=''>3.9</span></p>
          </div>

          <div className='w-48 h-48 '>
            <PieChartComponent data={barData}/>
          </div>
        </div>
      </div>
      <div className='flex-1 bg-white rounded-lg shadow-product p-5'>
        <StackedBarChart data={insulinSummary}/>
      </div>

    </div>  
  )

}

const History = () => {

  const { insulin } = useSelector(state => state.profile.patientData)
  const historyData = groupByDateInsulin(insulin)
  return (
    <div className='w-full bg-white rounded-lg shadow-product gap-7 p-5'>
      <p className='text-lg text-primary font-medium'>History</p>
      <div className='flex flex-col gap-5 h-full overflow-y-auto'>
        {historyData.map((item,index) => (
          <div key={index} className='flex flex-col gap-2'>
            <p className='text-sm text-primary'>{item.date}</p>
            <div className='flex flex-col gap-1 pl-5'>
              {item.value.map((reading,index) => {
                return (
                  <div key={index} className='flex'>
                    <p className='text-md w-32'>{reading.time}</p>
                    <p className='text-md w-32'>{reading.type}</p>
                    <p className='text-md w-32'>{reading.unit} units</p>
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
const Insulin = () => {

  //modal
  const [isInformationVisible, setInformationVisible] = useState(false);
  const [isNewShotVisible, setNewShotVisible] = useState(false);

  return (
    <motion.div 
    initial={{ opacity: 0, x: -50 }}
    animate={{ opacity: 1, x: 0 }}
    exit={{ opacity: 0, x: 50 }}
    className='h-full flex flex-col gap-4'>
      <InsulinInformationModal isModalVisible={isInformationVisible} setIsModalVisible={setInformationVisible}/>
      <InsulinShotModal isModalVisible={isNewShotVisible} setIsModalVisible={setNewShotVisible}/>
      <div className='w-full flex justify-between items-center'>
        <p className='text-2xl text-primary font-medium'>Insulin</p>
        <div className='flex gap-5'>
        <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.9 }}
          onClick={() => setInformationVisible(true)}
          className=' px-4 py-2 border border-1 shadow-product cursor-pointer'>Add Insulin Information</motion.button>
          <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.9 }}
          onClick={() => setNewShotVisible(true)}
          className=' px-4 py-2 border border-1 shadow-product cursor-pointer'>Add Insulin Shot</motion.button>
        </div>
      </div>
      <DataVisualization />
      <History />
    </motion.div>
  )
}




export default Insulin