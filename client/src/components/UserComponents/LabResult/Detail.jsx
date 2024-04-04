import React,{ useState, useEffect } from 'react'

//router
import { NavLink, useParams } from 'react-router-dom'

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
import { ExclamationCircleOutlined,RightOutlined,LeftOutlined } from '@ant-design/icons';

//motion
import { motion } from 'framer-motion';

import moment from 'moment';

//dowload PDF
import html2canvas from 'html2canvas';
import jsPDF from 'jspdf';

//Render range
const RangeRender = ({low, high, unit}) => {
    if(low === -1){
        return(
            <p>&lt; {high} {unit}</p>
        )
    }else if(high === 10000){
        return(
            <p>&gt;  {low} {unit} </p>
        )
    }else{
        return(
            <p> {low} - {high} {unit}</p>
        )
    }
}

const printDocument = (id) => {
    // Get the element.
    const input = document.getElementById(id);
    html2canvas(input)
        .then((canvas) => {
            const width = 250;
            const height = 0;

            const imgData = canvas.toDataURL('image/png');
            const pdf = new jsPDF({
            orientation: 'landscape',
            });
            // Add image Canvas to PDF
            pdf.addImage(
                imgData, 
                'PNG', 
                0, 
                0,
                width, 
                height
            );
            // download
            pdf.save("download.pdf");
    });
};


const DetailInfo = ({data}) => {
    //Render data if out of range, then show warning icon
    const DataRender = ({value, unit, low, high}) => {
        let warningIcon = ' ';
        if(value < low || value > high){
            warningIcon = <span className='text-red-500'>⚠️</span>
        }else{
            warningIcon = <span className='w-5 px-3 '></span>
        }

        return(
            <p className='w-32'>{warningIcon} {value} {unit}</p>
        )
    }
    
    

    return (
        <div id="divToPrint1" className='w-full flex flex-col gap-10 bg-white p-7 rounded-md'>
            <div className='flex justify-between items-center'>
                <div className='text-lg font-medium'>
                    General Information:
                </div>

                <motion.div 
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.97 }}
                    className='flex gap-5 select-none items-center'
                    onClick={() => printDocument('divToPrint1')}
                    >
                    <FaDownload/>
                    <span>Download as PDF</span>
                </motion.div>
            </div>  
            

            <div className='flex flex-col gap-3 text-lg'>
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
                <div className="overflow-x-auto relative">
                    <table className="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                        <thead className="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                            <tr>
                                <th scope="col" className="py-3 px-6">Component</th>
                                <th scope="col" className="py-3 px-6">Result</th>
                                <th scope="col" className="py-3 px-6">Standard Range</th>
                            </tr>
                        </thead>
                        <tbody>
                        {data.testResult.map((row, index) => {
                            return (
                                <tr key={index} className="border-b dark:bg-gray-800 dark:border-gray-700 odd:bg-white even:bg-gray-50 odd:dark:bg-gray-800 even:dark:bg-gray-700">
                                    <td className="py-4 px-6">{row.code}</td>
                                    <td className="py-4 "><DataRender value={row.value} unit={row.unit} low={row.low} high={row.high} /></td>
                                    <td className="py-4 px-6"><RangeRender low={row.low} high={row.high} unit={row.unit}/></td>
                                </tr>
                            )
                        })}
                        <tr className='flex flex-col gap-3 px-10 text-primary'>
                            <td>
                                Interpretative Data:<br/>
                                Please note that the above listed reference range is for<br/>
                                NonFasting Blood Glucose levels only..<br/>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    )
}



//extract standard range from data
const extractStandardRanges = labResults => labResults.reduce((acc, result) => {
    result.testResult.forEach(({ code, low, high, unit }) => {
        // Replace all white spaces with underscores
        const formattedCode = code.replace(/\s+/g, '_');
        acc[formattedCode] = { min: low, max: high, unit };
    });
    return acc;
}, {});

