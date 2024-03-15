// Importing useState hook from React for managing component state
import { useState } from 'react'

// Importing useSelector hook from React Redux for accessing the Redux store
import { useSelector,useDispatch } from 'react-redux'

// Importing motion components from Framer Motion library for animations
import { motion } from 'framer-motion';

// Importing DataAddModal component for adding new data
import DataAddModal from './DataAddModal'

//cacluate function import
import { groupByDate, filterByTimeRange } from './Utils'

//antd
import { message, Dropdown, Button, Space,TimePicker,DatePicker,InputNumber } from 'antd'; // Importing Dropdown, Button, Space, and Menu components from Ant Design

//icon
import { DownOutlined } from '@ant-design/icons'; // Importing DownOutlined component from Ant Design

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
            onChange={v => setValue({...value,value:v})}
            />  
        </div>

        <div className='flex gap-5 items-center'>
          <label className='flex flex-col gap-1 w-24'>Diastolic:</label>
          <InputNumber 
            addonAfter='mmHg' 
            placeholder='Enter reading value' 
            required
            value={value.diastolic}
            onChange={v => setValue({...value,value:v})}
            />  
        </div>

        <div className='flex gap-5 items-center'>
          <label className='flex flex-col gap-1 w-24'>Pulse:</label>
          <InputNumber 
            addonAfter='mmHg' 
            placeholder='Enter reading value' 
            required
            value={value.pulse}
            onChange={v => setValue({...value,value:v})}
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

// Component for data visualization
const DataVisualization = () => {

  // Accessing blood pressure data from Redux store
  const { bloodPressure } = useSelector(state => state.profile.patientData)

  return(
    <div className='w-full h-96 flex gap-5'>
      <div className='w-96 bg-white rounded-lg shadow-product p-5'>

      </div>
      <div className='flex-1 bg-white rounded-lg shadow-product p-5'>

      </div>

    </div>  
  )

}

// Component for displaying data history
const History = () => {

  // Accessing blood pressure data from Redux store
  const { bloodPressure } = useSelector(state => state.profile.patientData)

  return (
    <div className='w-full h-80 bg-white rounded-lg shadow-product p-5'>
      <p className='text-md text-primary font-medium'>History</p>
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
