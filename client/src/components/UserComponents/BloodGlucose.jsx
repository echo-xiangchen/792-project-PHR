import React from 'react'
//react
import { useState } from 'react' // Importing useState hook from React

//redux
import { useSelector } from 'react-redux' // Importing useSelector hook from React Redux to access the Redux store
import { useDispatch } from 'react-redux' // Importing useDispatch hook from React Redux to dispatch actions to the Redux store
import { addBloodGlucose } from '../../redux/slices/profileSlice' // Importing addBloodGlucose action from patientDataActions

//motion
import { motion } from 'framer-motion'; // Importing motion components from Framer Motion library

//components
import DataAddModal from './DataAddModal' // Importing DataAddModal component
import StackBar from './StackBar';
import { SingleLineChart } from './LineChart';

//antd
import { message, Dropdown, Button, Space,TimePicker,DatePicker,InputNumber } from 'antd'; // Importing Dropdown, Button, Space, and Menu components from Ant Design
import moment from 'moment';

//icons
import { 
  DownOutlined, 
  UserOutlined,
  LeftOutlined,
  RightOutlined,
} from '@ant-design/icons'; // Importing DownOutlined and UserOutlined components from Ant Design

//cacluate function import
import { 
  groupByDate,
  calculatePercentage,
  filterByTimeRange,
  timeToString 
} from './Utils';

// Constants for glucose range limits
const LOWERLIMITE = 70;
const UPPERLIMIT = 120;


const DashBoardDetails = ({data}) => {
// Extract and calculate stats from blood glucose data
  const bloodGlucoseValue = data.map(({ value }) => value);
  const { max, min, average, standardDeviation, aboveRangePercentage, inTargetRangePercentage, belowRangePercentage } = calculatePercentage(bloodGlucoseValue);


  return(
    <div className='flex gap-5'>
      <div className='w-32 flex flex-col'>
        <StackBar aboveRangePercentage = {aboveRangePercentage}  inTargetRangePercentage = {inTargetRangePercentage} belowRangePercentage = {belowRangePercentage}/>
        <span className='text-primary'>All readings</span>
        <span>80 - 180 mg/dL</span>
      </div>
      

      <div className='flex flex-col gap-3'>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Average: </span>
          <span className='text-sm'>{average} mg/dL</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Max: </span>
          <span className='text-sm'>{max} mg/dL</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Min: </span>
          <span className='text-sm'>{ min } mg/dL</span>
        </div>
        <div className='flex gap-3 items-center'>
          <span className='text-primary'>Standard Deviation: </span>
          <span className='text-sm'>{ standardDeviation } mg/dL</span>
        </div>
      </div>
    </div>
  )
}