const ResultTable = ({data}) => {
    
    //transfer data format
    const transferData = (labResults) => labResults.map(result => ({
        id: result.id, // Assuming no transformation needed for id
        collectOn: result.collectOn.substring(0, 10), // Extracting date part only
        test: result.test,
        testResult: result.testResult.reduce((acc, test) => {
            const code = test.code.replace(/ /g, '_'); // Replacing spaces with underscores
            acc[code] = test.value; // Assuming direct value assignment
            return acc;
        }, {})
    }));

    //transfer data
    const newData = transferData(data);

    //extract standard range
    const standardRanges = extractStandardRanges(data);

    //data source
    const dataSource = Object.keys(newData[0].testResult).map((testName, index) => ({
        key: index,
        name: testName,
        ...newData.reduce((acc, result, idx) => {
            acc[`result${idx}`] = result.testResult[testName];
            return acc;
        }, {}),
    }));

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
                    <div className='text-md'>
                        <div className='text-lg'>{text}</div>
                        <div className=''><RangeRender low={min} high={max} unit={unit}/></div>
                    </div>
                );
            }
        },
        ...newData.map((result, index) => ({
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

    
    /** ----- modal part ---- */
    const [isModalVisible, setIsModalVisible] = useState(false);
    const [tableName, setTableName] = useState('');
    const [lineChartData, setLineChartData] = useState([]);

    const showModal = (testResult) => {
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
            <div id="divToPrint2" className='w-full'>
                <Table columns={columns} dataSource={dataSource} />
            </div>
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

const PastResults = ({data,filterTest }) => {

    const [ resultData, setResultData ] = useState([...data].filter(item => item.test === filterTest))
    
    
    const [ filter, setFilter ] = useState({
        fromDate : null,
        toDate : null,
        latest : 0
    })

    useEffect(() => {
        //latest means the latest N results, if latest is 0, then show all results, otherwise show the latest N results
        if(filter.latest === 0){
            setResultData([...data].filter(item => item.test === filterTest))
        }else{
            console.log("filterTest", filterTest)
            setResultData([...data].filter(item => item.test === filterTest).slice(0, filter.latest))
        }
        
    }, [filter])

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
                <AntTooltip title="the latest N results">
                    <input 
                        type='text' 
                        placeholder='' 
                        className='w-12 border border-primary rounded-md p-1'
                        value={filter.latest}
                        onChange={(e) => setFilter({...filter, latest: e.target.value})}
                    />
                    <span className='mx-3'> latest results</span>
                </AntTooltip>
                
                <button className=' text-primary border hover:shadow-card ease-in duration-100 px-3 py-1'>Apply</button>
                <div className='flex-1 flex justify-end'>
                    <motion.div 
                        whileHover={{ scale: 1.05 }}
                        whileTap={{ scale: 0.97 }}
                        className='flex gap-5 select-none items-center cursor-pointer'
                        onClick={() => printDocument('divToPrint2')}
                        >
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
            <ResultTable data={resultData}/>
        </div>
    )
}   


const Detail = () => {

    //get id from url
    const { id } = useParams()
    //profile date
    const { labResults } = useSelector(state => state.profile.patientData)

    if(!labResults) return (
        <div 
            className='h-full flex justify-center items-center'>
            <NavLink 
                to='/login'
                className='text-2xl text-primary font-medium'>Please login to view this page</NavLink>
        </div>
    )
    //according id get data from array
    const data = labResults.find(item => item.id === id)

    if(!data) return(
        <div className='h-full flex justify-center items-center'>
            Data not found
        </div>
    )

    const items = [
        {
            label: 'Details',
            key: '1',
            children: <DetailInfo data={data} />,
        },
        {
            label: 'Procedures and Treatments',
            key: '2',
            children: <PastResults data={labResults} filterTest={data.test}  />,
        },
    ]

    return (
        <div className='flex flex-col gap-4'>
            <div className='flex gap-5 items-center'>
                <motion.div 
                    whileHover={{ scale: 1.1 }}
                    whileTap={{ scale: 0.95 }}
                    className='flex items-center gap-1'>
                    <NavLink to='/my-profile/lab-result' className='text-primary'>
                        <FaArrowLeft/>
                    </NavLink>
                </motion.div>
                <span className='text-2xl text-primary font-medium'>{data.test} - Details</span>
            </div>

            <Tabs
                type="card"
                items={items}
            />
        </div>
    )
}

export default Detail