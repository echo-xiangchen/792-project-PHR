import { useState } from 'react'; // Import useState hook from React

import { motion } from 'framer-motion'; // Import motion from Framer Motion library

import { NavLink } from 'react-router-dom'; // Import NavLink component from React Router

import { pageSetting } from '../../styles'; // Import pageSetting from styles

import { StarFilled, CalendarOutlined } from '@ant-design/icons'; // Import icons
import { FaHospitalAlt } from "react-icons/fa";

import IntroCard from './IntroCard'; // Import IntroCard component

// Button component with motion animation
const Btn = ({ to, icon, str }) => {
    return (
        <motion.button
            whileTap={{ scale: 0.98 }}
            className="w-full flex gap-5 items-center bg-secondary hover:bg-primary ease-in duration-100 text-white px-3 py-4 rounded-lg shadow-product justify-center"
        >
            {icon && icon}
            <NavLink to={to}>{str}</NavLink>
        </motion.button>
    );
}

// Title component for main page
const Title = () => {
    return (
        <div className={`${pageSetting.padding} pt-48 h-[600px] bg-gradient-to-b ${pageSetting.backgroundColor}`}>
            <div className='flex w-full h-full items-center justify-start'>
                <div className='flex-1 h-full flex flex-col gap-7'>
                    <div className='flex flex-col'>
                        <span className='text-[2rem] 2xl:text-[3.5rem] font-bold text-primary'>
                            Quality & Expert
                        </span>
                        <span className='text-[2rem] 2xl:text-[3.5rem] font-bold text-primary'>
                            Care For Your <span className='text-secondary'>Health</span>
                        </span>
                    </div>
                    <p className='text-primary text-xl font-semibold'>We will record your various bodily metrics and provide guidance from professional doctors.</p>
                    <div className='w-48'>
                        <Btn className="text-xl" str="Appointment" icon={<CalendarOutlined />} to='/appointment'/>
                    </div>
                </div>
                <div className='hidden md:flex flex-1 h-full '>
                    <span className='text-[3.5rem] font-bold text-primary'></span>
                </div>
            </div>
        </div>
    );
}

// MainPage component
const MainPage = () => {

    // Array of highlighted features
    const highLight = [
        {
            icon: <StarFilled />,
            count: 20,
            unit: "Year",
            describe: "More than 15 years of Dedication to Exceptional Healthcare Excellence."
        },
        {
            icon: <FaHospitalAlt />,
            count: 10,
            unit: "Clinic",
            describe: "Proudly Serving You through Our Numerous State-of-the-Art Medical Centers at Hospitalia."
        },
        {
            icon: <CalendarOutlined />,
            count: 50,
            unit: "Doctors",
            describe: "Our Hospital, Home to a Multitude of Skilled Doctors and Specialties."
        },
    ];   

    return(
        <div>
            <Title /> {/* Render Title component */}
            <div className={`${pageSetting.padding} w-full flex flex-col md:flex-row gap-10 justify-between items-center`}>
                {/* Render IntroCard component for each highlighted feature */}
                {highLight.map((item, index) => (
                    <IntroCard key={index} icon={item.icon} count={item.count} unit={item.unit} describe={item.describe} />
                ))}
            </div>
        </div>
    );
}

export default MainPage; // Export the MainPage component
