import React from 'react'

//motion
import { motion } from 'framer-motion';

const DietaryIntake = () => {
  return (
    <motion.div 
      initial={{ opacity: 0, x: -50 }}
      animate={{ opacity: 1, x: 0 }}
      exit={{ opacity: 0, x: 50 }}
      className='h-full flex flex-col gap-4'>
        DietaryIntake
    </motion.div>
  )
}

export default DietaryIntake