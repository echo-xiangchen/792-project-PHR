// Import createSlice from Redux Toolkit
import { createSlice } from '@reduxjs/toolkit';

const profileSlice = createSlice({
    name: "profile",
    initialState: {
        userid: null,
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
            console.log("setProfile", action.payload);
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

    }
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
