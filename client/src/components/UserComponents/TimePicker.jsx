import React from 'react'

//react
import { useState } from 'react'

const TimePicker = ({timePicker, setTimePicker}) => {

    //default time should end today start last 1 day
    const [ dataPeriod, setDataPeriod ] = useState({
        startTime : "2024-02-06T00:00:00", //TEST
        endTime :   "2024-06-07T00:00:00", //TEST
        //startTime: new Date().setDate(new Date().getDate() - 1),
        //endTime: new Date(),
    }) // State for managing data period
    return (
        <div>TimePicker</div>
    )
}

export default TimePicker