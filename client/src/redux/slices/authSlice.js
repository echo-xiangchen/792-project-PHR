// Import createSlice from Redux Toolkit
import { createSlice } from '@reduxjs/toolkit';

// Initial state for the auth slice
const initialState = {
  user: null, // For storing user information
  isAuthenticated: false, // To track if the user is logged in
};

// Creating the slice
const authSlice = createSlice({
    name: 'auth', // Name of the slice
    initialState, // Initial state
    reducers: { // Reducer functions
        // Action to simulate user registration
        register: (state, action) => {
            // For simplicity, directly setting user and isAuthenticated
            // In a real app, you would make an API call here
            state.user = action.payload; // Assuming payload contains user info
            state.isAuthenticated = true;
        },
        // Action to simulate user login
        login: (state, action) => {
            // Similar to register, directly setting user info and isAuthenticated
            // Replace with actual login logic in a real app
            state.user = action.payload;
            state.isAuthenticated = true;
        },
        // Action to handle user logout
        logout: (state) => {
            // Resetting user info and isAuthenticated
            state.user = null;
            state.isAuthenticated = false;
        },
    },
});

// Exporting the action creators
export const { 
    register, 
    login, 
    logout 
} = authSlice.actions;

// Exporting the reducer
export default authSlice.reducer;
