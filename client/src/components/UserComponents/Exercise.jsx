import React from 'react'

//motion
import { motion } from 'framer-motion';

const Exercise = () => {
  return (
    <motion.div 
    initial={{ opacity: 0, x: -50 }}
    animate={{ opacity: 1, x: 0 }}
    exit={{ opacity: 0, x: 50 }}
      className='h-full flex flex-col gap-4'>
        Exercise
    </motion.div>
  )
}

export default Exercise