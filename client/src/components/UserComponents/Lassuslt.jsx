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

const LabResult = () => {

  const { labResults } = useSelector(state => state.profile.patientData)

  const [filteredInfo, setFilteredInfo] = useState({});
  const [sortedInfo, setSortedInfo] = useState({});

  //search
  

  const handleChange = (pagination, filters, sorter) => {
    setFilteredInfo(filters);
    setSortedInfo(sorter);
  };


  const columns = [
    {
      title: "Requested on",
      dataIndex: "requestedOn",
      sorter: {
        compare: (a, b) => a.requestedOn - b.requestedOn,
        multiple: 1,
      },
      sortOrder: sortedInfo.columnKey === 'requestedOn' ? sortedInfo.order : null,
    },
    {
      title: "Collected on",
      dataIndex: "collectOn",
      sorter: {
        compare: (a, b) => a.collectOn - b.collectOn,
        multiple: 2,
      },
      sortOrder: sortedInfo.columnKey === 'collectOn' ? sortedInfo.order : null,
    },
    {
      title: "Test",
      dataIndex: "test",
      sorter: {
        compare: (a, b) => a.test - b.test,
        multiple: 3,
      },
      sortOrder: sortedInfo.columnKey === 'test' ? sortedInfo.order : null,
      filters: [
        {
          text: "Basic Metabolic Panel (BMP)",
          value: "Basic Metabolic Panel (BMP)"
        },
      ],
      filteredValue: filteredInfo.test || null,
      onFilter: (value, record) => record.test.includes(value),
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
          text: "Final result",
          value: "Final result"
        },
      ],
      filteredValue: filteredInfo.status || null,
      onFilter: (value, record) => record.status.includes(value),
    },
    {
      title: "Ordered by",
      dataIndex: "orderedBy",
      sorter: {
        compare: (a, b) => a.orderedBy - b.orderedBy,
        multiple: 5,
      },
      sortOrder: sortedInfo.columnKey === 'orderedBy' ? sortedInfo.order : null,
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
      title: "Actions",
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
          className='px-2 py-1 bg-secondary text-white rounded-md'>Download as PDF</motion.button>
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
          dataSource={labResults} 
          onChange={handleChange} 
          rowKey="id"
        />
    </motion.div>
  )
}

export default LabResult