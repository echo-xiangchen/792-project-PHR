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
                time: "2024-03-06T08:35:00",
                value: 91,
            },
            {
                id: "BG-202307071346",
                time: "2024-03-06T02:35:00",
                value: 41,
            },
        ],//id, time, value
        bloodPressure: [],//id, time, value
        insulin: [],//id, time, value
        medications: [],//id, time, value
        weight: [],//id, time, value
    }
}