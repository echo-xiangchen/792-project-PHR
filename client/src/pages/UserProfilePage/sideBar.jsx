
//react router
import { useLocation } from 'react-router-dom';

//react
import { useState,useEffect } from 'react';

//Navigation
import { userNav,iconMap,dataNav } from './../../constants';

//antd
import { 
    message,
    Divider,
} from 'antd';
import { NavLink } from 'react-router-dom';

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
                            {iconMap[item.name]}
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
                            {iconMap[item.name]}
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