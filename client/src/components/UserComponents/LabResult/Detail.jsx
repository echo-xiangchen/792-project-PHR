import React,{ useState, useEffect } from 'react'

//router
import { useParams } from 'react-router-dom'

//icon
import { FaArrowLeft } from 'react-icons/fa'

//antd
import { 
    Tabs,
    Table,
    DatePicker, 
    Result,
    Tooltip as AntTooltip,
    Modal 
} from 'antd'

//line chart
import { 
    LineChart,
    Line, 
    XAxis, 
    YAxis, 
    CartesianGrid, 
    Tooltip, 
    Legend, 
    ResponsiveContainer 
} from 'recharts';

//redux
import { useSelector } from 'react-redux'

//icon
import { FaDownload } from 'react-icons/fa'
import { ExclamationCircleOutlined } from '@ant-design/icons';

//motion
import { motion } from 'framer-motion';

import moment from 'moment';

const DetailInfo = ({data}) => {

    const Row = ({label,value, unit, below, upper}) => {
        let warningIcon = ' ';
        if(upper !== ''){
            if(value < below || value > upper){
                warningIcon = <span className='text-red-500'>⚠️</span>
            }else{
                warningIcon = <span className='w-5 px-3 '></span>
            }
        }

        return(
            <div className='flex justify-between text-lg px-10'>
                <p className='w-56'>{label}</p>
                <p className='w-32'>{warningIcon} {value} {unit}</p>
                <p>{below} - {upper} {unit}</p>
            </div>
        )
    }

    return (
        <div className='w-full flex flex-col gap-10 bg-white p-7 rounded-md'>
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
                <Row label='Potassium' value={data.testResult.Potassium} unit="mmol/L" below="3.5" upper="5.0" />
                <hr />
                <Row label='Chloride' value={data.testResult.Chloride} unit="mmol/L" below="98" upper="108" />
                <hr />
                <Row label='Carbon Dioxide (CO2)' value={data.testResult.co2} unit="mmol/L" below="21" upper="30" />
                <hr />
                <Row label='Urea Nitrogen (BUN)' value={data.testResult.bun} unit="mg/dL" below="7" upper="20" />
                <hr />
                <Row label='Creatinine' value={data.testResult.creatinine} unit="mg/dL" below="0.4" upper="1.0" />
                <hr />
                <Row label='Glucose' value={data.testResult.bloodGlucose} unit="mmol/L" below="3.9" upper="7.8" />
                <div className='flex flex-col gap-3 px-10 text-primary'>
                Interpretative Data:<br/>
                Please note that the above listed reference range is for<br/>
                NonFasting Blood Glucose levels only..<br/>
                </div>
            </div>
        </div>
    )
}

