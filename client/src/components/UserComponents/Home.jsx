import React from 'react'

//react
import { useMemo,useState } from 'react'

//redux
import { useDispatch, useSelector } from 'react-redux'

//icons
import { HeartFilled,} from '@ant-design/icons';
import { MdBloodtype } from "react-icons/md";
import { FaW, FaWeightScale } from "react-icons/fa6";

//antd
import { Tooltip } from 'antd';

const UserInfo = ({basicInfo}) => {

  const Info = ({tag, value}) => (
    <div className='flex-1 flex flex-col gap-1 items-center'>
      <span>{tag}:</span><span>{value}</span>
    </div>
  )

  return (
    <div className='w-80 h-full flex flex-col gap-5 bg-white rounded-lg shadow-product p-5'>
      <div className='flex flex-col justify-center items-center gap-3'>
        <img src={basicInfo.avatar} alt="user" className='w-24 h-24 rounded-lg mx-auto'/>
        <h1 className='text-xl text-center'>{basicInfo.firstName} {basicInfo.lastName}</h1>
        <div className='w-full flex gap-3 justify-center items-center'>
          <Info tag="Gender" value={basicInfo.gender} />
          <Info tag="Age" value={basicInfo.age} />
        </div>
        <div className='w-full flex gap-3 items-center'>
          <Info tag="Height" value={basicInfo.height} />
          <Info tag="Blood Type" value={basicInfo.bloodType} />
        </div>
      </div>
      
    </div>
  )
}

const ResultCard = ({ icon, time,title, children}) => {
  const [arrow, setArrow] = useState('Show');

  const mergedArrow = useMemo(() => {
    if (arrow === 'Hide') {
      return false;
    }
    if (arrow === 'Show') {
      return true;
    }
    return {
      pointAtCenter: true,
    };
  }, [arrow]);

  return (
    <div className='max-h-64 bg-white text-primary rounded-lg shadow-product p-5 min-w-64 flex flex-col gap-10'>
      <div className='flex gap-3 items-center'>
        <div className='text-4xl text-secondary'>{icon}</div>
        <div>
          <h1 className='text-lg'>{title}</h1>
          <Tooltip placement="topLeft" title="Last record you submit" arrow={mergedArrow}>
            <p className='text-sm'><span className='font-semibold'>{time}</span></p>
          </Tooltip>
        </div>
      </div>
      {children}
    </div>
  )
}

const PatientData = ({patientData}) => {
  return(
    <div className='flex-1 flex gap-6 flex-wrap'>
      <ResultCard icon={<MdBloodtype />} time='2021-07-07, 12:30pm' title='Blood Glucose'>
        <p>Value: <span>106 mg/dL</span></p>
        <p className='text-success'>In range</p>
      </ResultCard>
      <ResultCard icon={<HeartFilled/>} time='2021-07-07, 12:30pm' title='Blood Pressure'>
        <p>Value: <span>120/85 mmHg</span></p>
        <p className='text-error'>Out of range</p>
      </ResultCard>
      <ResultCard icon={<FaWeightScale/>} time='2021-07-07, 12:30pm' title='Weight'>
        <p>Value: <span>175 lbs</span></p>
        <p className='text-success'>In range</p>
      </ResultCard>
      
    </div>
  )
}

const Home = () => {

  const {basicInfo, patientData} = useSelector(state => state.profile)

  return (
    <div className='h-full flex gap-12'>
      <UserInfo basicInfo={basicInfo} />
      <PatientData patientData={patientData} />
    </div>
  )
}

export default Home