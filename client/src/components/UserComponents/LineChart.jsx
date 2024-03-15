import React from 'react';
// Importing components from recharts for chart visualization.
import {ResponsiveContainer, LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';

// Constants defining the lower and upper limits for the blood glucose values.
const LOWERLIMITE = 70;
const UPPERLIMIT = 180;

// Function to format the date and time from the dateTimeString parameter.
const formatDateTime = (dateTimeString, format = 'hh:mm:ss') => {
    const date = new Date(dateTimeString);
    // Formats the date into a readable string.
    const defaultTime = `${String(date.getMonth() + 1).padStart(2, '0')}/${String(date.getDate()).padStart(2, '0')} ${String(date.getHours()).padStart(2, '0')}-${String(date.getMinutes()).padStart(2, '0')}`;
    return defaultTime;
};

// The SingleLineChart component, accepting 'data' as props.
export const SingleLineChart = ({data}) => {
    // CustomTooltip component for displaying details on hover.
    const CustomTooltip = ({ active, payload, label }) => {
        // Conditional rendering based on the 'active' state and if 'payload' contains data.
        if (active && payload && payload.length) {
            // Determines the color of the text based on the value's relation to the limits.
            const color = payload[0].value < LOWERLIMITE ? 'text-yellow' : payload[0].value > UPPERLIMIT ? 'text-error' : 'text-success';
            // Returns the tooltip component with styled div and text.
            return (
                <div className='bg-tertiary w-auto text-primary p-2 rounded-lg shadow-product text-sm flex flex-col gap-1'>
                    <p className={color}>
                        {`Reading value: ${(payload[0].value)} mg/dL`}
                    </p>
                    <p className="">{`Date: ${formatDateTime(label,"hh:mm:ss")}`}</p>
                </div>
            );
        }
        // Returns null if conditions are not met (no tooltip to display).
        return null;
    };
    // Sorts the data by date to ensure correct order in the chart.
    data = data.sort((a, b) => new Date(a.time) - new Date(b.time));

    // The main rendering of the line chart using ResponsiveContainer for responsiveness.
    return (
        <ResponsiveContainer>
            <LineChart data={data}>
                <XAxis 
                    dataKey="time" 
                    hide={true} // Hides the XAxis for a cleaner look.
                />
                <Tooltip content={<CustomTooltip/>}/> // Custom tooltip for data points.
                <CartesianGrid strokeDasharray="3 3" /> // Adds a grid for better readability.
                <Line 
                    type="monotone" // Creates a smooth line.
                    dataKey="value" 
                    stroke="#8884d8"  // Line color.
                />
            </LineChart>
        </ResponsiveContainer>
    );
}
