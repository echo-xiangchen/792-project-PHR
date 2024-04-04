import React, { PureComponent } from 'react';
import { PieChart, Pie,Tooltip, Sector, Cell, ResponsiveContainer, Label } from 'recharts';


const COLORS = ['#0088FE', '#00C49F'];

const RADIAN = Math.PI / 180;
const renderCustomizedLabel = ({ cx, cy, midAngle, innerRadius, outerRadius, percent, index }) => {
    const radius = innerRadius + (outerRadius - innerRadius) * 0.5;
    const x = cx + radius * Math.cos(-midAngle * RADIAN);
    const y = cy + radius * Math.sin(-midAngle * RADIAN);
    return (
        <text x={x} y={y} fill="white" textAnchor={x > cx ? 'start' : 'end'} dominantBaseline="central">
        {`${(percent * 100).toFixed(0)}%`}
        </text>
    );
};

let totalData;

const CustomTooltip = ({ active, payload, label }) => {
    if (active && payload && payload.length) {
        const percent = ((payload[0].value / totalData) * 100).toFixed(2);
    
        return (
            <div className=" bg-tertiary text-success p-2 rounded-md">
                <p className="label">{`Basal : ${payload[0].value} (${percent}%)`}</p>
            </div>
        );
    }
    return null;
};


const PieChartComponent = ({data}) => {

    totalData = data.reduce((result, entry) => result + entry.value, 0);

    return (
        <ResponsiveContainer width="100%" height="100%">
            <PieChart >
                <Tooltip content={<CustomTooltip />} />
                <Pie
                    data={data}
                    labelLine={false}
                    label={renderCustomizedLabel}
                    fill="#8884d8"
                    dataKey="value"
                >
                    {data.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                    ))}
                </Pie>
            </PieChart>
        </ResponsiveContainer>
        );
}

export default PieChartComponent;