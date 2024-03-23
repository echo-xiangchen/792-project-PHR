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


const InsulinInformationModal = ({isModalVisible,setIsModalVisible}) => {
    // Utilizes the useDispatch hook from Redux for dispatching actions.
    const dispatch = useDispatch();

    // Initializes state for managing blood glucose readings, including day, time, value, and meal time.
    const [ value, setValue ] = useState({
        insulin: "Apidra",
        regimen: "Basal",
        unit: 0,
    });

    const [ isConfirmVisible, setIsConfirmVisible ] = useState(false);

    // Defines the items for the dropdown menu, each with a unique key and label.
    const insulinitems = [
        { label: 'Apidra', key: '1'},
        { label: 'Lyumjev', key: '2'},
        { label: 'Fiasp', key: '3'},
        { label: 'Novlog', key: '4'},
        { label: 'Humalog', key: '5'},
    ];

    const regimenitems = [
        {
            label: 'Basal',
            key: '1'
        },
        {
            label: 'Bolus',
            key: '2'
        }
    ]

    // Properties for the dropdown menu including the items to display and the onClick event handler.
    const insulinProps = {
        items: insulinitems,
        onClick: (e) => {
            // Filters the items to find the one that matches the clicked item, then updates the mealTime in state.
            const newMenu = insulinitems.filter(item => item.key === e.key);
            setValue({...value, insulin: newMenu[0].label});
        },
    };

    const regimenProps = {
        items: regimenitems,
        onClick: (e) => {
            // Filters the items to find the one that matches the clicked item, then updates the mealTime in state.
            const newMenu = regimenitems.filter(item => item.key === e.key);
            setValue({...value, regimen: newMenu[0].label});
        },
    };

    // Handles the form submission event.
    const handleSubmit = (e) => {
        e.preventDefault(); // Dont reload the page
        if(value.insulin != "" && value.regimen != "" && value.unit != 0){
            // Here you should define `setIsModalVisible` and ensure it's part of your component's state to hide the modal.
            setIsModalVisible(false);


            //reset the form
            setValue({
                insulin: "Apidra",
                regimen: "Basal",
                unit: 0,
            });
            //setIsConfirmVisible(true);
            // Notifies the user of the successful addition. Ensure `message` is properly imported or defined to display messages.
            message.success('Insulin information added successfully');
        }else{
            message.error('Please fill all fields');
        }
    }

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
                    <label className='flex flex-col gap-1 w-24'>Insulin:</label>
                    <Dropdown menu={insulinProps}>
                        <Button>
                            <Space>
                                {value.insulin}
                                <DownOutlined />
                            </Space>
                        </Button>
                    </Dropdown>
                </div>

                
                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-24'>Regimen:</label>
                    <Dropdown menu={regimenProps}>
                        <Button>
                            <Space>
                                {value.regimen}
                            <DownOutlined />
                            </Space>
                        </Button>
                    </Dropdown>
                </div>

                
                <div className='flex gap-5 items-center'>
                    <label className='flex flex-col gap-1 w-24'>Units:</label>
                    <InputNumber 
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
            title='New Insulin Information' 
            isModalVisible={isModalVisible} 
            setIsModalVisible={setIsModalVisible}>
            <Form />
        </DataAddModal>
    )
}

export default InsulinInformationModal;