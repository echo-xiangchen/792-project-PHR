import React from 'react';
// Importing components from recharts for chart visualization.
import {ResponsiveContainer, LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend,Label } from 'recharts';

// Constants defining the lower and upper limits for the blood glucose values.
import { BGLOWERLIMITE, BGUPPERLIMIT } from '../../constants';
import { BGBelowColor, BGInColor, BGAboveColor } from '../../constants';

// Constants defining the lower and upper limits for the blood Pressure values.
import { 
    DIASTOLIC_NORMAL, 
    DIASTOLIC_UPPERLIMIT,

    SYSTOLIC_NORMAL,
    SYSTOLIC_UPPERLIMIT,

    BPLowerColor,
    BPInColor,
    BPAboveColor,

} from '../../constants';

// Function to format the date and time from the dateTimeString parameter.
const formatDateTime = (dateTimeString, format = 'hh:mm:ss') => {
    const date = new Date(dateTimeString);
    // Formats the date into a readable string.
    const defaultTime = `${String(date.getMonth() + 1).padStart(2, '0')}/${String(date.getDate()).padStart(2, '0')} ${String(date.getHours()).padStart(2, '0')}-${String(date.getMinutes()).padStart(2, '0')}`;
    return defaultTime;
};

// The SingleLineChart component, accepting 'data' as props.
export const SingleLineChart = ({data, type = "bloodGlucose"}) => {
    let YLabel,Xlabel,XdataKey,YdataKey, CustomTooltip;

    switch(type){
        case "bloodGlucose":
            Xlabel = "reading date";
            XdataKey = "time";
            YLabel = "reading value(mmHg)";
            YdataKey = "value";


            // CustomTooltip component for displaying details on hover.
            CustomTooltip = ({ active, payload, label }) => {
                // Conditional rendering based on the 'active' state and if 'payload' contains data.
                if (active && payload && payload.length) {
                    // Determines the color of the text based on the value's relation to the limits.
                    const color = payload[0].value < BGLOWERLIMITE ? `text-${BGBelowColor}` : payload[0].value > BGUPPERLIMIT ? `text-${BGAboveColor}` : `text-${BGInColor}`;
                    // Returns the tooltip component with styled div and text.
                    return (
                        <div className='bg-tertiary w-auto text-primary p-2 rounded-lg shadow-product text-sm flex flex-col gap-1'>
                            <p className={color}>
                                {`Reading value: ${(payload[0].value)} mmol/L`}
                            </p>
                            <p className="">{`Date: ${formatDateTime(label,"hh:mm:ss")}`}</p>
                        </div>
                    );
                }
                // Returns null if conditions are not met (no tooltip to display).
                return null;
            };
            break;
        case "weightControl":
            Xlabel = "Date"
            XdataKey = "time";
            YLabel = "Weight (Kgs)"
            YdataKey = "value";
            // CustomTooltip component for displaying details on hover.
            CustomTooltip = ({ active, payload, label }) => {
                // Conditional rendering based on the 'active' state and if 'payload' contains data.
                if (active && payload && payload.length) {
                    // Determines the color of the text based on the value's relation to the limits.
                    const color = `text-${BGInColor}`;
                    // Returns the tooltip component with styled div and text.
                    return (
                        <div className='bg-tertiary w-auto text-primary p-2 rounded-lg shadow-product text-sm flex flex-col gap-1'>
                            <p className={color}>
                                {`weight: ${(payload[0].value)} Kgs`}
                            </p>
                            <p className="">{`Date: ${formatDateTime(label,"MM-DD")}`}</p>
                        </div>
                    );
                }
                // Returns null if conditions are not met (no tooltip to display).
                return null;
            }
            break;
        case "exercise":
            Xlabel = "Date"
            XdataKey = "time";
            YLabel = "Duration (minutes)"
            YdataKey = "duration";
            // CustomTooltip component for displaying details on hover.
            CustomTooltip = ({ active, payload, label }) => {
                // Conditional rendering based on the 'active' state and if 'payload' contains data.
                if (active && payload && payload.length) {
                    // Determines the color of the text based on the value's relation to the limits.
                    const color = `text-${BGInColor}`;
                    // Returns the tooltip component with styled div and text.
                    return (
                        <div className='bg-tertiary w-auto text-primary p-2 rounded-lg shadow-product text-sm flex flex-col gap-1'>
                            <p className={color}>
                                {`value: ${(payload[0].value)} minutes`}
                            </p>
                            <p className="">{`Date: ${formatDateTime(label,"MM-DD")}`}</p>
                        </div>
                    );
                }
                // Returns null if conditions are not met (no tooltip to display).
                return null;
            }
            break;
        case "dietaryIntake":
            Xlabel = "Date"
            XdataKey = "time";
            YLabel = "Carbs (grams)"
            YdataKey = "carbs";
            // CustomTooltip component for displaying details on hover.
            CustomTooltip = ({ active, payload, label }) => {
                // Conditional rendering based on the 'active' state and if 'payload' contains data.
                if (active && payload && payload.length) {
                    // Determines the color of the text based on the value's relation to the limits.
                    const color = `text-${BGInColor}`;
                    // Returns the tooltip component with styled div and text.
                    return (
                        <div className='bg-tertiary w-auto text-primary p-2 rounded-lg shadow-product text-sm flex flex-col gap-1'>
                            <p className={color}>
                                {`Carbs: ${(payload[0].value)} grams`}
                            </p>
                            <p className="">{`Date: ${formatDateTime(label,"MM-DD")}`}</p>
                        </div>
                    );
                }
                // Returns null if conditions are not met (no tooltip to display).
                return null;
            }
            break;
    }
    // Sorts the data by date to ensure correct order in the chart.
    data = data.sort((a, b) => new Date(a.time) - new Date(b.time));

    const LabelX = () => (
        <text 
            x="50%"
            y="95%"
            fontSize="16"
            fill="#003F4F"
            textAnchor="middle"
        >
            {Xlabel}
        </text>
    )

    const LabelY = () =>(
        <text 
            //transform angle="-90"
            transform='rotate(-90) translate(-110, 20)'
            fontSize="16"
            fill="#003F4F"
            textAnchor="middle"
        >
            {YLabel}
        </text>
    )

    // The main rendering of the line chart using ResponsiveContainer for responsiveness.
    return (
        <ResponsiveContainer>
            <LineChart data={data}>
                <XAxis 
                    dataKey={XdataKey} 
                    tick={false}
                    label={<LabelX/>}
                />
                <YAxis
                    label={<LabelY/>}
                />
                <Tooltip content={<CustomTooltip/>}/>
                <CartesianGrid strokeDasharray="3 3" /> 
                <Line 
                    type="monotone" 
                    dataKey={YdataKey}
                    stroke="#8884d8" 
                />
            </LineChart>
        </ResponsiveContainer>
    );
}

