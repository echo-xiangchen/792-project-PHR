import React from 'react'

//react
import { useState } from 'react'

//motion
import { motion } from 'framer-motion';

//antd
import { Button, Dropdown, Space } from 'antd';

//icons
import { DownOutlined, LeftOutlined, RightOutlined } from '@ant-design/icons';

//function
import { timeToString } from './Utils';


const items = [
    { label: '1 day', key: 'day'},
    { label: '1 week', key: 'week'},
    { label: '1 month', key: 'month'},
    { label: '1 year', key: 'year'},
];

/**
 * Time picker component
 *  - timePicker: state for managing time picker
 *  - setTimePicker: function for setting the time picker
 *  - dataPeriod: state for managing data period
 *  - setDataPeriod: function for setting the data period
 * 
 * @param {*} param0 
 * @returns 
 */
const TimePick = ({timePicker, setTimePicker, dataPeriod,setDataPeriod}) => {

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

    return (
        <div className='flex flex-col gap-3'>
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
        </div>
    )
}

export default TimePick