import React from 'react'

//redux
import { useSelector } from 'react-redux'

//mui chart
import { LineChart } from '@mui/x-charts';

//motion
import { motion } from 'framer-motion';

//components
import DataAddModal from './DataAddModal'

//react
import { useState } from 'react'

const DataVisualization = () => {

  const { insulin } = useSelector(state => state.profile.patientData)

  return(
    <div className='w-full h-96 flex gap-5'>
      <div className='w-96 bg-white rounded-lg shadow-product p-5'>

      </div>
      <div className='flex-1 bg-white rounded-lg shadow-product p-5'>

      </div>

    </div>  
  )

}

const History = () => {

  const { insulin } = useSelector(state => state.profile.patientData)

  return (
    <div className='w-full h-80 bg-white rounded-lg shadow-product p-5'>
      <p className='text-md text-primary font-medium'>History</p>
    </div>
  )
}
const Insulin = () => {

  const [isModalVisible, setIsModalVisible] = useState(false);

  const HandleAddReading = () => {
    return(
      <DataAddModal 
        title='New Insulin Shot' 
        isModalVisible={isModalVisible} 
        setIsModalVisible={setIsModalVisible}>
        <form className='flex flex-col gap-5 h-96'>

          <button type='submit' className='bg-primary mx-5 w-full md:w-40 absolute bottom-12 self-center text-white rounded-lg px-5 py-2'>Save</button>
        
        </form>
      </DataAddModal>
    )
  }

  const [isInsulinInformationVisible, setInsulinInformationVisible] = useState(false);

  const HandleInsulinInformation = () => {

    return(
      <DataAddModal 
        title='New Insulin Information' 
        isModalVisible={isInsulinInformationVisible} 
        setIsModalVisible={setInsulinInformationVisible}>
        <form className='flex flex-col gap-5 h-96'>

          <button type='submit' className='bg-primary mx-5 w-full md:w-40 absolute bottom-12 self-center text-white rounded-lg px-5 py-2'>Save</button>
        
        </form>
      </DataAddModal>
    )
  }


  return (
    <motion.div 
    initial={{ opacity: 0, x: -50 }}
    animate={{ opacity: 1, x: 0 }}
    exit={{ opacity: 0, x: 50 }}
      className='h-full flex flex-col gap-4'>
      <HandleAddReading />
      <HandleInsulinInformation />
      <div className='w-full flex justify-between items-center'>
        <p className='text-2xl text-primary font-medium'>Insulin</p>
        <div className='flex gap-5'>
        <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.9 }}
          onClick={() => setInsulinInformationVisible(true)}
          className=' px-4 py-2 border border-1 shadow-product cursor-pointer'>Add Insulin Information</motion.button>
          <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.9 }}
          onClick={() => setIsModalVisible(true)}
          className=' px-4 py-2 border border-1 shadow-product cursor-pointer'>Add Reading</motion.button>
        </div>
      </div>
      <DataVisualization />
      <History />
    </motion.div>
  )
}

export default Insulin