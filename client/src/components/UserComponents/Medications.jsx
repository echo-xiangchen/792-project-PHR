import React from 'react'

//motion
import { motion } from 'framer-motion';

//redux
import { useSelector,useDispatch } from 'react-redux'

const FilterResult = ({medications}) => {
  if(medications.count === 0){
    return (
      <p className='text-md text-primary font-medium'>No Medications</p>
    )
  } 
  return(
    <div className='w-full flex flex-wrap gap-5'>
      {medications.map(medication => {
        return (
          <div key={medication.id} className='w-80 bg-white rounded-lg shadow-product p-5'>
            test
          </div>
        )
      })}
    </div>
  )
}

const Medications = () => {

  const { medications } = useSelector(state => state.profile.patientData)


  return (
    <motion.div 
    initial={{ opacity: 0, x: -50 }}
    animate={{ opacity: 1, x: 0 }}
    exit={{ opacity: 0, x: 50 }}
      className='flex flex-col gap-5'>
      <p className='text-2xl text-primary font-medium'>Medications</p>
      <div className='w-full bg-white rounded-lg shadow-product p-5'>
        <p className='text-md text-primary font-medium'>Filters</p>
      </div>
      
      <FilterResult medications={medications} />

    </motion.div>
  )
}

export default Medications