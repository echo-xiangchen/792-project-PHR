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
                id: "BP-20230704242",
                time: "2024-03-04T06:05:00",
                type: "Bolus",
                unit: 5,
            },
            
            {
                id: "BP-202307041312",
                time: "2024-03-03T06:05:00",
                type: "Bolus",
                unit: 2,
            },
            {
                id: "BP-202307078324",
                time: "2024-02-29T06:05:00",
                type: "Basal",
                unit: 5,
            },
        ],//Basal / Bolus
        medications: [
            {
                id: "MD-202307071349",
                name: "Humalog U-100 insulin Subcutaneous solution",
                DateFilled: "2024-01-05",
                Prescribed: "2351,5623 MD",
                instruction: "Administer xx  units before...",
                source: "Digital Health Drug Repository",
            },
            {
                id: "MD-202307071346",
                name: "Metformin HCL 500 mg",
                DateFilled: "2023-12-19",
                Prescribed: "5352,3623 MD",
                instruction: "Take 1 pill...",
                source: "Digital Health Drug Repository",
            },
            {
                id: "MD-202307071343",
                name: "Lisinopril 10mg tablet",
                DateFilled: "2024-01-05",
                Prescribed: "2351,5623 MD",
                instruction: "Administer xx  units before...",
                source: "Digital Health Drug Repository",
            },
            {
                id: "MD-202307071342",
                name: "Metformin 500mg tablet",
                DateFilled: "2024-01-05",
                Prescribed: "2351,5623 MD",
                instruction: "Administer xx  units before...",
                source: "Digital Health Drug Repository",
            },
            
        ],//id, time, value
        clinicalVisits: [
            {
                id: "CV-202307071349",
                encounterDate: "2024-01-05",
                dischargeDate: "2024-01-05",
                type: "Emergency",
                status: "Completed",
                reason: "Hypoglycemia",
                facility: "Hamilton Hosp",
            }
        ],
        labResults: [
            {
                id: "LR-202307071349",
                requestedOn: "2024-01-02",
                collectOn: "2024-01-09",
                test: "Basic Metabolic Panel (BMP)",
                status: "Final result",
                orderedBy: "ThomasX, MD",
                facility: "Alexandra Hospital",
            }
        ],
        weight: [
            {
                id: "WT-202307071349",
                time: "2024-03-06",
                value: 56,
            },
            {
                id: "WT-202307071346",
                time: "2024-03-05",
                value: 57,
            },
            {
                id: "WT-202307071343",
                time: "2024-03-04",
                value: 59,
            },
            {
                id: "WT-202307071342",
                time: "2024-03-03",
                value: 63,
            },
            {
                id: "WT-202307071341",
                time: "2024-03-02",
                value: 62,
            },
            {
                id: "WT-202307071340",
                time: "2024-03-01",
                value: 64,
            },
            {
                id: "WT-202307071339",
                time: "2024-02-29",
                value: 61,
            },
        ],
        exercises: [
            {
                id: "EX-202307071349",
                time: "2024-03-06",
                exercise: "Running",
                duration: 30,
                intensity: "Medium",
                caloriesBurned: 110,
            },
            {
                id: "EX-202307071346",
                time: "2024-03-05",
                exercise: "Running",
                duration: 45,
                intensity: "Medium",
                caloriesBurned: 110,
            },
            {
                id: "EX-202307071343",
                time: "2024-03-04",
                exercise: "Running",
                duration: 60,
                intensity: "Medium",
                caloriesBurned: 110,
            },
            {
                id: "EX-202307071342",
                time: "2024-03-03",
                exercise: "Running",
                duration: 20,
                intensity: "Medium",
                caloriesBurned: 110,
            },
            {
                id: "EX-202307071341",
                time: "2024-03-02",
                exercise: "Running",
                duration: 120,
                intensity: "Medium",
                caloriesBurned: 110,
            },
            {
                id: "EX-202307071340",
                time: "2024-03-01",
                exercise: "Running",
                duration: 70,
                intensity: "Medium",
                caloriesBurned: 110,
            },
            {
                id: "EX-202307071339",
                time: "2024-02-29",
                exercise: "Running",
                duration: 40,
                intensity: "Medium",
                caloriesBurned: 110,
            },
        ],
        dietaryIntake: [
            {
                id: "DI-202307071349",
                time: "2024-03-06",
                carbs: 156,
                calories: 2400,
            },
            {
                id: "DI-202307071346",
                time: "2024-03-05",
                carbs: 156,
                calories: 2300,
            },
            {
                id: "DI-202307071343",
                time: "2024-03-04",
                carbs: 116,
                calories: 2600,
            },
            {
                id: "DI-202307071342",
                time: "2024-03-03",
                carbs: 136,
                calories: 2100,
            },
            {
                id: "DI-202307071341",
                time: "2024-03-02",
                carbs: 126,
                calories: 2200,
            },
            {
                id: "DI-202307071340",
                time: "2024-03-01",
                carbs: 186,
                calories: 2550,
            },
            {
                id: "DI-202307071339",
                time: "2024-02-29",
                carbs: 156,
                calories: 2400,
            },
        ]
    }
}