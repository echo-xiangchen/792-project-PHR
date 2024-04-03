// Import createSlice from Redux Toolkit
import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';

//import simulation data
import { loginUser } from '../../testData/UserDB';

//avatar
import {
    loginAvatar,
} from '../../assets';

//Axios
import axios from "axios"

//api
import * as api from '../../api';

// export const postBloodGlucose = createAsyncThunk(
//     'profile/postBloodGlucose',
//     async (data, { rejectWithValue }) => {
//         try {
//             console.log('Posting blood glucose data...', data);
//             // const response = await api.postBloodGlucose("1",data);
//             // return response.data;
//             return [];
//         } catch (error) {
//             console.log('Error:', error);
//             return rejectWithValue(error.response.data);
//         }
//     }
// );




// Connect to Docker and obtain the profile data
export const fetchProfile = createAsyncThunk(
    'profile/fetchProfile',
    async (id, { rejectWithValue }) => {
        const patientID = id;
        const start_date = "2024-02-29";
        const end_date = "2024-06-29";
        const basicInfo = {
            firstName : "Anne",
            lastName : "Smith",
            age: 68,
            avatar: loginAvatar,
            gender: "Male",
            height: 175,
            bloodType: "A+",
        };

        //we only need the blood glucose and lab results here, otherwise we use simulate data
        let bloodGlucose,labResults;
        //We obtain the blood glucose data from the server
        try {
            //blood glucose code
            const code = "14743-9";
            console.log('Fetching blood glucose data...');
            //send request to the server, get the 
            const response = await axios.get('http://localhost:8080/fhir/Observation', {
                params: {
                    code: `http://loinc.org|${code}`,
                    subject: `Patient/${patientID}`,
                    date: `ge${start_date}`,
                    date: `le${end_date}`,
                    _sort: '-date'
                }
            });

            const entries = response.data.entry;

            bloodGlucose = entries.map((item) => {
                //extract the data from the response
                const resource = item.resource;
                const text = resource.code.text;
                const effectiveDateTime = resource.effectiveDateTime;
                const value = resource.valueQuantity.value;
                const unit = resource.valueQuantity.unit;
                const interpretation = resource.interpretation;
    
                return {
                    mealTime: text,
                    time: effectiveDateTime,
                    value: value,
                    unit: unit,
                    interpretation: interpretation
                };
            });

            console.log('Fetch data successfull! update the data...');
            //return the profile data
            const profile = {
                id : patientID,
                basicInfo: basicInfo,
                patientData : {
                    bloodGlucose : bloodGlucose,
                    //bloodGlucose : loginUser.patientData.bloodGlucose,
                    bloodPressure : loginUser.patientData.bloodPressure,
                    insulin : loginUser.patientData.insulin,
                    medications: loginUser.patientData.medications,
                    clinicalVisits: loginUser.patientData.clinicalVisits,
                    labResults : loginUser.patientData.labResults,
                    weight : loginUser.patientData.weight,
                    exercises : loginUser.patientData.exercises,
                    dietaryIntake : loginUser.patientData.dietaryIntake,
                }
            };
            return profile;

        } catch (error) {
            console.log('Error:', error);
            return rejectWithValue(error.response.data);
        }

        //We obtain the lab results data from the server


        
    }
);
const profileSlice = createSlice({
    name: "profile",
    initialState: {
        id: null,
        basicInfo: {
            firstName : null,
            lastName : null,
            avatar: null,
            gender: null,
            height: null,
            bloodType: null,
        },
        patientData:{
            bloodGlucose: [],//id, time, value
            bloodPressure: [],//id, time, value
            insulin: [],//id, time, value
            medications: [],//id, time, value
            clinicalVisits: [],//id, encounterDate, dischargeDate, type, status, reason, facility
            weight: [],//id, time, value
            exercises: [],//id, time, exercise, duration, intensity, caloriesBurned
            dietaryIntake: [],//id, time, food, calories, carbs, fat, protein
        }
    },
    reducers: {
        // Action to set the profile
        setProfile: (state, action) => {
            return action.payload;
        },
        initProfile: (state, action) => {
            return initialState;
        },

        //***************Basic Information ****************/

        // Action to set the first name
        setFirstName: (state, action) => {
            state.basicInfo.firstName = action.payload;
        },
        // Action to set the last name
        setLastName: (state, action) => {
            state.basicInfo.lastName = action.payload;
        },
        // Action to set the avatar
        setAvatar: (state, action) => {
            state.basicInfo.avatar = action.payload;
        },
        // Action to set the gender
        setGender: (state, action) => {
            state.basicInfo.gender = action.payload;
        },
        // Action to set the height
        setHeight: (state, action) => {
            state.basicInfo.height = action.payload;
        },
        // Action to set the blood type
        setBloodType: (state, action) => {
            state.basicInfo.bloodType = action.payload;
        },

        //***************Patient Data ****************/
        addBloodGlucose: (state, action) => {
            state.patientData.bloodGlucose.push(action.payload);
        },
        removeBloodGlucose: (state, action) => {
            state.patientData.bloodGlucose = state.patientData.bloodGlucose.filter(
                (bloodGlucose, index) => index !== action.payload
            );
        },
        addBloodPressure: (state, action) => {
            state.patientData.bloodPressure.push(action.payload);
        },
        removeBloodPressure: (state, action) => {
            state.patientData.bloodPressure = state.patientData.bloodPressure.filter(
                (bloodPressure, index) => index !== action.payload
            );
        },
        addInsulin: (state, action) => {
            state.patientData.insulin.push(action.payload);
        },
        removeInsulin: (state, action) => {
            state.patientData.insulin = state.patientData.insulin.filter(
                (insulin, index) => index !== action.payload
            );
        },
        addMedications: (state, action) => {
            state.patientData.medications.push(action.payload);
        },
        removeMedications: (state, action) => {
            state.patientData.medications = state.patientData.medications.filter(
                (medications, index) => index !== action.payload
            );
        },
        addWeight: (state, action) => {
            state.patientData.weight.push(action.payload);
        },
        removeWeight: (state, action) => {
            state.patientData.weight = state.patientData.weight.filter(
                (weight, index) => index !== action.payload
            );
        },
        addExercises: (state, action) => {
            state.patientData.exercises.push(action.payload);
        },

        addDietaryIntake : (state, action) => {
            state.patientData.dietaryIntake.push(action.payload);
        },

        //payload is id
        removeClinicalVisits : (state, action) => {
            //filter out the clinical visit with the id, database { id: "CV-XXX", ...}
            state.patientData.clinicalVisits = state.patientData.clinicalVisits.filter(
                (clinicalVisit, index) => clinicalVisit.id !== action.payload
            );
        }

    },
    extraReducers: (builder) => {
        builder
            .addCase(fetchProfile.fulfilled, (state, action) => {
                return action.payload;
            })
            .addCase(fetchProfile.rejected, (state, action) => {
                console.log(action.payload);
                return state;
            })
            // .addCase(postBloodGlucose.fulfilled, (state, action) => {
            //     state.patientData.bloodGlucose.push(action.payload);

            // })
            // .addCase(postBloodGlucose.rejected, (state, action) => {
            //     console.log(action.payload);
            //     return state;
            // });
    },
});

export const {
    setProfile,
    initProfile,
    setFirstName,
    setLastName,
    setAvatar,
    setGender,
    setHeight,
    setBloodType,
    addBloodGlucose,
    removeBloodGlucose,
    addBloodPressure,
    removeBloodPressure,
    addInsulin,
    removeInsulin,
    addMedications,
    removeMedications,
    addWeight,
    removeWeight,
    addExercises,
    addDietaryIntake,

    removeClinicalVisits,
} = profileSlice.actions;

export default profileSlice.reducer;
