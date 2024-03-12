import React from 'react'

// Importing Divider component from Ant Design
import { Divider } from 'antd'

// Component for rendering an introductory card
const IntroCard = ({ icon, count, unit, describe }) => {
    return (
        <div 
            className='max-w-96 backdrop-blur-md bg-tertiary p-8 rounded-3xl flex flex-col'
        >
            {/* Displaying icon, count, and unit */}
            <div className='flex gap-5'>
                <div className='w-16 h-16 bg-white rounded-full flex justify-center items-center'>
                    <div className='text-3xl text-primary'>{icon}</div>
                </div>
                <div className='flex flex-col text-primary'>
                    <div className='text-4xl font-bold'>{count}+</div>
                    <div className='text-lg font-semibold'>{unit}</div>
                </div>
            </div>
            {/* Adding a divider */}
            <Divider />
            {/* Displaying description */}
            <div className='text-primary font-medium'>{describe}</div>
        </div>
    )
}

export default IntroCard
