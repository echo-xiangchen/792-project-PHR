import React from 'react'

//motion
import { motion } from 'framer-motion';

//redux
import { useSelector } from 'react-redux';

//antd
import { Table } from 'antd';
import { SearchOutlined } from '@ant-design/icons';

//react
import { useState } from 'react';

const ClinicalVisits = () => {

  const { clinicalVisits } = useSelector(state => state.profile.patientData)

  const [filteredInfo, setFilteredInfo] = useState({});
  const [sortedInfo, setSortedInfo] = useState({});

  //search
  

  const handleChange = (pagination, filters, sorter) => {
    setFilteredInfo(filters);
    setSortedInfo(sorter);
  };


  const columns = [
    {
      title: "Encounter Date",
      dataIndex: "encounterDate",
      sorter: {
        compare: (a, b) => a.encounterDate - b.encounterDate,
        multiple: 1,
      },
      sortOrder: sortedInfo.columnKey === 'encounterDate' ? sortedInfo.order : null,
    },
    {
      title: "Discharge Date",
      dataIndex: "dischargeDate",
      sorter: {
        compare: (a, b) => a.dischargeDate - b.dischargeDate,
        multiple: 2,
      },
      sortOrder: sortedInfo.columnKey === 'dischargeDate' ? sortedInfo.order : null,
    },
    {
      title: "type of encounter",
      dataIndex: "type",
      sorter: {
        compare: (a, b) => a.type - b.type,
        multiple: 3,
      },
      sortOrder: sortedInfo.columnKey === 'type' ? sortedInfo.order : null,
      filters: [
        {
          text: "Emergency",
          value: "Emergency"
        },
      ],
      filteredValue: filteredInfo.type || null,
      onFilter: (value, record) => record.type.includes(value),
    },
    {
      title: "Status",
      dataIndex: "status",
      sorter: {
        compare: (a, b) => a.status - b.status,
        multiple: 4,
      },
      sortOrder: sortedInfo.columnKey === 'status' ? sortedInfo.order : null,
      filters: [
        {
          text: "Completed",
          value: "Completed"
        },
      ],
      filteredValue: filteredInfo.type || null,
      onFilter: (value, record) => record.type.includes(value),
    },
    {
      title: "Reason of Encounter",
      dataIndex: "reason",
      sorter: {
        compare: (a, b) => a.reason - b.reason,
        multiple: 5,
      },
      sortOrder: sortedInfo.columnKey === 'reason' ? sortedInfo.order : null,
    },
    {
      title: "facility",
      dataIndex: "facility",
      sorter: {
        compare: (a, b) => a.facility - b.facility,
        multiple: 6,
      },
      sortOrder: sortedInfo.columnKey === 'facility' ? sortedInfo.order : null,
    },
    {
      title: "Action",
      dataIndex: "action",
      render: (text, record) => (
        <div className='flex gap-2'>
          <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.9 }}
          className='px-2 py-1 bg-primary text-white rounded-md'>View Details</motion.button>
          <motion.button 
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.9 }}
          className='px-2 py-1 bg-error text-white rounded-md'>Delete</motion.button>
        </div>
      )
    }
  ]
  return (
    <motion.div 
      initial={{ opacity: 0, x: -50 }}
      animate={{ opacity: 1, x: 0 }}
      exit={{ opacity: 0, x: 50 }}
      className='h-full flex flex-col gap-4'>
        <Table 
          columns={columns} 
          dataSource={clinicalVisits} 
          onChange={handleChange} 
          rowKey="id"
        />
    </motion.div>
  )
}

export default ClinicalVisits