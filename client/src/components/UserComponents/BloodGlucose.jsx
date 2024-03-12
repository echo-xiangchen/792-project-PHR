import React from 'react'
//react
import { useState } from 'react' // Importing useState hook from React

//redux
import { useSelector } from 'react-redux' // Importing useSelector hook from React Redux to access the Redux store

//mui chart
import { LineChart } from '@mui/x-charts'; // Importing LineChart component from MUI X Charts

//motion
import { motion } from 'framer-motion'; // Importing motion components from Framer Motion library

//components
import DataAddModal from './DataAddModal' // Importing DataAddModal component

// Component for data visualization
const DataVisualization = () => {

  const { bloodGlucose } = useSelector(state => state.profile.patientData) // Accessing blood glucose data from Redux store

  return(
    <div className='w-full h-96 flex gap-5'>
      <div className='w-96 bg-white rounded-lg shadow-product p-5'>

      </div>
      <div className='flex-1 bg-white rounded-lg shadow-product p-5'>

      </div>

    </div>  
  )

}

// Component for displaying data history
const History = () => {

  const { bloodGlucose } = useSelector(state => state.profile.patientData) // Accessing blood glucose data from Redux store

  return (
    <div className='w-full h-80 bg-white rounded-lg shadow-product p-5'>
      <p className='text-md text-primary font-medium'>History</p>
    </div>
  )
}


// Component for blood glucose section
const BloodGlucose = () => {

  const { bloodGlucose } = useSelector(state => state.profile.patientData) // Accessing blood glucose data from Redux store

  //modal
  const [isModalVisible, setIsModalVisible] = useState(false); // State for managing modal visibility

  const HandleAddReading = () => {

    return(
      <DataAddModal 
        title='Add Blood Glucose Reading' 
        isModalVisible={isModalVisible} 
        setIsModalVisible={setIsModalVisible}>
        <form className='flex flex-col gap-5 h-96'>

          <button type='submit' className='bg-primary mx-5 w-full md:w-40 absolute bottom-12 self-center text-white rounded-lg px-5 py-2'>Save</button>
        </form>
      </DataAddModal>
    )
  }

  //switch to date object
  const formattedData = bloodGlucose.map(item => {
    return {
      time: new Date(item.time),
      value: item.value
    }
  });

  return (
    <motion.div 
    initial={{ opacity: 0, x: -50 }}
    animate={{ opacity: 1, x: 0 }}
    exit={{ opacity: 0, x: 50 }}
      className='h-full flex flex-col gap-4'>
      
      <HandleAddReading />
      <div className='w-full flex justify-between items-center'>
        <p className='text-2xl text-primary font-medium'>Blood Glucose</p>
        <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.9 }}
          onClick={()=>setIsModalVisible(true)}
          className=' px-4 py-2 border border-1 shadow-product cursor-pointer'>Add Reading</motion.button>
      </div>
      <DataVisualization />
      <History />
    </motion.div>
  )
}

export default BloodGlucose
