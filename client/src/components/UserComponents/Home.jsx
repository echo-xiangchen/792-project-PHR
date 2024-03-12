import React from 'react'

// Importing useMemo and useState hooks from React
import { useMemo, useState } from 'react'

// Importing useDispatch and useSelector hooks from React Redux
import { useDispatch, useSelector } from 'react-redux'

// Importing icons
import { HeartFilled } from '@ant-design/icons';
import { MdBloodtype } from "react-icons/md";
import { FaW, FaWeightScale } from "react-icons/fa6";

// Importing Tooltip component from Ant Design
import { Tooltip } from 'antd';

// Importing motion components from Framer Motion library
import { motion } from 'framer-motion';

// Component for displaying user information
const UserInfo = ({basicInfo}) => {

  // Sub-component for displaying individual information items
  const Info = ({tag, value}) => (
    <div className='flex-1 flex flex-col gap-1 items-center'>
      <span>{tag}:</span><span>{value}</span>
    </div>
  )

  return (
    <div className='w-80 h-full flex flex-col gap-5 bg-white rounded-lg shadow-product p-5  text-primary'>
      
      <div className='flex flex-col justify-center items-center gap-3'>
        {/* Displaying user avatar, name, gender, age, height, and blood type */}
        <img src={basicInfo.avatar} alt="user" className='w-24 h-24 rounded-lg mx-auto'/>
        <h1 className='text-xl text-center'>{basicInfo.firstName} {basicInfo.lastName}</h1>
        <div className='w-full flex gap-3 justify-center items-center'>
          <Info tag="Gender" value={basicInfo.gender} />
          <Info tag="Age" value={basicInfo.age} />
        </div>
        <div className='w-full flex gap-3 items-center'>
          <Info tag="Height" value={basicInfo.height} />
          <Info tag="Blood Type" value={basicInfo.bloodType} />
        </div>
      </div>
      
    </div>
  )
}

// Component for displaying result card
const ResultCard = ({ icon, time, title, children}) => {
  const [arrow, setArrow] = useState('Show');

  // Merging tooltip arrow configuration using useMemo
  const mergedArrow = useMemo(() => {
    if (arrow === 'Hide') {
      return false;
    }
    if (arrow === 'Show') {
      return true;
    }
    return {
      pointAtCenter: true,
    };
  }, [arrow]);

  return (
    <div className='max-h-64 bg-white text-primary rounded-lg shadow-product p-5 min-w-64 flex flex-col gap-10'>
      <div className='flex gap-3 items-center'>
        {/* Displaying result card icon, title, and last record time */}
        <div className='text-4xl text-secondary'>{icon}</div>
        <div>
          <h1 className='text-lg'>{title}</h1>
          <Tooltip placement="topLeft" title="Last record you submit" arrow={mergedArrow}>
            <p className='text-sm'><span className='font-semibold'>{time}</span></p>
          </Tooltip>
        </div>
      </div>
      {children}
    </div>
  )
}

// Component for displaying patient data
const PatientData = ({patientData}) => {
  return(
    <div className='flex-1 flex gap-6 flex-wrap'>
      {/* Displaying result cards for blood glucose, blood pressure, and weight */}
      <ResultCard icon={<MdBloodtype />} time='2021-07-07, 12:30pm' title='Blood Glucose'>
        <p>Value: <span>106 mg/dL</span></p>
        <p className='text-success'>In range</p>
      </ResultCard>
      <ResultCard icon={<HeartFilled/>} time='2021-07-07, 12:30pm' title='Blood Pressure'>
        <p>Value: <span>120/85 mmHg</span></p>
        <p className='text-error'>Out of range</p>
      </ResultCard>
      <ResultCard icon={<FaWeightScale/>} time='2021-07-07, 12:30pm' title='Weight'>
        <p>Value: <span>175 lbs</span></p>
        <p className='text-success'>In range</p>
      </ResultCard>
    </div>
  )
}

// Component for the home page
const Home = () => {

  // Accessing user basic information and patient data from Redux store
  const {basicInfo, patientData} = useSelector(state => state.profile)

  return (
    <motion.div 
    initial={{ opacity: 0, x: -50 }}
    animate={{ opacity: 1, x: 0 }}
    exit={{ opacity: 0, x: 50 }}
      className='h-full flex flex-col gap-4'>
      {/* Displaying welcome message */}
      <p className='text-2xl text-primary font-medium'>Welcome back, {basicInfo.firstName}</p>
      <div className='h-full flex gap-12'>
        {/* Displaying user information and patient data */}
        <UserInfo basicInfo={basicInfo} />
        <PatientData patientData={patientData} />
      </div>
    </motion.div>
  )
}

export default Home
