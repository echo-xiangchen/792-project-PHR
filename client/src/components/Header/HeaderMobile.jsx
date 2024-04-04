import React from 'react';

//react
import { useState } from 'react'

import { NavLink } from 'react-router-dom';

//style
import { pageSetting } from '../../styles'

//redux
import { useSelector,useDispatch } from 'react-redux';
import { logout } from '../../redux/slices/authSlice';

//Navigation
import { userNav,iconMap,dataNav } from './../../constants';


//icon
import {  FiLogOut  } from 'react-icons/fi'
import { AiOutlineMenu } from "react-icons/ai";
//antd
import { Drawer, message,Badge } from 'antd';

// Array containing navigation items for authenticated users
const DrawerNav = ({isOpen, setIsOpen}) => {

  // logout the user
  const dispatch = useDispatch();
  
  const handleSignOut = () => {
    dispatch(signOut());
    message.success('Sign out successfully');
}

  return(
    <Drawer 
      title="User Menu" 
      placement="right" 
      open={isOpen} 
      onClose={() => setIsOpen(false)}
      width={window.innerWidth}
      >
        <div className='w-full flex flex-col justify-center gap-5'>
        {userNav.map((item,index) => {
            return(
            <NavLink
                onClick={() => setIsOpen(false)}
                to={item.url}
                key={index}
                className="w-full rounded-md relative overflow-hidden shadow-list">
                <div className="flex items-center gap-5 text-md justify-start px-4 py-3 text-primary">
                <span className='text-lg'>{iconMap[item.name]}</span>
                <span> {item.name}</span>
                </div>
            </NavLink>
            )
        })}
        <hr />
        {dataNav.map((item,index) => {
            return(
            <NavLink
                onClick={() => setIsOpen(false)}
                to={item.url}
                key={index}
                className="w-full rounded-md relative overflow-hidden shadow-list">
                <div className="flex items-center gap-5 text-md justify-start px-4 py-3 text-primary">
                  <span className='text-lg'>{iconMap[item.name]}</span>
                  <span> {item.name}</span>
                </div>
            </NavLink>
            )
        })}
        <hr />
        <NavLink
            to='/'
            onClick={handleSignOut}
            className="w-full rounded-md relative overflow-hidden shadow-list">
            <div className="flex items-center gap-5 text-md justify-start px-4 py-3 text-primary">
            <span className='text-lg'><FiLogOut /></span>
            <span >Logout</span>
            </div>
        </NavLink>
        </div>
    </Drawer>
  )
}


// Component to display company logo
const LOGO = ({color}) => (
  <NavLink to={'/'} className={`${color} flex flex-col gap-0 items-center`}>
      <span className='text-2xl font-bold border-b border-b-primary'>P H R</span>
      <span className='text-[0.4rem] font-bold'>our project in 792</span>
  </NavLink>
)

// HeaderMobile component for displaying the header on mobile devices
const HeaderMobile = () => {

  // Check if the user is logged in
  const isAuthenticated = useSelector(state => state.auth.isAuthenticated);
  // open the user navigation
  const [isOpen, setIsOpen] = useState(false);

  // If the user is not login
  if (!isAuthenticated) {
    return (
      <header className={`${pageSetting.padding} flex md:hidden z-10 py-5 h-12`}>
        <LOGO color='text-primary' />
      </header> 
    );
  }

  // If the user is logged in
  return (
    <header className={`${pageSetting.padding} flex justify-between md:hidden z-10 py-5 h-12`}>
      <LOGO color='text-primary' />
      <div onClick={() => setIsOpen(!isOpen)}>
        <AiOutlineMenu />
      </div>
      <DrawerNav isOpen={isOpen} setIsOpen={setIsOpen} />
    </header> 
  );
}

export default HeaderMobile; // Export the HeaderMobile component
