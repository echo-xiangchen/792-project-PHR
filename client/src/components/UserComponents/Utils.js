const LOWERLIMITE = 3.9;
const UPPERLIMITE = 7.2;

export const calculatePercentage = (bloodGlucoseValue) => {
    // TODO: Implement handling for when bloodGlucoseValue is empty or null to prevent errors or provide default values.

    // Calculates the total number of blood glucose values.
    const total = bloodGlucoseValue.length;

    const { max, min, average, standardDeviation } = calculateMinMaxAvgSd(bloodGlucoseValue);
    // Initializes counters for values above, within, and below the target range.
    let aboveRange = 0;
    let inTargetRange = 0;
    let belowRange = 0;

    // Loops through each blood glucose value to categorize it into one of the three ranges.
    bloodGlucoseValue.forEach(value => {
        if (value < LOWERLIMITE) {
            // Increments the belowRange counter for values below 70.
            belowRange += 1;
        } else if (value > UPPERLIMITE) {
            // Increments the aboveRange counter for values above 120.
            aboveRange += 1;
        } else {
            // Increments the inTargetRange counter for values within the target range (70-120).
            inTargetRange += 1;
        }
    });

    // Returns an object containing the max, min, average, standard deviation, and percentages of values above, within, and below the target range.
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

export const calculateMinMaxAvgSd = (array) => {
    // Calculates the total number of blood glucose values.
    const total = array.length;
    // Finds the maximum blood glucose value.
    const max = Math.max(...array);
    // Finds the minimum blood glucose value.
    const min = Math.min(...array);
    // Calculates the average blood glucose value, rounded to two decimal places.
    const average = (array.reduce((a, b) => a + b, 0) / total).toFixed(2);
    // Calculates the standard deviation of blood glucose values, rounded to two decimal places.
    const standardDeviation = Math.sqrt(array.reduce((a, b) => a + (b - average) ** 2, 0) / total).toFixed(2);
    
    // Returns an object containing the max, min, average, standard deviation
    return {
        max,
        min,
        average,
        standardDeviation,
    };
}

// Defines a function named groupByDate that takes an array of blood glucose readings as its argument.
export const groupByDate = (bloodGlucose) => {
    // Initializes an empty object to store the grouped blood glucose readings by date.
    const groupedByDate = {};

    // Iterates over each blood glucose reading in the array.
    bloodGlucose.forEach(({ time, value }) => {
        // Converts the time of the reading into a JavaScript Date object.
        const date = new Date(time);
        // Formats the date into a more readable string, including the weekday, year, month, and day.
        const dateString = date.toLocaleDateString('en-US', {
            weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
        });
        // Formats the time of the reading into a string in the format of "hours:minutes".
        const timeString = `${date.getHours()}:${String(date.getMinutes()).padStart(2, '0')}`;

        // Checks if the date string is not already a key in the groupedByDate object. If not, initializes it with an empty array.
        if (!groupedByDate[dateString]) {
            groupedByDate[dateString] = [];
        }
        // Adds the current reading (with its time reformatted to timeString and its value) to the array corresponding to its date.
        groupedByDate[dateString].push({ time: timeString, value });
    });

    // Transforms the groupedByDate object into an array of objects, each representing a date and its associated readings.
    // This is done by mapping over the entries (key-value pairs) of the groupedByDate object.
    return Object.entries(groupedByDate).map(([date, value]) => ({
        date, // The date string
        value, // The array of readings for that date
    }));
};

// Defines a function named groupByDate that takes an array of blood glucose readings as its argument.
export const groupByDatePressure = (bloodPressure) => {
    // Initializes an empty object to store the grouped blood glucose readings by date.
    const groupedByDate = {};

    // Iterates over each blood glucose reading in the array.
    bloodPressure.forEach(({ time, systolic, diastolic, pulse }) => {
        // Converts the time of the reading into a JavaScript Date object.
        const date = new Date(time);
        // Formats the date into a more readable string, including the weekday, year, month, and day.
        const dateString = date.toLocaleDateString('en-US', {
            weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'
        });
        // Formats the time of the reading into a string in the format of "hours:minutes".
        const timeString = `${date.getHours()}:${String(date.getMinutes()).padStart(2, '0')}`;
        // Checks if the date string is not already a key in the groupedByDate object. If not, initializes it with an empty array.
        if (!groupedByDate[dateString]) {
            groupedByDate[dateString] = [];
        }
        // Adds the current reading (with its time reformatted to timeString and its value) to the array corresponding to its date.
        groupedByDate[dateString].push({ time: timeString, systolic, diastolic, pulse });
    });
    return Object.entries(groupedByDate).map(([date, value]) => ({
        date, // The date string
        value, // The array of readings for that date
    }));
    // Transforms the groupedByDate object into an array of objects, each representing a date and its associated readings.
    // This is done by mapping over the entries (key-value pairs) of the groupedByDate object.
    // return Object.entries(groupedByDate).map(([date, systolic, diastolic, pulse]) => {
    //     console.log(systolic);
    //     return {
    //         date, // The date string
    //         value, // The array of readings for that date
    //     }
    // });
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

//get start and end time, return the data in the range
export function summarizeInjections(insulinData, startDate, endDate) {
    const bolusCounts = {};
    const basalCounts = {};
    let currentDate = new Date(startDate);

    while (currentDate <= new Date(endDate)) {
        const dateString = currentDate.toISOString().split('T')[0];
        bolusCounts[dateString] = 0;
        basalCounts[dateString] = 0;
        currentDate.setDate(currentDate.getDate() + 1);
    }

    insulinData.forEach(record => {
        const recordDate = record.time.split('T')[0];
        if (recordDate >= startDate && recordDate <= endDate) {
            if (record.type === 'Bolus') {
                bolusCounts[recordDate] += record.unit;
            } else if (record.type === 'Basal') {
                basalCounts[recordDate] += record.unit;
            }
        }
    });

    const bolusArray = Object.keys(bolusCounts).map(date => ({date, unit: bolusCounts[date]}));
    const basalArray = Object.keys(basalCounts).map(date => ({date, unit: basalCounts[date]}));

    return {
        Bolus: bolusArray,
        Basal: basalArray
    };
}