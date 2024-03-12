import React from 'react'


//motion
import { motion } from 'framer-motion';

const LabResult = () => {
  return (
    <motion.div 
    initial={{ opacity: 0, x: -50 }}
    animate={{ opacity: 1, x: 0 }}
    exit={{ opacity: 0, x: 50 }}
      className='h-full flex flex-col gap-4'>
        LabResult
    </motion.div>
  )
}

export default LabResult