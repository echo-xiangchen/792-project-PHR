
//react router
import { useLocation } from 'react-router-dom';

//react
import { useState,useEffect } from 'react';


//icon
import { FaHospitalAlt } from "react-icons/fa";
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
import { NavLink } from 'react-router-dom';

const userNav = [
    {
        name: 'Home',
        icon: <HomeFilled />,
        url : '/my-profile'
    },
    {
        name: 'Lab Result',
        icon: <ImLab />,
        url : 'lab-result'
    },
    {
        name: 'Medications',
        icon: <PictureFilled />,
        url : 'medications'
    },
    {
        name: 'Clinical Visits',
        icon: <FaHospitalAlt />,
        url : 'clinical-visits'
    },
]

const dataNav = [
    {
        name: 'Blood Glucose',
        icon: <MdBloodtype />,
        url : 'blood-glucose'
    },
    {
        name: 'Blood Pressure',
        icon: <HeartFilled />,
        url : 'blood-pressure'
    },
    {
        name: "Insulin",
        icon: <GiLoveInjection />,
        url : 'insulin'
    },
    {
        name: "Dietary Intake",
        icon: <MdFastfood />,
        url : 'dietary-intake'
    },
    {
        name: "Exercise",
        icon: <MdOutlineSportsGymnastics />,
        url : 'exercise'
    },
    {
        name: "Weight Control",
        icon: <FaWeightScale />,
        url : 'weight-control'
    }
]

const sideBar = () => {

    //get last url, and set select url
    const location = useLocation();
    
    //get the last part of path
    const pathParts = location.pathname.split('/'); //split path by '/'
    const lastPath = pathParts[pathParts.length - 1];//get last part of path
    const [ active, setActive ] = useState(lastPath);
    if(active == 'my-profile') setActive('/my-profile')

    //set the active path
    useEffect(() => {
        const pathParts = location.pathname.split('/'); //split path by '/'
        const lastPath = pathParts[pathParts.length - 1];//get last part of path
        setActive(lastPath);
        if(active == 'my-profile') setActive('/my-profile')
    },[location])


    return (
        <div className='hidden md:block w-64 p-5'>
            <div className='flex flex-col gap-3 text-lg text-primary'>
            {
                userNav.map((item, index) => (
                    <NavLink key={index} to={item.url} className=''>
                        <div key={index} className={`${active == item.url ? "bg-tertiary" : "hover:bg-tertiary" } flex gap-5 items-center py-2 px-3 select-none cursor-pointer rounded-md`}>
                            {item.icon}
                            <span>{item.name}</span>
                        </div>
                    </NavLink>
                ))
            }
            <Divider />
            {
                dataNav.map((item, index) => (
                    <NavLink key={index} to={item.url} className=''>
                        <div key={index} className={`${active == item.url ? "bg-tertiary" : "hover:bg-tertiary" } flex gap-5 items-center py-2 px-3 select-none cursor-pointer rounded-md`}>
                            {item.icon}
                            <span>{item.name}</span>
                        </div>
                    </NavLink>
                    
                ))
            }
            </div>
            
        </div>
    )
}

export default sideBar