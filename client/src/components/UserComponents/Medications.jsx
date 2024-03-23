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
    <div 
      style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))',
        gap: '1rem'
      }}
    >
      {medications.map(medication => {
        return (
          <div key={medication.id} className=' bg-white rounded-lg shadow-product p-5'>
            <p className='text-md text-primary font-medium'>{medication.name}</p>
            <div className='flex gap-2'>
              <p>Data Filled:</p>
              <p className='text-md text-primary font-medium'>{medication.DateFilled}</p>
            </div>

            <div className='flex gap-2'>
              <p>Prescribed:</p>
              <p className='text-md text-primary font-medium'>{medication.Prescribed}</p>
            </div>

            <div className='flex gap-2'>
              <p>Instructions:</p>
              <p className='text-md text-primary font-medium'>{medication.instruction}</p>
            </div>

            <div className='flex gap-2'>
              <p>Source:</p>
              <p className='text-md text-primary font-medium'>{medication.source}</p>
            </div>

            <div className='w-full flex justify-center items-center gap-5 py-4'>
              <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.9 }}
              className='px-3 py-1 border border-1 shadow-product cursor-pointer text-secondary'>More Info
              </motion.button>
              <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.9 }}
              className='px-3 py-1 border border-1 shadow-product cursor-pointer text-secondary'>View Refills
              </motion.button>
            </div>
            
          </div>
        )
      })}
    </div>
  )
}

const Medications = () => {

  const { medications } = useSelector(state => state.profile.patientData)

  const [ search, setSearch ] = React.useState({
    name: '',
    dateFrom: '',
    dateTo: '',
  });

  const onChange = (e) => {
    setSearch({
      ...search,
      [e.target.name]: e.target.value
    })
  }

  const onSubmit = () => {
    console.log('submit')
  }

  return (
    <motion.div 
    initial={{ opacity: 0, x: -50 }}
    animate={{ opacity: 1, x: 0 }}
    exit={{ opacity: 0, x: 50 }}
      className='flex flex-col gap-5'>
      <p className='text-2xl text-primary font-medium'>Medications</p>
      <div className='w-full bg-white rounded-lg shadow-product p-5'>
        <p className='text-md text-primary font-medium'>Filters</p>
        <div className='flex items-center gap-5 text-sm'>
          <div className='flex items-center  gap-2'>
            <label htmlFor="medication">Medication name:</label>
            <input type="text" name="name" value={search.name} onChange={onChange} className='border border-gray-200 rounded-lg py-1 px-2' />
          </div>
          <div className='flex items-center  gap-2'>
            <label htmlFor="datefrom">Date Filled: from</label>
            <input type="date" name="dateFrom" value={search.dateFrom} onChange={onChange} className='border border-gray-200 rounded-lg py-1 px-2' />
          </div>
          <div className='flex items-center  gap-2'>
            <label htmlFor="dateTo"> To</label>
            <input type="date" name="dateTo" value={search.dateTo} onChange={onChange} className='border border-gray-200 rounded-lg py-1 px-2' />
          </div>
          <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.9 }}
          onClick={onSubmit}
          className=' px-4 py-2 border border-1 shadow-product cursor-pointer'>Apply
          </motion.button>
        </div>
      </div>
      
      <FilterResult medications={medications} />

    </motion.div>
  )
}

export default Medications