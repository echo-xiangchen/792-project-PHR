import {
    loginAvatar,
} from '../assets';

//here we simulation the user database after login
export const loginUser = {
    id: "XC-202307071349",
    basicInfo: {
        firstName : "Anne",
        lastName : "Smith",
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
                systolic: 135 ,
                diastolic: 85 ,
                pulse: 60,
            },
            {
                id: "BP-202307071346",
                time: "2024-03-05T07:01:00",
                systolic: 120 ,
                diastolic: 75 ,
                pulse: 58,
            },
            {
                id: "BP-202307071343",
                time: "2024-03-04T12:35:00",
                systolic: 180 ,
                diastolic: 100 ,
                pulse: 80,
            },
            {
                id: "BP-202307071342",
                time: "2024-03-03T06:51:00",
                systolic: 90 ,
                diastolic: 55 ,
                pulse: 60,
            },
            {
                id: "BP-202307071341",
                time: "2024-03-02T07:03:00",
                systolic: 155 ,
                diastolic: 95 ,
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
                reason: "Symptoms of Hypoglycemia",
                facility: "Hamilton Hospital",
                Diagnosis: "Hypoglycemia",
                Doctor: "Will Smith; Physician", 
                reportedSymptoms: [
                    "Trembling",
                    "Excessive sweating",
                    "Confusion",
                    "Dizziness",
                ],
                physicalExamination: [
                    "Blood pressure: 110/70 mmHg",
                    "Heart rate: 98bpm",
                    "Temperature: 36.5°C(97.7°F)",
                ],
                treatmentsAndProcedures: [
                    "Upon admission, blood glucose was measured, reporting a level of 2.8 mmol/L. ",
                    "Measurements continued every 15 minutes for the first hour and then every 30 minutes until stabilization.",    
                    "15 grams of oral glucose gel were administrated.",
                    "Blood samples were taken to assess possible underlying causes of hypoglycemia.",
                    "Due to persistent hypoglycemia symptoms and low blood glucose levels after oral administration, a 5% glucose solution was administered intravenously.",
                    "intravenous infusion was initiated.",
                ],
                tests: [
                    {
                        id: "T-202307071349",
                        time: "2024-02-14T10:45:00",
                        name: "Blood Glucose",
                        result: {
                            value: 2.8,
                            unit: "mmol/L",
                            status: "Critical",
                        },
                        referenceRange: "3.9-7.8 mmol/L(Non Fasting)",
                    },
                    {
                        id : "T-202307071348",
                        time: "2024-02-14T10:50:00",
                        name: "Insulin",
                        result: {
                            value: 180,
                            unit: "pmol/L",
                            status: "Critical",
                        },
                        referenceRange: "18-173 pmol/L",
                    },
                    {
                        id : "T-202307071347",
                        time: "2024-02-14T10:58:00",
                        name: "C-Peptide",
                        result: {
                            value: 0.33,
                            unit: "nmol/L",
                            status: "Critical",
                        },
                        referenceRange: "0.37-1.47 nmol/L",
                    }
                ],
                radiology: [

                ],
                medications: [
                    {
                        id: "MD-202307071349",
                        name: "Humalog U-100 insulin Subcutaneous solution",
                        instruction: "Administer xx  units before meals and at bedtime.",
                    },
                    {
                        id: "MD-202307071348",
                        name: "Metformin HCL 500 mg",
                        instruction: "Take 1 pill by mouth twice daily with food.",
                    },
                    {
                        id: "MD-202307071347",
                        name: "Diazoxide 100 mg",
                        instruction: "Take one capsule in the morning and one in the evening, with food to minimize stomach upset.",
                    }
                ],
                followUp: [
                    "Call your Family Physician or Primary Care Provider for general medical concerns.",
                    "Monitor blood glucose levels closely and seek medical attention if symptoms of hypoglycemia occur.",
                    "Contact your healthcare provider if you experience any side effects from the prescribed medications.",
                ]
            }
        ],
        labResults: [
            {
                id: 'LR-72', 
                requestOn: '2023-11-24T10:30:00Z', 
                collectOn: '2023-11-30T08:30:00+11:00', 
                requestedOn: '2023-11-30T12:30:00Z',
                test: "Lipid Panel",
                testResult: [
                    {code: 'Cholesterol Total', value: 4.7, unit: 'mmol/L', low: -1, high: 5.2},
                    {code: 'HDL Cholesterol', value: 2.8, unit: 'mmol/L', low: 1, high: 10000},
                    {code: 'Triglycerides', value: 1, unit: 'mmol/L', low: -1, high: 1.7}
                ],
            },
            {
                id: 'LR-73', 
                requestOn: '2023-11-24T10:30:00Z', 
                collectOn: '2023-11-30T08:30:00+11:00', 
                requestedOn: '2023-11-30T12:30:00Z',
                test: "Lipid Panel",
                testResult: [
                    {code: 'Cholesterol Total', value: 4.7, unit: 'mmol/L', low: -1, high: 5.2},
                    {code: 'HDL Cholesterol', value: 2.8, unit: 'mmol/L', low: 1, high: 10000},
                    {code: 'Triglycerides', value: 1, unit: 'mmol/L', low: -1, high: 1.7}
                ],
            },
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


const dataSource = [
    {
        key: 0,
        name: "2023-11-30T08:30:00+11:00",
        CholesterolTotal: {value: 4.3, unit: 'mmol/L', low: -1, high: 5.2},
        HDLCholesterol : {value: 3.2, unit: 'mmol/L', low: 1, high: 10000},
        LDLCholesterol : {value: 3.1, unit: 'mmol/L', low: -1, high: 3.4},
        Triglycerides : {value: 1.3, unit: 'mmol/L', low: -1, high: 1.7}
    },
    {
        key: 0,
        name: "2023-11-30T08:30:00+11:00",
        CholesterolTotal: {value: 4.3, unit: 'mmol/L', low: -1, high: 5.2},
        HDLCholesterol : {value: 3.2, unit: 'mmol/L', low: 1, high: 10000},
        LDLCholesterol : {value: 3.1, unit: 'mmol/L', low: -1, high: 3.4},
        Triglycerides : {value: 1.3, unit: 'mmol/L', low: -1, high: 1.7}
    },
]