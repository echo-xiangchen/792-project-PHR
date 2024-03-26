import React from 'react'

//motion
import { motion } from 'framer-motion';

//router
import { 
  Routes,
  Route,
} from 'react-router-dom';

//components
import TableComponent from './Table';
import Detail from './Detail';
import Procedure from './Procedure';
import Test from './Test';
import Prescribed from './Prescribed';
import Instruction from './Instruction';


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
        <Route path='/:id/procedure' element={<Procedure />} />
        <Route path='/:id/test' element={<Test />} />
        <Route path='/:id/prescribed' element={<Prescribed />} />
        <Route path='/:id/instruction' element={<Instruction />} />
      </Routes>
    </motion.div>
  )
}

export default ClinicalVisits