
// Import necessary libraries and components
import DataAddModal from '../DataAddModal'
import { useState } from 'react'
import { useDispatch } from 'react-redux';
import { addBloodGlucose, addBloodPressure } from '../../../redux/slices/profileSlice' // Importing addBloodGlucose action from patientDataActions
import { message, DatePicker, TimePicker, InputNumber, Dropdown, Button, Space } from 'antd';
import { DownOutlined } from '@ant-design/icons';
import moment from 'moment';
import { timeFormat } from '../Utils';
import { motion } from 'framer-motion';


const BloodPressureModal = ({isModalVisible,setIsModalVisible}) => {

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

    const [ isConfirmVisible, setIsConfirmVisible ] = useState(false);

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
        if(value.day || value.time || value.systolic || value.diastolic || value.pulse){
            // Combines the day and time into a single timestamp.
            const uploadTime = value.day + 'T' + value.time;
            // Prepares the blood glucose reading object with a unique ID, the combined timestamp, and the value.
            const reading = {
                id: `BP-20230707${Date.now()}`,
                time: uploadTime,
                systolic: value.systolic,
                diastolic: value.diastolic,
                pulse: value.pulse,
            }
            // Dispatches an action to add the blood glucose reading to the Redux store.
            dispatch(addBloodGlucose(reading));
            // Here you should define `setIsModalVisible` and ensure it's part of your component's state to hide the modal.
            setIsModalVisible(false);
            //reset the form
            setValue({
                day: null,
                time: null,
                systolic: 0,
                diastolic: 0,
                pulse: 0,
            });
            //setIsConfirmVisible(true);
            // Notifies the user of the successful addition. Ensure `message` is properly imported or defined to display messages.
            message.success('Blood Pressure reading added successfully');
        }
    }

    const DataConfirmation = () => {
        //const newdate = value.day.format('dddd, MMMM D, YYYY');
        const newDate = moment(value.day, "YYYY-MM-DD").format('dddd, MMMM D, YYYY');
        const newTime = moment(value.day, "HH:mm:ss").format('HH:mm');
        return(
            <div className='flex flex-col h-96 py-5'>
                <div className='flex flex-col gap-7'>
                    <p className='text-md '>Date: <span className='font-semibold text-primary' >{newDate}</span></p>
                    <p className='text-md '>Time: <span className='font-semibold text-primary' >{newTime}</span></p>
                    <p className='text-md '>Systolic: <span className='font-semibold text-primary' >{value.systolic} mmHg</span></p>
                    <p className='text-md '>Diastolic: <span className='font-semibold text-primary' >{value.diastolic} mmHg</span></p>
                    <p className='text-md '>Pulse: <span className='font-semibold text-primary' >{value.pulse} bpm</span></p>
                </div>
                <div className='absolute left-16 bottom-5 w-96 flex justify-between '>
                    <motion.button
                        whileHover={{ scale: 1.05 }}
                        whileTap={{ scale: 0.9 }}
                        onClick={()=>setIsModalVisible(false)}
                        className='bg-error text-white rounded-lg px-5 py-2'>Delete</motion.button>
                    <motion.button
                        onClick={handleSubmit}
                        className='bg-primary text-white rounded-lg px-5 py-2'>Edit</motion.button>
                </div>
            </div>
        )
    }

    const Form = () => {
        return(
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
                        onChange={v => setValue({...value, systolic:v})}
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
                        addonAfter='bpm' 
                        placeholder='Enter reading value' 
                        required
                        value={value.pulse}
                        onChange={v => setValue({...value,pulse:v})}
                    />  
                </div>

                <button 
                    htmltype="submit"
                    onClick={handleSubmit}
                    className='bg-primary mx-5 w-full md:w-40 absolute bottom-12 self-center text-white rounded-lg px-5 py-2'>Save</button>
            </form>
        )
    }

    return(
        <DataAddModal 
            title='Add Blood Glucose Reading' 
            isModalVisible={isModalVisible} 
            setIsModalVisible={setIsModalVisible}>
            <Form />
        </DataAddModal>
    )
}

export default BloodPressureModal;