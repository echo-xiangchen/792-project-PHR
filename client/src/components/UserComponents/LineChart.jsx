import React from 'react'

//chart
import {ResponsiveContainer, LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';

const LOWERLIMITE = 70;
const UPPERLIMIT = 180;

const formatDateTime = (dateTimeString, format = 'hh:mm:ss') => {
    const date = new Date(dateTimeString);
    const defaultTime = `${String(date.getMonth() + 1).padStart(2, '0')}/${String(date.getDate()).padStart(2, '0')} ${String(date.getHours()).padStart(2, '0')}-${String(date.getMinutes()).padStart(2, '0')}`;
    return defaultTime;
};

export const SingleLineChart = ({data}) => {
    // DIY tooltip
    const CustomTooltip = ({ active, payload, label }) => {

        if (active && payload && payload.length) {
            const color = payload[0].value < LOWERLIMITE ? 'text-yellow' : payload[0].value > UPPERLIMIT ? 'text-error' : 'text-success';
            return (
                <div className='bg-tertiary w-auto text-primary p-2 rounded-lg shadow-product text-sm flex flex-col gap-1'>
                    <p className={color}>
                        {`Reading value: ${(payload[0].value)} mg/dL`}
                    </p>
                    <p className="">{`Date: ${formatDateTime(label,"hh:mm:ss")}`}</p>
                </div>
            );
        }
        return null;
    };
    //sort data by date
    data = data.sort((a, b) => new Date(a.time) - new Date(b.time));

    return (
        <ResponsiveContainer>
            <LineChart 
                data={data}
            >
                <XAxis 
                    dataKey="time" 
                    hide={true}
                />
                <Tooltip content={<CustomTooltip/>}/>
                <CartesianGrid strokeDasharray="3 3" />
                <Line 
                    type="monotone" //smooth line
                    dataKey="value" 
                    stroke="#8884d8" 
                />
            </LineChart>
        </ResponsiveContainer>
    )
}
