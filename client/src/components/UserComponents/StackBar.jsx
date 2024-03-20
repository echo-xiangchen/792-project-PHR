import React from 'react'

//chart
import { AreaChart,Area,BarChart, Bar, Cell, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';


// DIY tooltip
const CustomTooltip = ({ active, payload, label }) => {
    if (active && payload && payload.length) {
        return (
            <div className='bg-tertiary w-auto text-primary p-2 rounded-lg shadow-product text-sm flex flex-col gap-1'>
                <p className="">{`${(payload[2].value)}%`}</p>
                <p className="">{`${(payload[1].value)}%`}</p>
                <p className="">{`${(payload[0].value)}%`}</p>
            </div>
        );
    }
    return null;
};

const StackBar = ({aboveRangePercentage,inTargetRangePercentage,belowRangePercentage }) => {

    const barData = [
        { 
            name: 'Range', 
            Above: parseFloat(aboveRangePercentage),
            InTarget: parseFloat(inTargetRangePercentage),
            Below: parseFloat(belowRangePercentage),
        },
        { 
            name: 'Range', 
            Above: parseFloat(aboveRangePercentage),
            InTarget: parseFloat(inTargetRangePercentage),
            Below: parseFloat(belowRangePercentage),
        },
    ]

    return(
        <ResponsiveContainer 
            style={{
                borderRadius: '10px',
                border: '1px solid #003F4F',
                maxWidth: '50px',
            }}
        >
            <AreaChart
                data={barData}
                stackOffset="expand"
            >
                <CartesianGrid 
                    vertical={false}
                    horizontal={false}
                />
                <XAxis hide={true}/>
                <YAxis 
                    hide={true}
                    />
                <Tooltip 
                    content={<CustomTooltip/>}
                    position={{
                        y: 0,
                        x: 50,
                    }}
                    cursor={{fill: 'none'}}
                />
                <Area dataKey="Above" stackId="1" fill="#FF0000" />
                <Area dataKey="InTarget" stackId="1" fill="#1AAD19" />
                <Area dataKey="Below"stackId="1"  fill="#FFD700" />
            </AreaChart>
        </ResponsiveContainer>
    )
}

export default StackBar