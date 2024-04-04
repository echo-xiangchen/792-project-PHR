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

//moment
import moment from 'moment';

const TableComponent = () => {

    //get lab results from redux
    const { labResults } = useSelector(state => state.profile.patientData)
    //filter and sort
    const [filteredInfo, setFilteredInfo] = useState({});
    const [sortedInfo, setSortedInfo] = useState({});
    

    const handleChange = (pagination, filters, sorter) => {
        console.log('Various parameters',  sorter);
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
            key: 'requestedOn',
            title: "Requested on",
            dataIndex: "requestedOn",
            sorter: (a, b) => moment(a.requestedOn).unix() - moment(b.requestedOn).unix(),
            
            render: (text, record) => (
                <span>{record.requestedOn ? moment(record.requestedOn).format('MMMM D, YYYY'): 'Not collected'}</span>
            ),
            //sortOrder: sortedInfo.columnKey === 'requestedOn' ? sortedInfo.order : null,
        },
        {
            title: "Collected on",
            dataIndex: "collectOn",
            sorter: (a, b) => moment(a.collectOn).unix() - moment(b.collectOn).unix(),
            render: (text, record) => (
                <span>{record.collectOn ? moment(record.collectOn).format('MMMM D, YYYY') : 'Not collected'}</span>
            ),
        },
        {
            title: "Test",
            dataIndex: "test",
            sorter: {
                compare: (a, b) => a.test.localeCompare(b.test),
                multiple: 3,
            },
            filters: [
                {
                    text: "Lipid Panel",
                    value: "Lipid Panel"
                },
                {
                    text: "Basic metabolic panel",
                    value: "Basic metabolic panel"
                }
            ],
            filteredValue: filteredInfo.test || null,
            onFilter: (value, record) => record.test.includes(value),
        },
        {
            title: "Status",
            dataIndex: "status",
            sorter: {
                compare: (a, b) => a.status.localeCompare(b.status),
                multiple: 4,
            },
            filters: [
                {
                text: "Final",
                value: "final"
                },
            ],
            filteredValue: filteredInfo.status || null,
            onFilter: (value, record) => record.status.includes(value),
        },
        {
            title: "Ordered by",
            dataIndex: "orderedBy",
            sorter: {
                compare: (a, b) => a.orderedBy.localeCompare(b.orderedBy),
                multiple: 5,
            },
        },
        {
            title: "facility",
            dataIndex: "facility",
            sorter: {
                compare: (a, b) => a.facility.localeCompare(b.facility),
                multiple: 6,
            },
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