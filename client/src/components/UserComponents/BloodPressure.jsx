// Importing useState hook from React for managing component state
import { useState } from 'react'

// Importing useSelector hook from React Redux for accessing the Redux store
import { useSelector } from 'react-redux'

// Importing LineChart component from MUI X Charts for displaying charts
import { LineChart } from '@mui/x-charts';

// Importing motion components from Framer Motion library for animations
import { motion } from 'framer-motion';

// Importing DataAddModal component for adding new data
import DataAddModal from './DataAddModal'

// Component for data visualization
const DataVisualization = () => {

  // Accessing blood pressure data from Redux store
  const { bloodPressure } = useSelector(state => state.profile.patientData)

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

  // Accessing blood pressure data from Redux store
  const { bloodPressure } = useSelector(state => state.profile.patientData)

  return (
    <div className='w-full h-80 bg-white rounded-lg shadow-product p-5'>
      <p className='text-md text-primary font-medium'>History</p>
    </div>
  )
}

// Component for blood pressure section
const BloodPressure = () => {

  // Accessing blood pressure data from Redux store
  const { bloodPressure } = useSelector(state => state.profile.patientData)

  // State for managing modal visibility
  const [isModalVisible, setIsModalVisible] = useState(false);

  // Function to handle adding new blood pressure reading
  const HandleAddReading = () => {

    return(
      <DataAddModal 
        title='Add Blood Pressure Reading' 
        isModalVisible={isModalVisible} 
        setIsModalVisible={setIsModalVisible}>
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
      <div className='w-full flex justify-between items-center'>
        <p className='text-2xl text-primary font-medium'>Blood Pressure</p>
        <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.9 }}
          onClick={() => setIsModalVisible(true)}
          className=' px-4 py-2 border border-1 shadow-product cursor-pointer'>Add Reading</motion.button>
      </div>
      <DataVisualization />
      <History />
    </motion.div>
  )
}

export default BloodPressure
