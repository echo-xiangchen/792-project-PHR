import React from 'react'

//motion
import { motion } from 'framer-motion';

//redux
import { useSelector } from 'react-redux';

//antd
import { 
    Table,
    Dropdown,
    Button,
    Space,
    message, 
} from 'antd';
import { 
    SearchOutlined,
    DownOutlined,
} from '@ant-design/icons';

//react
import { useState } from 'react';

//route
import { NavLink } from 'react-router-dom';

const TableComponent = () => {

    //get lab results from redux
    const { labResults } = useSelector(state => state.profile.patientData)
    //filter and sort
    const [filteredInfo, setFilteredInfo] = useState({});
    const [sortedInfo, setSortedInfo] = useState({});
    

    const handleChange = (pagination, filters, sorter) => {
        setFilteredInfo(filters);
        setSortedInfo(sorter);
    };

    //action menu
    const Action = ({record}) => {
        const deleteAction = () => {
            dispatch(removeClinicalVisits(record.id))
            message.success('Clinical Visit Deleted Successfully')
        }
        
        const actionMenu = [
            { 
                key: 'view', 
                label: (
                <Button 
                    type='text' >
                    <NavLink 
                        to={`${record.id}/detail`} 
                        className='text-primary'>
                        View Details
                    </NavLink>
                </Button>
                ) 
            },
            { 
                key: 'download', 
                label:(
                <Button
                    onClick={deleteAction}
                    type='text' 
                >
                    Download as PDF
                </Button>
                )
            },
            { 
                key: 'delete', 
                label:(
                <Button
                    onClick={deleteAction}
                    type='text' 
                    danger>
                    Delete
                </Button>
                )
            },
        ]
        
        const props = {
            items: actionMenu,
        }
    
        return (
            <Dropdown menu={props}>
                <Button>
                Actions <DownOutlined />
                </Button>
            </Dropdown>
        )
    }


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
                <Action record={record} />
            </div>
        )
        }
    ]

    return (
        <Table 
            columns={columns} 
            dataSource={labResults} 
            onChange={handleChange} 
            rowKey="id"
            />
    )
}

export default TableComponent