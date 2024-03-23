
// Import necessary libraries and components
import DataAddModal from './DataAddModal'
import { useState } from 'react'
import { useDispatch } from 'react-redux';
import { addWeight } from '../../redux/slices/profileSlice' // Importing addBloodGlucose action from patientDataActions
import { message, DatePicker, InputNumber } from 'antd';
import moment from 'moment';


const ExerciseModal = ({isModalVisible,setIsModalVisible}) => {

    // Utilizes the useDispatch hook from Redux for dispatching actions.
    const dispatch = useDispatch();

    // Initializes state for managing blood glucose readings, including day, time, value, and meal time.
    const [ value, setValue ] = useState({
        time: null,
        value: 0,
    });

    const [ isConfirmVisible, setIsConfirmVisible ] = useState(false);

    // Handles changes to the time input by updating the state.
    const timeOnChange = (date, dateString) => {
    setValue({...value, time: dateString});
    }

    // Handles the form submission event.
    const handleSubmit = (e) => {
        e.preventDefault(); // Dont reload the page
        if(value.time && value.value ){
            // Prepares the blood glucose reading object with a unique ID, the combined timestamp, and the value.
            const reading = {
                id: `BG-20230707${Date.now()}`,
                time: value.time,
                value: value.value,
            }
            // Dispatches an action to add the blood glucose reading to the Redux store.
            dispatch(addWeight(reading));
            // Here you should define `setIsModalVisible` and ensure it's part of your component's state to hide the modal.
            setIsModalVisible(false);
            //reset the form
            setValue({
                time: null,
                value: 0,
            });
            //setIsConfirmVisible(true);
            // Notifies the user of the successful addition. Ensure `message` is properly imported or defined to display messages.
            message.success('Weight Recording successfully');
        }
    }

    const DataConfirmation = () => {
        //const newdate = value.day.format('dddd, MMMM D, YYYY');
        const newDate = moment(value.day, "YYYY-MM-DD").format('dddd, MMMM D, YYYY');
        const newTime = moment(value.day, "HH:mm:ss").format('HH:mm');
        return(
            <div className='flex flex-col h-96 py-5'>
                test
            </div>
        )
    }

    const Form = () => {
        return(
            <form className='flex flex-col gap-5 h-96 p-5'>

                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-24'>Time:</label>
                    <DatePicker 
                        value={value.time ? moment(value.time, "YYYY-MM-DD") : null} 
                        onChange={timeOnChange} 
                        required
                    />
                </div>

                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-24'>Weight:</label>
                    <InputNumber 
                        addonAfter='Kgs' 
                        placeholder='Enter reading value' 
                        required
                        value={value.value}
                        onChange={v => setValue({...value,value:v})}
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
            title='Add Exercise' 
            isModalVisible={isModalVisible} 
            setIsModalVisible={setIsModalVisible}>
            <Form />
        </DataAddModal>
    )
}

export default ExerciseModal;