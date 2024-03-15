export const calculatePercentage = (bloodGlucoseValue) => {
    //TODO: IF bloodGlucoseValue is empty

    const total = bloodGlucoseValue.length;
    const max = Math.max(...bloodGlucoseValue);
    const min = Math.min(...bloodGlucoseValue);
    const average = (bloodGlucoseValue.reduce((a, b) => a + b, 0) / total).toFixed(2);
    //standard deviation
    const standardDeviation = Math.sqrt(bloodGlucoseValue.reduce((a, b) => a + (b - average) ** 2, 0) / total).toFixed(2);
    let aboveRange = 0;
    let inTargetRange = 0;
    let belowRange = 0;

    //LOOP
    bloodGlucoseValue.forEach(value => {
        if (value < 70) {
        belowRange += 1;
        } else if (value > 120) {
        aboveRange += 1;
        } else {
        inTargetRange += 1;
        }
    });

    return {
        max,
        min,
        average,
        standardDeviation,
        aboveRangePercentage: (aboveRange / total * 100).toFixed(2) + '%',
        inTargetRangePercentage: (inTargetRange / total * 100).toFixed(2) + '%',
        belowRangePercentage: (belowRange / total * 100).toFixed(2) + '%',
    };
}

export const groupByDate = (bloodGlucose) => {
    const groupedByDate = {};

    bloodGlucose.forEach(({ time, value }) => {
        const date = new Date(time);
        const dateString = date.toLocaleDateString('en-US', {
            weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
        });
        const timeString = `${date.getHours()}:${String(date.getMinutes()).padStart(2, '0')}`;

        if (!groupedByDate[dateString]) {
            groupedByDate[dateString] = [];
        }
        groupedByDate[dateString].push({ time: timeString, value });
    });

    return Object.entries(groupedByDate).map(([date, value]) => ({
        date,
        value,
    }));
};


//get start and end time, return the data in the range
export const filterByTimeRange = (bloodGlucose, startTime, endTime) => {
    const start = new Date(startTime);
    const end = new Date(endTime);
    return bloodGlucose.filter(({ time }) => {
        const itemTime = new Date(time);
        return itemTime >= start && itemTime <= end;
    });
};


export const timeToString = (time,timePicker) => {
    const date = new Date(time);

    const getWeekNumber = (date) => {
    const firstDayOfYear = new Date(date.getFullYear(), 0, 1);
    const pastDaysOfYear = (date - firstDayOfYear) / 86400000;
    return Math.ceil((pastDaysOfYear + firstDayOfYear.getDay() + 1) / 7);
    };

    switch (timePicker) {
    case '1 day':
        return date.toDateString(); //full date
    case '1 week':
        const weekNumber = getWeekNumber(date);
        return `${date.getMonth() + 1} Month ${weekNumber} Week`;
    case '1 month':
        return `${date.getFullYear()} Year ${date.getMonth() + 1} Month`;
    case '1 year':
        return `${date.getFullYear()} Year`;
    default:
        return date.toDateString(); //full date
    }
}