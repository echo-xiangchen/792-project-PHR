import React from 'react'

//motion
import { motion } from 'framer-motion';

//router
import { 
  Routes,
  Route,
} from 'react-router-dom';

//components
import Detail from './Detail';
import TableComponent from './Table';


const ClinicalVisits = () => {
  return (
    <motion.div 
    initial={{ opacity: 0, x: -50 }}
    animate={{ opacity: 1, x: 0 }}
    exit={{ opacity: 0, x: 50 }}
    className='h-full flex flex-col gap-4'>
      <Routes>
        <Route path='/' element={<TableComponent />} />
        <Route path='/:id/detail' element={<Detail />} />
      </Routes>
    </motion.div>
  )
}

export default ClinicalVisits