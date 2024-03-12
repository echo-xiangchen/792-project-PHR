import { configureStore } from '@reduxjs/toolkit';

// Importing reducers from slices
import chatReducer from './slices/chatSlice'; // Importing chatReducer from chatSlice.js
import profileReducer from './slices/profileSlice'; // Importing profileReducer from profileSlice.js
import authReducer from './slices/authSlice'; // Importing authReducer from authSlice.js

// Creating the Redux store
export const store = configureStore({
    reducer: {
        // Uncomment below to include chatReducer
        // chat: chatReducer,

        // Including profileReducer and authReducer in the store
        profile: profileReducer,
        auth: authReducer
    }
});
