import React from 'react'


//motion
import { motion } from 'framer-motion';

//redux
import { useSelector } from 'react-redux';
import { removeClinicalVisits } from '../../../redux/slices/profileSlice';

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

//route
import { NavLink } from 'react-router-dom';

//react
import { useState } from 'react';


const TableComponent = () => {
    const { clinicalVisits } = useSelector(state => state.profile.patientData)

    const [filteredInfo, setFilteredInfo] = useState({});
    const [sortedInfo, setSortedInfo] = useState({});

    //search
    const handleChange = (pagination, filters, sorter) => {
        setFilteredInfo(filters);
        setSortedInfo(sorter);
    };

    const Action = ({record}) => {

        const deleteAction = () => {
            dispatch(removeClinicalVisits(record.id))
            message.success('Clinical Visit Deleted Successfully')
        }
        
        const actionMenu = [
            { 
                key: 'view', 
                label: (
                <NavLink 
                to={`${record.id}/detail`} 
                className='text-primary'>View Details
                </NavLink>
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
            }
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
                <Action record={record} />
            </div>
        )
        }
    ]
    return (
        <Table 
            columns={columns} 
            dataSource={clinicalVisits} 
            onChange={handleChange} 
            rowKey="id"
        />
    )
}

export default TableComponent