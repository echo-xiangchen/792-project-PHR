import React from 'react'
import { useState } from 'react'
import { motion } from 'framer-motion'
import { NavLink } from 'react-router-dom'
import { pageSetting } from '../styles'
import { useSelector, useDispatch } from 'react-redux';
import { Avatar, message } from 'antd'
import { SendOutlined } from '@ant-design/icons'
import avatarExample from './assets/example.jpg'
import echoAvatar from './assets/echo.jpg'

import UploadBar from '../UploadBar'

const Header = () => {
    return (
        <div className={`w-full flex justify-between items-center h-24`}>
            <div className='text-2xl'>LOGO</div>
            <div className='flex space-x-5 h-10 items-center'>
                <NavLink to="/chat" className="text-xl text-primary">Profile</NavLink>
                <motion.div
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                    onClick={() => {message.success('Logout Success')}}
                    className="bg-primary text-white px-6 py-2 rounded hover:bg-secondary focus:outline-none focus:ring-2 focus:ring-secondary focus:ring-opacity-50"
                >
                    <NavLink to="/">Logout</NavLink>
                </motion.div>
            </div>
        </div>
    )
}

function displayTime(inputDate) {
    const inputDateTime = new Date(inputDate);
    const now = new Date();
    // Check if the input date is the same as the current date
    if (inputDateTime.toDateString() === now.toDateString()) {
      // Display time in HH:MM format
        return inputDateTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    }
    // Display month and day
    return inputDateTime.toLocaleDateString([], { month: '2-digit', day: '2-digit' });
}

const CharBubble = ({type,avatar,text, time}) => {

    if(type === 'Diabetes report'){


    }

    
    // If is User
    if(avatar === echoAvatar){
        return(
            <div className='self-end flex flex-row gap-3'>
                <div className='flex justify-end flex-col max-w-96 gap-2'>
                    <div className='bg-secondary text-white p-2 rounded-tl-2xl rounded-tr-2xl rounded-bl-2xl rounded-br-md'>{text}</div>
                    <div className='self-end text-xs text-gray-500'>{displayTime(time)}</div>
                </div>
                <Avatar src={avatar} size={40} />
            </div>
        )
    }

    return(
        <div className='flex flex-row gap-3'>
            <Avatar src={avatar} size={40} />
            <div className='flex justify-start flex-col max-w-96 gap-2'>
                <div className='bg-primary text-white p-2 rounded-tl-2xl rounded-tr-2xl rounded-bl-md rounded-br-2xl'>{text}</div>
                <div className='text-xs text-gray-500'>{displayTime(time)}</div>
            </div>
        </div>
    )

}

const Conversation = () => {
    // Get the messages from the Redux store
    const messages = useSelector((state) => state.chat.messages);
    //send message

    return (
        <div className='flex flex-col gap-7'>
            {messages.length === 0 ? 
                <div className='text-center text-2xl'>No messages yet</div>
                :
                messages.map((message, index) => (
                    <CharBubble avatar={message.avatar} text={message.text} time={message.time} key={index}/>
                ))
            }
        </div>
    )


}



const Chat = () => {
    return (
        <>
        <div className={`w-full flex flex-col ${pageSetting.padding}`}>
            <Header />
            <div className='self-center w-full 2xl:w-[1200px]'>
                <Conversation/>
            </div>
            
        </div>
        <div className='w-full h-96'>
            
        </div>
        <div className={`fixed bottom-6 w-full flex justify-center ${pageSetting.padding}`}>
            <div className='w-full 2xl:w-[1200px]'>
                <UploadBar />
            </div>
        </div>
    </>
    )
}
export default Chat