import React from 'react'

//antd
import { Divider } from 'antd'

const IntroCard = ({icon, count, unit, describe}) => {
  return (
    <div 
        className='max-w-96 backdrop-blur-md bg-tertiary p-8 rounded-3xl flex flex-col'

    >
        <div className='flex gap-5'>
            <div className='w-16 h-16 bg-white rounded-full flex justify-center items-center'>
                <div className='text-3xl text-primary'>{icon}</div>
            </div>
            <div className='flex flex-col text-primary'>
                <div className='text-4xl font-bold'>{count}+</div>
                <div className='text-lg font-semibold'>{unit}</div>
            </div>
        </div>
        <Divider />
        <div className='text-primary font-medium'>{describe}</div>
    </div>
  )
}

export default IntroCard