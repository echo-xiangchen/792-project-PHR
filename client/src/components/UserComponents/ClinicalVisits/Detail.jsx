import React from 'react'

//router
import { useParams } from 'react-router-dom'

//icon
import { FaArrowLeft } from 'react-icons/fa'

//antd
import { Tabs,Table } from 'antd'

//redux
import { useSelector } from 'react-redux'

import moment from 'moment';



const Page1 = ({data}) => {

  if(!data){
    return <div>Loading...</div>
  }

  

  const Row = ({label1,value1,label2,value2 }) => {

    const Element = ({label,value}) => (
      <div className='flex-1 flex items-center text-lg gap-3'>
        <span className=''>{label}: </span>
        <span className='text-primary'>{value}</span>
      </div>
    )

    const ArrayElement = ({label,value}) => (
      <div className='flex-1 flex flex-col items-start text-lg gap-3'>
        <span className=''>{label}: </span>
        <div className='flex flex-col gap-1'>
          {value.map((item,index) => (
            <span key={index} className='text-secondary'>- {item}</span>
          ))}
        </div>
      </div>
    )

    //if value1 and value2 is array
    if(Array.isArray(value1) && Array.isArray(value2)){
      return(
        <div className='w-full flex'>
          <ArrayElement label={label1} value={value1} />
          <ArrayElement label={label2} value={value2} />
        </div>
      )
    }

    if(!value1 && !value2){
      return null
    }

    if(!value1){
      return(
        <div className='w-full flex'>
          <Element label={label2} value={value2} />
        </div>
      )
    }

    if(!value2){
      return(
        <div className='w-full flex'>
          <Element label={label1} value={value1} />
        </div>
      )
    }


    return(
      <div className='w-full flex'>
        <Element label={label1} value={value1} />
        <Element label={label2} value={value2} />
      </div>
    )
  }


  return (
    <div className='flex flex-col gap-3'>
      <Row 
        label1='Patient Encounter Type' 
        value1={data.type} 
        label2='Diagnosis' 
        value2={data.Diagnosis} 
      />

      <Row
        label1='Encounter Date and Time'
        value1={data.encounterDate}
        label2='Discharge Date and Time'
        value2={data.dischargeDate}
      />

      <Row
        label1='Facility'
        value1={data.facility}
        label2='Responsible Health Care Provider'
        value2={data.Doctor}
      />

      <Row
        label1='Reason for visit'
        value1={data.reason}
      />

      <Row
        label1='Reported Symptoms at Initial Assessment'
        value1={data.reportedSymptoms}
        label2='physical Examination'
        value2={data.physicalExamination}
      />
    </div>
  )
}

const ProceduresAndTreatments = ({data}) => {
  
    if(!data){
      return <div>Loading...</div>
    }
  
    return (
      <div className='flex flex-col gap-3 text-lg'>
        <div className='flex flex-col gap-3'>
          {data.treatmentsAndProcedures.map((item,index) => (
            <div key={index} className='flex gap-3'>
              <span className='text-secondary'>{index+1}.</span>
              <span className='text-primary'>{item}</span>
            </div>
          ))}
        </div>
      </div>
    )
}

const Tests = ({data}) => {

  const columns = [
    {
      title: 'date',
      dataIndex: 'time',
      key: 'time',
      render: (text) => moment(text).format('MMMM DD, YYYY, hh:mm A'),
    },
    {
      title: 'Component',
      dataIndex: 'name',
      key: 'name',
    },
    {
      title: 'Result',
      dataIndex: 'result',
      key: 'result',
      render: (result) => {
        const icon = result.status === 'Critical' ? '⚠️ ' : '';
        return `${icon}${result.value} ${result.unit} (${result.status})`;
      },
    },
    {
      title: 'Reference Range',
      dataIndex: 'referenceRange',
      key: 'referenceRange',
    },
  ]



  return(
    <div className='flex flex-col gap-3'>
      <Table columns={columns} dataSource={data.tests} />
      <div className='flex flex-col gap-3 text-lg font-medium'>
        Radiology
      </div>
      <div className='flex flex-col gap-3 text-mg'>
        None
      </div>
    </div>
  
  )
}

const Medications = ({data}) => {
  const MedicationRender = ({name,instruction}) => (
    <div className='flex gap-3 rounded-md shadow-product p-6 bg-white'>
      <div className='flex-1 flex flex-col gap-2'>
        <span className='text-lg text-primary'>{name}</span>
        <span className='text-secondary'>{instruction}</span>
      </div>
    </div>
  )

  return (
    <div className='flex flex-col gap-8'>
      {data.medications.map((item,index) => (
        <MedicationRender key={index} name={item.name} instruction={item.instruction} />
      ))}
    </div>
  )
}


const FollowUp = ({data}) => {
  //follow up is string array
  return(
    <div className='flex flex-col gap-3 text-lg'>
      {data.followUp.map((item,index) => (
        <div key={index} className='flex gap-3'>
          <span className='text-secondary'>{index+1}.</span>
          <span className='text-black'>{item}</span>
        </div>
      ))}
    </div>
  )
}


const Detail = () => {

    //get id from url
    const { id } = useParams();
    //profile date
    const { clinicalVisits } = useSelector(state => state.profile.patientData)

    //according id get data from array
    const data = clinicalVisits.find(item => item.id === id)

    const onChange = (key) => {
      console.log(key);
    };

    const items = [
      {
        label: 'General Information',
        key: '1',
        children: <Page1 data={data} />,
      },
      {
        label: 'Procedures and Treatments',
        key: '2',
        children: <ProceduresAndTreatments data={data}  />,
      },
      {
        label: 'Tests',
        key: '3',
        children: <Tests data={data}  />,
      },
      {
        label: 'Prescribed Medications',
        key: '4',
        children: <Medications data={data}  />,
      },
      {
        label: 'Follow-Up Instructions',
        key: '5',
        children: <FollowUp data={data}  />,
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