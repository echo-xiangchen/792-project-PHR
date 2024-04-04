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

//moment
import moment from 'moment';


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
        switch(timePicker) {
            case '1 day':
                setDataPeriod({
                    startTime: dataPeriod.startTime.clone().add(1, 'day'),
                    endTime: dataPeriod.endTime.clone().add(1, 'day')
                })
                break;
            case '1 week':
                setDataPeriod({
                    startTime: dataPeriod.startTime.clone().add(1, 'week'),
                    endTime: dataPeriod.endTime.clone().add(1, 'week')
                })
                break;
            case '1 month':
                setDataPeriod({
                    startTime: dataPeriod.startTime.clone().add(1, 'month'),
                    endTime: dataPeriod.endTime.clone().add(1, 'month')
                })
                break;
            case '1 year':
                setDataPeriod({
                    startTime: dataPeriod.startTime.clone().add(1, 'year'),
                    endTime: dataPeriod.endTime.clone().add(1, 'year')
                })
                break;
            default:
                return;
        }
    };

    const previousPeriod = () => {
        switch(timePicker) {
            case '1 day':
                setDataPeriod({
                    startTime: dataPeriod.startTime.clone().subtract(1, 'day'),
                    endTime: dataPeriod.endTime.clone().subtract(1, 'day')
                })
                break;
            case '1 week':
                setDataPeriod({
                    startTime: dataPeriod.startTime.clone().subtract(1, 'week'),
                    endTime: dataPeriod.endTime.clone().subtract(1, 'week')
                })
                break;
            case '1 month':
                setDataPeriod({
                    startTime: dataPeriod.startTime.clone().subtract(1, 'month'),
                    endTime: dataPeriod.endTime.clone().subtract(1, 'month')
                })
                break;
            case '1 year':
                setDataPeriod({
                    startTime: dataPeriod.startTime.clone().subtract(1, 'year'),
                    endTime: dataPeriod.endTime.clone().subtract(1, 'year')
                })
                break;
            default:
                return;
        }
    };

    const handleDropdown = (e) => {
        const newMenu = items.filter(item => item.key === e.key);
        setTimePicker(newMenu[0].label); //new time picker

        //update the start time and end time based on the new time picker
        switch(newMenu[0].label) {
            case '1 day':
                setDataPeriod({
                    startTime: moment().subtract(1, 'day'),
                    endTime: moment()
                })
                break;
            case '1 week':
                setDataPeriod({
                    startTime: moment().subtract(6, 'days'),
                    endTime: moment().add(1, 'days')
                })
                break;
            case '1 month':
                setDataPeriod({
                    startTime: moment().subtract(1, 'month'),
                    endTime: moment().add(1, 'days')
                })
                break;
            case '1 year':
                setDataPeriod({
                    startTime: moment().subtract(1, 'year'),
                    endTime: moment().add(1, 'days')
                })
                break;
            default:
                return;
        }
    };

    //dropdown menu props
    const menuProps = {
        items,
        onClick: handleDropdown,
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
                <span className='text-sm'>{moment(dataPeriod.startTime).format('MMMM DD, YYYY')} - {moment(dataPeriod.endTime).format('MMMM DD, YYYY')}</span>
            </div>
        </div>
    )
}

export default TimePick