import {
    loginAvatar,
} from '../assets';

//here we simulation the user database after login
export const loginUser = {
    userid: "XC-202307071349",
    basicInfo: {
        firstName : "Yun",
        lastName : "Ma",
        age: 68,
        avatar: loginAvatar,
        gender: "Male",
        height: 175,
        bloodType: "A+",
    },
    patientData:{
        bloodGlucose: [
            {
                id: "BG-202307071349",
                time: "2024-03-06T06:51:00",
                value: 5.1,
            },
            {
                id: "BG-202307071346",
                time: "2024-03-06T12:03:00",
                value: 5.6,
            },
            {
                id: "BG-202307071343",
                time: "2024-03-06T18:35:00",
                value: 6.4,
            },
            {
                id: "BG-202307071342",
                time: "2024-03-05T06:51:00",
                value: 5.07,
            },
            {
                id: "BG-202307071341",
                time: "2024-03-05T12:03:00",
                value: 10.3,
            },
            {
                id: "BG-202307071340",
                time: "2024-03-05T18:35:00",
                value: 3.2,
            },
            {
                id: "BG-202307071339",
                time: "2024-02-29T06:51:00",
                value: 5.1,
            },
        ],//id, time, value
        bloodPressure: [
            {
                id: "BP-202307071349",
                time: "2024-03-06T06:51:00",
                systolic: 110,
                diastolic: 70,
                pulse: 60,
            },
            {
                id: "BP-202307071346",
                time: "2024-03-05T07:01:00",
                systolic: 113,
                diastolic: 71,
                pulse: 58,
            },
            {
                id: "BP-202307071343",
                time: "2024-03-04T12:35:00",
                systolic: 130,
                diastolic: 90,
                pulse: 80,
            },
            {
                id: "BP-202307071342",
                time: "2024-03-03T06:51:00",
                systolic: 110,
                diastolic: 70,
                pulse: 60,
            },
            {
                id: "BP-202307071341",
                time: "2024-03-02T07:03:00",
                systolic: 120,
                diastolic: 80,
                pulse: 70,
            },
        ],//id, time, value
        insulin: [
            {
                id: "BP-202307071349",
                time: "2024-03-06T21:05:00",
                type: "Basal",
                unit: 10,
            },
            {
                id: "BP-202307071346",
                time: "2024-03-06T18:05:00",
                type: "Bolus",
                unit: 2,
            },
            {
                id: "BP-202307071343",
                time: "2024-03-06T12:05:00",
                type: "Bolus",
                unit: 2,
            },
            {
                id: "BP-202307071342",
                time: "2024-03-06T06:05:00",
                type: "Bolus",
                unit: 2,
            },
            {
                id: "BP-202307041349",
                time: "2024-03-05T21:05:00",
                type: "Basal",
                unit: 10,
            },
            {
                id: "BP-202307041346",
                time: "2024-03-05T18:05:00",
                type: "Bolus",
                unit: 2,
            },
            {
                id: "BP-202307041343",
                time: "2024-03-05T12:05:00",
                type: "Bolus",
                unit: 2,
            },
            {
                id: "BP-202307041342",
                time: "2024-03-05T06:05:00",
                type: "Bolus",
                unit: 2,
            },
            {
                id: "BP-202307078342",
                time: "2024-02-29T06:05:00",
                type: "Basal",
                unit: 5,
            },
        ],//Basal / Bolus
        medications: [],//id, time, value
        weight: [],//id, time, value
    }
}