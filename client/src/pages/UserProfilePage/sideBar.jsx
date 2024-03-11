import React from 'react'



//icon
import { FaHospitalAlt } from "react-icons/fa";
import {  FiLogOut  } from 'react-icons/fi'
import { ImLab } from "react-icons/im";
import { HomeFilled,PictureFilled,HeartFilled } from '@ant-design/icons';
import { MdBloodtype } from "react-icons/md";
import { GiLoveInjection } from "react-icons/gi";
import { MdFastfood } from "react-icons/md";
import { MdOutlineSportsGymnastics } from "react-icons/md";
import { FaWeightScale } from "react-icons/fa6";

//antd
import { 
    message,
    Divider,
} from 'antd';

const userNav = [
    {
        name: 'Home',
        icon: <HomeFilled />,
        url : 'my-profile'
    },
    {
        name: 'Lab Result',
        icon: <ImLab />,
        url : 'my-profile/lab-result'
    },
    {
        name: 'Medications',
        icon: <PictureFilled />,
        url : 'my-profile/medications'
    },
    {
        name: 'Clinical Visits',
        icon: <FaHospitalAlt />,
        url : 'my-profile/clinical-visits'
    },
]

const dataNav = [
    {
        name: 'Blood Glucose',
        icon: <MdBloodtype />,
        url : 'my-profile/blood-glucose'
    },
    {
        name: 'Blood Pressure',
        icon: <HeartFilled />,
        url : 'my-profile/blood-pressure'
    },
    {
        name: "Insulin",
        icon: <GiLoveInjection />,
        url : 'my-profile/insulin'
    },
    {
        name: "Dietary Intake",
        icon: <MdFastfood />,
        url : 'my-profile/dietary-intake'
    },
    {
        name: "Exercise",
        icon: <MdOutlineSportsGymnastics />,
        url : 'my-profile/exercise'
    },
    {
        name: "Weight Control",
        icon: <FaWeightScale />,
        url : 'my-profile/weight-control'
    }
]

const sideBar = () => {

    

    return (
        <div className='w-64 rounded-lg shadow-product p-5'>
            <div className='flex flex-col gap-3 text-lg '>
            {
                userNav.map((item, index) => (
                    <div key={index} className='flex gap-5 items-center py-2 px-3 hover:bg-tertiary select-none cursor-pointer rounded-md'>
                        {item.icon}
                        <span>{item.name}</span>
                    </div>
                ))
            }
            <Divider />
            {
                dataNav.map((item, index) => (
                    <div key={index} className='flex gap-5 items-center py-2 px-3 hover:bg-tertiary select-none cursor-pointer rounded-md'>
                        {item.icon}
                        <span>{item.name}</span>
                    </div>
                ))
            }
            </div>
            
        </div>
    )
}

export default sideBar