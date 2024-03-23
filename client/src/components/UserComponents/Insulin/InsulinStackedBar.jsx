import React from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend,ResponsiveContainer } from 'recharts';
import { formatDataForRecharts } from '../Utils';


const StackedBarChart = ({data}) => {
    data = formatDataForRecharts(data);
    return (
        
        <ResponsiveContainer>
            <BarChart
                width={500}
                height={300}
                key={Math.random()}
                data={data}
                margin={{
                    top: 20,
                    right: 30,
                    left: 20,
                    bottom: 5,
                }}
            >
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="date" />
                <YAxis />
                <Tooltip />
                <Legend />
                <Bar dataKey="Basal" stackId="a" fill="#8884d8" />
                <Bar dataKey="Bolus" stackId="a" fill="#82ca9d" />
            </BarChart>
        </ResponsiveContainer>
        
    );
};

export default StackedBarChart;
