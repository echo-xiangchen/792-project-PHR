// Importing useState hook from React for managing component state
import { useState,useEffect } from 'react'

// Importing useSelector hook from React Redux for accessing the Redux store
import { useSelector,useDispatch } from 'react-redux'

// Importing motion components from Framer Motion library for animations
import { motion } from 'framer-motion';

// Importing DataAddModal component for adding new data
import DataAddModal from './DataAddModal'

//cacluate function import
import { 
  groupByDatePressure,
  calculatePercentage,
  filterByTimeRange,
  timeToString 
} from './Utils';
//antd
import { message, Dropdown, Button, Space,TimePicker,DatePicker,InputNumber,Tooltip  } from 'antd'; // Importing Dropdown, Button, Space, and Menu components from Ant Design

//icon
import { DownOutlined } from '@ant-design/icons'; // Importing DownOutlined component from Ant Design
import { LeftOutlined,RightOutlined } from '@ant-design/icons'; // Importing LeftOutlined and RightOutlined components from Ant Design

//chart
import { MultiLineChart } from './LineChart';

//caculation
import { calculateMinMaxAvgSd } from './Utils';
import { addBloodPressure } from '../../redux/slices/profileSlice';

// Importing moment library for date and time manipulation
import moment from 'moment';

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

} from '../../constants';

const Modal = ({isModalVisible,setIsModalVisible}) => {

  // Utilizes the useDispatch hook from Redux for dispatching actions.
  const dispatch = useDispatch();

  // Initializes state for managing blood glucose readings, including day, time, value, and meal time.
  const [ value, setValue ] = useState({
    day: null,
    time: null,
    systolic: 0,
    diastolic: 0,
    pulse: 0,
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
      systolic: value.systolic,
      diastolic: value.diastolic,
      pulse: value.pulse,
    }
    // Dispatches an action to add the blood glucose reading to the Redux store.
    dispatch(addBloodPressure(reading));
    // Here you should define `setIsModalVisible` and ensure it's part of your component's state to hide the modal.
    setIsModalVisible(false);
    // Notifies the user of the successful addition. Ensure `message` is properly imported or defined to display messages.
    message.success('Blood Pressure reading added successfully');
  }



  return(
    <DataAddModal 
      title='Add Blood Pressure Reading' 
      isModalVisible={isModalVisible} 
      setIsModalVisible={setIsModalVisible}>
      <form className='flex flex-col gap-5 h-96 p-5'>
        <div className='flex gap-5 items-center'>
          <label className='flex flex-col gap-1 w-24'>Day:</label>
          <DatePicker 
            value={value.day ? moment(value.day, "YYYY-MM-DD") : null} 
            onChange={dateOnChange} 
            required
          />
        </div>

        <div className='flex gap-5 items-center'>
          <label className='flex flex-col gap-1 w-24'>Time:</label>
          <TimePicker 
            value={value.time ? moment(value.time, "HH:mm:ss") : null} 
            onChange={timeOnChange} 
            required
          />
        </div>

        <div className='flex gap-5 items-center'>
          <label className='flex flex-col gap-1 w-24'>Systolic:</label>
          <InputNumber 
            addonAfter='mmHg' 
            placeholder='Enter reading value' 
            required
            value={value.systolic}
            onChange={v => setValue({...value,systolic:v})}
            />  
        </div>

        <div className='flex gap-5 items-center'>
          <label className='flex flex-col gap-1 w-24'>Diastolic:</label>
          <InputNumber 
            addonAfter='mmHg' 
            placeholder='Enter reading value' 
            required
            value={value.diastolic}
            onChange={v => setValue({...value,diastolic:v})}
            />  
        </div>

        <div className='flex gap-5 items-center'>
          <label className='flex flex-col gap-1 w-24'>Pulse:</label>
          <InputNumber 
            addonAfter='mmHg' 
            placeholder='Enter reading value' 
            required
            value={value.pulse}
            onChange={v => setValue({...value,pulse:v})}
            />  
        </div>

        <button 
          htmlType="submit"
          onClick={handleSubmit}
          className='bg-primary mx-5 w-full md:w-40 absolute bottom-12 self-center text-white rounded-lg px-5 py-2'>Save</button>
      </form>
    </DataAddModal>
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
      <div className='bg-white rounded-lg shadow-product p-5 flex flex-col gap-3'>

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


  return (
    <div className='w-full bg-white rounded-lg shadow-product gap-7 p-5'>
      <p className='text-xl text-primary font-medium'>History</p>
      <div  className='flex p-5 border-b border-secondary'>
        <p className='text-md w-32'>Time</p>
        <p className='text-md w-32'>Systolic </p>
        <p className='text-md w-32'>Diastolic </p>
        <p className='text-md w-32'>Pulse </p>
        <span className='text-md'>Status</span>
      </div>
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
      <Modal isModalVisible={isModalVisible} setIsModalVisible={setIsModalVisible}/>
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
