
// Import necessary libraries and components
import DataAddModal from './DataAddModal'
import { useState } from 'react'
import { useDispatch } from 'react-redux';
import { 
    addExercises 
} from '../../redux/slices/profileSlice' // Importing addBloodGlucose action from patientDataActions
import { 
    message, 
    DatePicker, 
    InputNumber, 
    Dropdown,
    Button,
    Space,
    TimePicker,
} from 'antd';

import { DownOutlined } from '@ant-design/icons';

import moment from 'moment';


const ExerciseModal = ({isModalVisible,setIsModalVisible}) => {

    // Utilizes the useDispatch hook from Redux for dispatching actions.
    const dispatch = useDispatch();

    // Initializes state for managing blood glucose readings, including day, time, value, and meal time.
    const [ value, setValue ] = useState({
        time: null,
        exercise: "Running",
        duration: null,
        intensity: "Medium",
        caloriesBurned: 0,
    });

    //Examples of options for Exercise: Aerobics, Boxing, Dance, Elliptical, Hiking, Pilates, Running, Walking, Swimming
    const exerciseItems = [
        { key: 'Running', label: 'Running' },
        { key: 'Walking', label: 'Walking' },
        { key: 'Swimming', label: 'Swimming' },
        { key: 'Aerobics', label: 'Aerobics' },
        { key: 'Boxing', label: 'Boxing' },
        { key: 'Dance', label: 'Dance' },
        { key: 'Elliptical', label: 'Elliptical' },
        { key: 'Hiking', label: 'Hiking' },
        { key: 'Pilates', label: 'Pilates' },
    ];

    //Options for "Intensity": Low, Medium, High
    const intensityItems = [
        { key: 'Low', label: 'Low' },
        { key: 'Medium', label: 'Medium' },
        { key: 'High', label: 'High' },
    ];

    const exerciseProps = {
        items: exerciseItems,
        onClick: (e) => {
            // Filters the items to find the one that matches the clicked item, then updates the mealTime in state.
            const newMenu = exerciseItems.filter(item => item.key === e.key);
            setValue({...value, exercise: newMenu[0].label});
        },
    };

    const intensityProps = {
        items: intensityItems,
        onClick: (e) => {
            // Filters the items to find the one that matches the clicked item, then updates the mealTime in state.
            const newMenu = intensityItems.filter(item => item.key === e.key);
            setValue({...value, intensity: newMenu[0].label});
        },
    };

    const [ isConfirmVisible, setIsConfirmVisible ] = useState(false);

    // Handles changes to the time input by updating the state.
    const timeOnChange = (date, dateString) => {
        setValue({...value, time: dateString});
    }

    const durationOnChange = (date, dateString) => {
        setValue({...value, duration: dateString});
    }

    // Handles the form submission event.
    const handleSubmit = (e) => {
        e.preventDefault(); // Dont reload the page
        if(value.time && value.exercise !== "" && value.duration && value.intensity !== "" && value.value !== 0){
            // Prepares the blood glucose reading object with a unique ID, the combined timestamp, and the value.
            const reading = {
                id: `BG-20230707${Date.now()}`,
                time: value.time,
                exercise: value.exercise,
                duration: value.duration,
                intensity: value.intensity,
                caloriesBurned: value.caloriesBurned,
            }
            // Dispatches an action to add the blood glucose reading to the Redux store.
            dispatch(addExercises(reading));
            // Here you should define `setIsModalVisible` and ensure it's part of your component's state to hide the modal.
            setIsModalVisible(false);
            //reset the form
            setValue({
                time: null,
                exercise: "Running",
                duration: null,
                intensity: "Medium",
                caloriesBurned: 0,
            });
            //setIsConfirmVisible(true);
            // Notifies the user of the successful addition. Ensure `message` is properly imported or defined to display messages.
            message.success('Weight Recording successfully');
        }else{
            message.error('Please fill all the fields');
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
                    <label className='flex flex-col gap-1 w-24'>Exercise:</label>
                    <Dropdown menu={exerciseProps}>
                    <Button>
                        <Space>
                            {value.exercise}
                        <DownOutlined />
                        </Space>
                    </Button>
                    </Dropdown>
                </div>

                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-24'>Duration:</label>
                    <InputNumber 
                        addonAfter=' Minutes' 
                        placeholder='Enter reading value' 
                        required
                        value={value.duration}
                        onChange={v => setValue({...value,duration:v})}
                    />  
                </div>

                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-24'>Calories Burned:</label>
                    <InputNumber 
                        addonAfter=' calories' 
                        placeholder='Enter reading value' 
                        required
                        value={value.caloriesBurned}
                        onChange={v => setValue({...value,caloriesBurned:v})}
                    />  
                </div>

                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-24'>Intensity:</label>
                    <Dropdown menu={intensityProps}>
                    <Button>
                        <Space>
                            {value.intensity}
                        <DownOutlined />
                        </Space>
                    </Button>
                    </Dropdown>
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