const items = [
  { label: '1 day', key: 'day'},
  { label: '1 week', key: 'week'},
  { label: '1 month', key: 'month'},
  { label: '1 year', key: 'year'},
];

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
  const { bloodGlucose } = useSelector(state => state.profile.patientData) // Accessing blood glucose data from Redux store
  const [ data, setData ] = useState(() => filterByTimeRange(bloodGlucose,dataPeriod.startTime,dataPeriod.endTime)) // State for managing data

  //when bloodGlucose, start time, end time change, update the data
  React.useEffect(() => {
    setData(filterByTimeRange(bloodGlucose,dataPeriod.startTime,dataPeriod.endTime));
  },[bloodGlucose, dataPeriod.startTime, dataPeriod.endTime]);

  //conside the time picker, update the start time and end time to next period
  const nextPeriod = () => {
    const endTime = new Date(dataPeriod.startTime);
    const startTime = new Date(dataPeriod.startTime);
    switch(timePicker){
      case '1 day':
        endTime.setDate(endTime.getDate() + 1);
        break;
      case '1 week':
        endTime.setDate(endTime.getDate() + 7);
        break;
      case '1 month':
        endTime.setMonth(endTime.getMonth() + 1);
        break;
      case '1 year':
        endTime.setFullYear(endTime.getFullYear() + 1);
        break;
      default:
        break;
    }
    setDataPeriod({startTime: startTime.toISOString(), endTime: endTime.toISOString()});
  }

  //conside the time picker, update the start time and end time to previous period
  const previousPeriod = () => {
    const endTime = new Date(dataPeriod.startTime);
    const startTime = new Date(dataPeriod.startTime);
    switch(timePicker){
      case '1 day':
        startTime.setDate(startTime.getDate() - 1);
        break;
      case '1 week':
        startTime.setDate(startTime.getDate() - 7);
        break;
      case '1 month':
        startTime.setMonth(startTime.getMonth() - 1);
        break;
      case '1 year':
        startTime.setFullYear(startTime.getFullYear() - 1);
        break;
      default:
        break;
    }
    setDataPeriod({startTime: startTime.toISOString(), endTime: endTime.toISOString()});
  }



  //dropdown menu props
  const menuProps = {
    items,
    onClick: (e) => {
      const newMenu = items.filter(item => item.key === e.key);
      setTimePicker(newMenu[0].label);
    },
  };
  
  return(
    <div className='w-full flex gap-5'>
      <div className='min-w-96 bg-white rounded-lg shadow-product p-5 flex flex-col gap-3'>
        <div className='flex gap-2 items-center'>
          <span className='text-primary'>Time: </span>
          <Dropdown menu={menuProps}>
            <Button>
              <Space>
                {timePicker}
                <DownOutlined />
              </Space>
            </Button>
          </Dropdown> 
        </div>

        <div className='flex gap-3 items-center'>
          <motion.button 
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.9 }}
            onClick={previousPeriod}
            className='bg-secondary text-white rounded-lg py-1 px-2 text-sm'><LeftOutlined />
          </motion.button>
          <motion.button 
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.9 }}
            onClick={nextPeriod}
            className='bg-secondary text-white rounded-lg py-1 px-2 text-sm'><RightOutlined />
          </motion.button>
          <span className='text-sm'>{timeToString(dataPeriod.startTime,timePicker)} - {timeToString(dataPeriod.endTime,timePicker)}</span>
        </div>
        
        <DashBoardDetails data={data}/>
        <div className='w-full flex justify-between'>
          <div className='flex gap-1 items-center'>
            <span className='w-3 h-3 bg-yellow'></span>
            <span className='text-sm'>Below range</span>
          </div>
          <div className='flex gap-1 items-center'>
            <span className='w-3 h-3 bg-success'></span>
            <span className='text-sm'>In range</span>
          </div>
          <div className='flex gap-1 items-center'>
            <span className='w-3 h-3 bg-error'></span>
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
                const color = reading.value < LOWERLIMITE ? 'bg-yellow' : reading.value > UPPERLIMIT ? 'bg-error' : 'bg-success';
                const label = reading.value < LOWERLIMITE ? 'Below range' : reading.value > UPPERLIMIT ? 'Above range' : 'In range';
                return (
                  <div key={index} className='flex'>
                    <p className='text-md w-32'>{reading.time}</p>
                    <p className='text-md w-32'>{reading.value} mg/dL</p>
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

const Modal = ({isModalVisible,setIsModalVisible}) => {

  // Utilizes the useDispatch hook from Redux for dispatching actions.
  const dispatch = useDispatch();

  // Initializes state for managing blood glucose readings, including day, time, value, and meal time.
  const [ value, setValue ] = useState({
    day: null,
    time: null,
    value: 0,
    mealTime: "no idea",
  });

  // Defines the items for the dropdown menu, each with a unique key and label.
  const items = [
    { label: 'no idea1', key: '1'},
    { label: 'no idea2', key: '2'},
    { label: 'no idea3', key: '3'},
    { label: 'no idea4', key: '4'},
  ];

  // Properties for the dropdown menu including the items to display and the onClick event handler.
  const menuProps = {
    items,
    onClick: (e) => {
      // Filters the items to find the one that matches the clicked item, then updates the mealTime in state.
      const newMenu = items.filter(item => item.key === e.key);
      setValue({...value, mealTime: newMenu[0].label});
    },
  };

  // Handles changes to the date input by updating the state.
  const dateOnChange = (date, dateString) => {
    setValue({...value, day: dateString});
  }

  // Handles changes to the time input by updating the state.
  const timeOnChange = (date, dateString) => {
    setValue({...value, time: dateString});
  }

  // Handles the form submission event.
  const handleSubmit = (e) => {
    e.preventDefault(); // Dont reload the page
    // Combines the day and time into a single timestamp.
    const uploadTime = value.day + 'T' + value.time;
    // Prepares the blood glucose reading object with a unique ID, the combined timestamp, and the value.
    const reading = {
      id: `BG-20230707${Date.now()}`,
      time: uploadTime,
      value: value.value,
    }
    // Dispatches an action to add the blood glucose reading to the Redux store.
    dispatch(addBloodGlucose(reading));
    // Here you should define `setIsModalVisible` and ensure it's part of your component's state to hide the modal.
    setIsModalVisible(false);
    // Notifies the user of the successful addition. Ensure `message` is properly imported or defined to display messages.
    message.success('Blood Glucose reading added successfully');
  }



  return(
    <DataAddModal 
      title='Add Blood Glucose Reading' 
      isModalVisible={isModalVisible} 
      setIsModalVisible={setIsModalVisible}>
      <form className='flex flex-col gap-5 h-96 p-5'>
        <div className='flex gap-5 items-center'>
          <label className='flex flex-col gap-1'>Day:</label>
          <DatePicker 
            value={value.day ? moment(value.day, "YYYY-MM-DD") : null} 
            onChange={dateOnChange} 
            required
          />
        </div>

        <div className='flex gap-5 items-center'>
          <label className='flex flex-col gap-1'>Time:</label>
          <TimePicker 
            value={value.time ? moment(value.time, "HH:mm:ss") : null} 
            onChange={timeOnChange} 
            required
          />
        </div>

        <div className='flex gap-5 items-center'>
          <label className='flex flex-col gap-1'>Blood Glucose:</label>
          <InputNumber 
            addonAfter='mg/dL' 
            placeholder='Enter reading value' 
            required
            value={value.value}
            onChange={v => setValue({...value,value:v})}
            />  
        </div>

        <div className='flex gap-5 items-center'>
          <label className='flex flex-col gap-1'>Meal Time:</label>
          <Dropdown menu={menuProps}>
            <Button>
              <Space>
                {value.mealTime}
                <DownOutlined />
              </Space>
            </Button>
          </Dropdown>
        </div>

        <button 
          htmlType="submit"
          onClick={handleSubmit}
          className='bg-primary mx-5 w-full md:w-40 absolute bottom-12 self-center text-white rounded-lg px-5 py-2'>Save</button>
      </form>
    </DataAddModal>
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
      
      <Modal isModalVisible={isModalVisible} setIsModalVisible={setIsModalVisible}/>
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