export const MultiLineChart = ({data}) => {
    // CustomTooltip component for displaying details on hover.
    const CustomTooltip = ({ active, payload, label }) => {
        // Conditional rendering based on the 'active' state and if 'payload' contains data.
        if (active && payload && payload.length) {
            // Determines the color of the text based on the value's relation to the limits.
            const SYSTOLIC_color = payload[0].value < SYSTOLIC_NORMAL ? `text-${BPInColor}` : payload[0].value < SYSTOLIC_UPPERLIMIT ? `text-${BPLowerColor}` : `text-${BPAboveColor}`;
            const DIASTOLIC_color = payload[1].value < DIASTOLIC_NORMAL ? `text-${BPInColor}` : payload[1].value < DIASTOLIC_UPPERLIMIT ? `text-${BPLowerColor}` : `text-${BPAboveColor}`;

            // Returns the tooltip component with styled div and text.
            return (
                <div className='bg-tertiary w-auto text-primary p-2 rounded-lg shadow-product text-sm flex flex-col gap-1'>
                    <p className={SYSTOLIC_color}>
                        {`Systolic: ${(payload[0].value)} mmHg`}
                    </p>
                    <p className={DIASTOLIC_color}>
                        {`Diastolic: ${(payload[1].value)} mmHg`}
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

    const LabelX = () => (
        <text 
            x="50%"
            y="95%"
            fontSize="16"
            fill="#003F4F"
            textAnchor="middle"
        >
            reading date
        </text>
    )

    const LabelY = () =>(
        <text 
            //transform angle="-90"
            transform='rotate(-90) translate(-110, 20)'
            fontSize="16"
            fill="#003F4F"
            textAnchor="middle"
        >
            reading value(mmHg)
        </text>
    )
    // The main rendering of the line chart using ResponsiveContainer for responsiveness.
    return (
        <ResponsiveContainer>
            <LineChart data={data}>
                <XAxis dataKey="time" label={<LabelX/>} tick={false} />
                <YAxis label={<LabelY/>}/>
                <Tooltip content={<CustomTooltip/>}/> 
                <CartesianGrid strokeDasharray="3 3" /> 
                <Line 
                    //type="monotone" 
                    dataKey="systolic" 
                    stroke="#8884d8" 
                />
                <Line 
                    //type="monotone" 
                    dataKey="diastolic" 
                    stroke="#8884d8" 
                />
            </LineChart>
        </ResponsiveContainer>
    );
}

