import {
    loginAvatar,
} from '../assets';

//here we simulation the user database after login
export const loginUser = {
    userid: "XC-202307071349",
    basicInfo: {
        firstName : "Yun",
        lastName : "Ma",
        avatar: loginAvatar,
        gender: "Male",
        height: 175,
        bloodType: "A+",
    },
    patientData:{
        bloodGlucose: [],//id, time, value
        bloodPressure: [],//id, time, value
        insulin: [],//id, time, value
        medications: [],//id, time, value
        weight: [],//id, time, value
    }
}