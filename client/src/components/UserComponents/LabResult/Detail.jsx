import React from 'react'

//router
import { useParams } from 'react-router-dom'

//icon
import { FaArrowLeft } from 'react-icons/fa'

//antd
import { Tabs,Table } from 'antd'

//redux
import { useSelector } from 'react-redux'

//icon
import { FaDownload } from 'react-icons/fa'

//motion
import { motion } from 'framer-motion';

import moment from 'moment';

const DetailInfo = ({data}) => {

    const Row = ({label,value, unit, below, upper}) => {

        return(
            <div className='flex justify-between text-lg px-10'>
                <p className='w-56'>{label}</p>
                <p className='w-32'>{value} {unit}</p>
                <p>{below} - {upper} {unit}</p>
            </div>
        )
    }

    return (
        <div className='w-full flex flex-col gap-10'>
            <div className='flex justify-between items-center'>
                <div className='text-lg font-medium'>
                    General Information:
                </div>

                <motion.div 
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.97 }}
                    className='flex gap-5 select-none items-center'>
                    <FaDownload/>
                    <span>Download as PDF</span>
                </motion.div>
            </div>  
            

            <div className='flex flex-col gap-5 text-lg'>
                <div className='flex gap-32'>
                    <div className='flex gap-3'>
                        <span className='text-secondary'>Requested on:</span>
                        <span className='text-primary'>{moment(data.requestedOn).format('MMMM DD, YYYY')}</span>
                    </div>
                    <div className='flex gap-3'>
                        <span className='text-secondary'>Resulted on:</span>
                        <span className='text-primary'>{moment(data.resultOn).format('MMMM DD, YYYY')}</span>
                    </div>
                </div>
                <div className='flex gap-32'>
                    <div className='flex gap-3'>
                        <span className='text-secondary'>CollectOn on:</span>
                        <span className='text-primary'>{moment(data.collectOn).format('MMMM DD, YYYY')}</span>
                    </div>
                    <div className='flex gap-3'>
                        <span className='text-secondary'>Result status:</span>
                        <span className='text-primary'>{data.status}</span>
                    </div>
                </div>
            </div>

            <div className='flex flex-col gap-5 py-5 border'>
                <Row label='- Component' value="Result" unit="" below="Standard Range" upper="" />
                <hr />
                <Row label='Sodium' value={data.testResult.Sodium} unit="mmol/L" below="135" upper="145" />
                <hr />
                <Row label='Potassium' value={data.testResult.Potassium} unit="mmol/L" below="3.5" upper="5.1" />
                <hr />
                <Row label='Chloride' value={data.testResult.Chloride} unit="mmol/L" below="98" upper="107" />
                <hr />
                <Row label='Carbon Dioxide (CO2)' value={data.testResult.co2} unit="mmol/L" below="22" upper="29" />
                <hr />
                <Row label='Urea Nitrogen (BUN)' value={data.testResult.bun} unit="mg/dL" below="7" upper="20" />
                <hr />
                <Row label='Creatinine' value={data.testResult.creatinine} unit="mg/dL" below="0.6" upper="1.3" />
                <hr />
                <Row label='Glucose' value={data.testResult.bloodGlucose} unit="mg/dL" below="70" upper="100" />
                <div className='flex flex-col gap-3 px-10 text-primary'>
                Interpretative Data:<br/>
                Please note that the above listed reference range is for<br/>
                NonFasting Blood Glucose levels only..<br/>
                </div>
            </div>
        </div>
    )
}

const PastResults = () => {
    
    return (
        <div>
            PastResults
        </div>
    )
}   


const Detail = () => {

    //get id from url
    const { id } = useParams()
    //profile date
    const { labResults } = useSelector(state => state.profile.patientData)

    //according id get data from array
    const data = labResults.find(item => item.id === id)

    if(!data) return <div>Data not found</div>

    const onChange = (key) => {
        console.log(key);
    };

    const items = [
        {
            label: 'Details',
            key: '1',
            children: <DetailInfo data={data} />,
        },
        {
            label: 'Procedures and Treatments',
            key: '2',
            children: <PastResults data={data}  />,
        },
    ]

    return (
        <div className='flex flex-col gap-4'>
            <div className='flex gap-3 items-center'>
                <div className='flex items-center gap-1'>
                    {/* <FaArrowLeft className='text-primary text-2xl'/> */}
                    {/* <span className='text-primary text-xl'>Back</span> */}
                </div>
                <span className='text-2xl text-primary font-medium'>Visit Summary</span>
            </div>

            <Tabs
                onChange={onChange}
                type="card"
                items={items}
            />
        </div>
    )
}

export default Detail