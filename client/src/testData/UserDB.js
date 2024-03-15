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
                value: 91,
            },
            {
                id: "BG-202307071346",
                time: "2024-03-06T12:03:00",
                value: 101,
            },
            {
                id: "BG-202307071343",
                time: "2024-03-06T18:35:00",
                value: 114,
            },
            {
                id: "BG-202307071342",
                time: "2024-03-05T06:51:00",
                value: 91,
            },
            {
                id: "BG-202307071341",
                time: "2024-03-05T12:03:00",
                value: 185,
            },
            {
                id: "BG-202307071340",
                time: "2024-03-05T18:35:00",
                value: 75,
            },
            {
                id: "BG-202307071339",
                time: "2024-02-29T18:35:00",
                value: 91,
            },
            {
                id: "BG-202307071339",
                time: "2024-02-29T14:35:00",
                value: 31,
            },
        ],//id, time, value
        bloodPressure: [],//id, time, value
        insulin: [],//id, time, value
        medications: [],//id, time, value
        weight: [],//id, time, value
    }
}