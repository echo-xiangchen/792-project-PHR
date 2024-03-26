
// Import necessary libraries and components
import DataAddModal from './DataAddModal'
import { useState } from 'react'
import { useDispatch } from 'react-redux';
import { addDietaryIntake } from '../../redux/slices/profileSlice' // Importing addBloodGlucose action from patientDataActions
import { 
    message, 
    DatePicker, 
    InputNumber, 
    Input,
    Dropdown,
    Button,
    Space,
    TimePicker,
} from 'antd';

import { DownOutlined } from '@ant-design/icons';

import moment from 'moment';


const DietaryIntakeModal = ({isModalVisible,setIsModalVisible}) => {

    // Utilizes the useDispatch hook from Redux for dispatching actions.
    const dispatch = useDispatch();

    // Initializes state for managing blood glucose readings, including day, time, value, and meal time.
    const [ value, setValue ] = useState({
        time: null,
        mealType: "Unspecified",
        food: "",
        numServings: 0,
        size: "grams",
        carbs: 0,
        calories: 0,
    });

    const [ isConfirmVisible, setIsConfirmVisible ] = useState(false);

    const [unit, setUnit] = useState("grams");

    // Handles changes to the time input by updating the state.
    const timeOnChange = (date, dateString) => {
        setValue({...value, time: dateString});
    }

    const mealMenu = [
        { key: 'Breakfast', label: 'Breakfast' },
        { key: 'Lunch', label: 'Lunch' },
        { key: 'Dinner', label: 'Dinner' },
        { key: 'Snack', label: 'Snack' },
        { key: 'Unspecified', label: 'Unspecified' },
    ];

    const sizeMenu = [
        { key: 'grams', label: 'grams' },
        { key: 'ounces', label: 'ounces' },
        { key: 'cups', label: 'cups' },
        { key: 'pieces', label: 'pieces' },
    ];

    const mealProps = {
        items: mealMenu,
        onClick: (e) => {
            setValue({...value, mealType: e.key});
        },
    }

    const sizeProps = {
        items: sizeMenu,
        onClick: (e) => {
            setValue({...value, size: e.key});
        },
    }

    const foodOnChange = (e) => {
        setValue({...value, food: e.target.value});
    }

    const numServingsOnChange = (v) => {
        setValue({...value, numServings: v});
    }

    const sizeOnChange = (v) => {
        setValue({...value, size: v});
    }

    const carbOnChange = (v) => {
        setValue({...value, carb: v});
    }

    const caloriesOnChange = (v) => {
        setValue({...value, calories: v});
    }

    // Handles the form submission event.
    const handleSubmit = (e) => {
        e.preventDefault(); // Dont reload the page
        if( value.time && value.food !== "" && value.numServings !== 0 && value.carbs !== 0 && value.calories !== 0){
            // Prepares the blood glucose reading object with a unique ID, the combined timestamp, and the value.
            const reading = {
                id: `BG-20230707${Date.now()}`,
                time: value.time,
                mealType: value.mealType,
                food: value.food,
                numServings: value.numServings,
                size: value.size,
                carbs: value.carbs,
                calories: value.calories,
            }
            // Dispatches an action to add the blood glucose reading to the Redux store.
            dispatch(addDietaryIntake(reading));
            // Here you should define `setIsModalVisible` and ensure it's part of your component's state to hide the modal.
            setIsModalVisible(false);
            //reset the form
            setValue({
                    time: null,
                    mealType: "Unspecified",
                    food: "",
                    numServings: 0,
                    size: "grams",
                    carbs: 0,
                    calories: 0,
            });
            //setIsConfirmVisible(true);
            // Notifies the user of the successful addition. Ensure `message` is properly imported or defined to display messages.
            message.success('Dietary Intake Recording successfully');
        }else{
            message.error('Please fill all the fields');
        }
    }

    const Form = () => {
        return(
            <form className='flex flex-col gap-5 h-[500px] p-5'>

                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-36'>Time:</label>
                    <DatePicker 
                        value={value.time ? moment(value.time, "YYYY-MM-DD") : null} 
                        onChange={timeOnChange} 
                        required
                    />
                </div>

                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-36'>meal Type:</label>
                    <Dropdown menu={mealProps}>
                        <Button>
                            <Space>
                                {value.mealType}
                                <DownOutlined />
                            </Space>
                        </Button>
                    </Dropdown>
                </div>

                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-64'>food:</label>
                    <Input 
                        placeholder='Enter Food Name' 
                        required
                        value={value.food}
                        onChange={foodOnChange}
                    />  
                </div>

                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-36'>Number of Servings:</label>
                    <InputNumber 
                        placeholder='Enter reading value' 
                        required
                        value={value.numServings}
                        onChange={v => setValue({...value,numServings:v})}
                    />  
                </div>

                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-36'>Serving Size:</label>
                    <Dropdown menu={sizeProps}>
                    <Button>
                        <Space>
                            {value.size}
                        <DownOutlined />
                        </Space>
                    </Button>
                    </Dropdown>
                </div>

                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-36'>carbs:</label>
                    <InputNumber 
                        placeholder='Enter reading value' 
                        required
                        value={value.carbs}
                        onChange={v => setValue({...value,carbs:v})}
                    />  
                </div>

                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-36'>calories:</label>
                    <InputNumber 
                        placeholder='Enter reading value' 
                        required
                        value={value.calories}
                        onChange={v => setValue({...value,calories:v})}
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
            title='New Dietary Intake' 
            isModalVisible={isModalVisible} 
            setIsModalVisible={setIsModalVisible}>
            <Form />
        </DataAddModal>
    )
}

export default DietaryIntakeModal;