const ResultTable = ({data}) => {
    
    const WarningIcon = () => (
        <AntTooltip title="Abnormal value">
            <ExclamationCircleOutlined style={{ color: 'red' }} />
        </AntTooltip>
    );

    
    const [isModalVisible, setIsModalVisible] = useState(false);
    const [tableName, setTableName] = useState('');
    const [lineChartData, setLineChartData] = useState([]);

    const showModal = (testResult) => {
        console.log(testResult)
        // format data for line chart
        const chartData = Object.keys(testResult)
            .filter(key => key.startsWith('result')) // filter only result keys
            .map((key, index) => {
            // filter key and name
            return({
                name: `Day ${index + 1}`, //X axis
                Value: testResult[key],
            })
        });
        setTableName(testResult.name); //Sodium, Potassium, etc
        setLineChartData(chartData);
        setIsModalVisible(true);
    };

    const renderResult = (value, testName) => {
        const range = standardRanges[testName];
        if (!range) return value; // No range for this test

        const { min, max } = range;
        const isAbnormal = value < min || value > max;
        return isAbnormal ? (<>{value} <ExclamationCircleOutlined style={{ color: 'red' }} /></>) : value;
    };

    const columns = [
        {
            title: 'Test Component',
            dataIndex: 'name',
            key: 'name',
            render: (text) => {
                const { min, max, unit } = standardRanges[text];
                return (
                    <div className='text-lg'>
                        <div>{text}</div>
                        <div>{`${min} - ${max} ${unit}`}</div>
                    </div>
                );
            }
        },
        ...data.map((result, index) => ({
            title: moment(result.collectOn).format('MMMM DD, YYYY'), // Date title
            dataIndex: `result${index}`,
            key: `result${index}`,
            render: (text, record) => renderResult(text, record.name),
        })),
        {
            title: 'Action',
            key: 'action',
            render: (_, record) => (
                <button onClick={() => showModal(record)}>Show graph</button>
            ),
        },
    ];

    const standardRanges = {
        Sodium: { min: 135, max: 145, unit: 'mmol/L' },
        Potassium: { min: 3.5, max: 5.0, unit: 'mmol/L' },
        Chloride: { min: 98, max: 108, unit: 'mmol/L' },
        co2: { min: 21, max: 30, unit: 'mmol/L' },
        bun: { min: 7, max: 20, unit: 'mg/dL' },
        creatinine: { min: 0.4, max: 1.0, unit: 'mg/dL' },
        bloodGlucose: { min: 3.9, max: 7.8, unit: 'mmol/L' },
    };

    const dataSource = Object.keys(data[0].testResult).map((testName, index) => ({
        key: index,
        name: testName,
        ...data.reduce((acc, result, idx) => {
            acc[`result${idx}`] = result.testResult[testName];
            return acc;
        }, {}),
    }));

    const LabelX = () => (
        <text 
            x="50%"
            y="100%"
            fontSize="16"
            fill="#003F4F"
            textAnchor="middle"
        >
            {tableName}
        </text>
    )

    return (
        <>
            <Table columns={columns} dataSource={dataSource} />
            
            <Modal
                title={`Graph for ${tableName}`}
                open={isModalVisible}
                onOk={() => setIsModalVisible(false)}
                onCancel={() => setIsModalVisible(false)}
                width={700}
                footer={null}
            >
                <ResponsiveContainer width="100%" height={350}>
                    <LineChart data={lineChartData} margin={{ top: 20, right: 30, left: 20, bottom:  20 }}>
                        <CartesianGrid strokeDasharray="3 3" />
                        <XAxis dataKey="name" label={<LabelX/>} />
                        <YAxis />
                        <Tooltip />
                        <Line type="monotone" dataKey="Value" stroke="#8884d8" label={tableName} activeDot={{ r: 8 }} />
                    </LineChart>
                </ResponsiveContainer>
            </Modal>
        </>
    );
}

const PastResults = ({data}) => {
    
    const [ filter, setFilter ] = useState({
        fromDate : null,
        toDate : null,
    })
    
    
    

    const fromDateOnChange = (date, dateString) => {
        setFilter({...filter, fromDate: dateString})
    }

    const toDateOnChange = (date, dateString) => {
        setFilter({...filter, toDate: dateString})
    }

    const SearchBar = () => {
        return(
            <div className='w-full flex gap-5 items-center font-medium text-md'>
                <span> From: </span>
                <DatePicker 
                    value={filter.fromDate ? moment(filter.fromDate, "YYYY-MM-DD") : null}
                    onChange={fromDateOnChange}
                />
                <span> To: </span>
                <DatePicker
                    value={filter.toDate ? moment(filter.toDate, "YYYY-MM-DD") : null}
                    onChange={toDateOnChange}
                />
                <span>- or -</span>
                <input type='text' placeholder='' className='w-12 border border-primary rounded-md p-1'/>
                <span> latest results</span>
                <button className=' text-primary border hover:shadow-card ease-in duration-100 px-3 py-1'>Apply</button>
                <div className='flex-1 flex justify-end'>
                    <motion.div 
                        whileHover={{ scale: 1.05 }}
                        whileTap={{ scale: 0.97 }}
                        className='flex gap-5 select-none items-center cursor-pointer'>
                        <FaDownload/>
                        <span>Download as PDF</span>
                    </motion.div>
                </div>
            </div>
        )
    }
    return (
        <div className='bg-white p-7 rounded-md flex flex-col gap-10'>
            <SearchBar />
            <ResultTable data={data}/>
        </div>
    )
}   


const Detail = () => {

    //get id from url
    const { id } = useParams()
    //profile date
    const { labResults } = useSelector(state => state.profile.patientData)

    if(!labResults) return <div>Loading...</div>
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
            children: <PastResults data={labResults}  />,
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