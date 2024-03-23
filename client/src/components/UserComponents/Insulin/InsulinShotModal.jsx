// Import necessary libraries and components
import DataAddModal from '../DataAddModal'
import { useState } from 'react'
import { useDispatch } from 'react-redux';
import { addInsulin } from '../../../redux/slices/profileSlice' // Importing addBloodGlucose action from patientDataActions
import { message, DatePicker, TimePicker, InputNumber, Dropdown, Button, Space } from 'antd';
import { DownOutlined } from '@ant-design/icons';
import moment from 'moment';
import { timeFormat } from '../Utils';
import { motion } from 'framer-motion';


const InsulinShotModal = ({isModalVisible,setIsModalVisible}) => {

    // Utilizes the useDispatch hook from Redux for dispatching actions.
    const dispatch = useDispatch();

    // Initializes state for managing addInsulin readings, including day, time, value, and meal time.
    const [ value, setValue ] = useState({
        day: null,
        time: null,
        type: "Apidra  (Bolus)",
        unit: 0,
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
        if(value.day && value.time && value.type !== "" && value.unit !== 0){
            // Combines the day and time into a single timestamp.
            const uploadTime = value.day + 'T' + value.time;
            // Prepares the blood glucose reading object with a unique ID, the combined timestamp, and the value.
            const reading = {
                id: `BP-20230707${Date.now()}`,
                time: uploadTime,
                type: value.type,
                unit: value.unit,
            }

            console.log(reading);

            // Dispatches an action to add the blood glucose reading to the Redux store.
            dispatch(addInsulin(reading));
            // Here you should define `setIsModalVisible` and ensure it's part of your component's state to hide the modal.
            setIsModalVisible(false);
            //reset the form
            setValue({
                day: null,
                time: null,
                type: "Apidra  (Bolus)",
                unit: 0,
            });
            //setIsConfirmVisible(true);
            // Notifies the user of the successful addition. Ensure `message` is properly imported or defined to display messages.
            message.success('New Insulin shot added successfully');
        }
    }

    // Defines the items for the dropdown menu, each with a unique key and label.
    const items = [
        { label: 'Apidra  (Bolus)', key: '1',value: 'Bolus'},
        { label: 'Lyumjev  (Bolus)', key: '2',value: 'Bolus'},
        { label: 'Fiasp  (Bolus)', key: '3',value: 'Bolus'},
        { label: 'Novlog  (Bolus)', key: '4',value: 'Bolus'},
        { label: 'Humalog  (Bolus)', key: '5',value: 'Bolus'},
        { label: 'Apidra  (Basal)', key: '6',value: 'Basal'},
        { label: 'Lyumjev  (Basal)', key: '7',value: 'Basal'},
        { label: 'Fiasp  (Basal)', key: '8',value: 'Basal'},
        { label: 'Novlog  (Basal)', key: '9',value: 'Basal'},
        { label: 'Humalog  (Basal)', key: '10',value: 'Basal'},
    ];

    const menuProps = {
        items,
        onClick: (e) => {
            // Filters the items to find the one that matches the clicked item, then updates the mealTime in state.
            const newMenu = items.filter(item => item.key === e.key);
            setValue({...value, type: newMenu[0].label});
        },
    };


    const DataConfirmation = () => {
        return(
            <div className='flex flex-col h-96 py-5'>
                DataConfirmation
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
                    <label className='flex flex-col gap-1 w-24'>Regimen:</label>
                    <Dropdown menu={menuProps}>
                    <Button>
                        <Space>
                            {value.type}
                        <DownOutlined />
                        </Space>
                    </Button>
                    </Dropdown>
                </div>

                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-24'>Unit:</label>
                    <InputNumber 
                        addonAfter='bpm' 
                        placeholder='Enter reading value' 
                        required
                        value={value.unit}
                        onChange={v => setValue({...value,unit:v})}
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
            title='New Insulin shot' 
            isModalVisible={isModalVisible} 
            setIsModalVisible={setIsModalVisible}>
            <Form />
        </DataAddModal>
    )
}

export default InsulinShotModal