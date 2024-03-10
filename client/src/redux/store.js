import { configureStore } from '@reduxjs/toolkit';
import chatReducer from './slices/chatSlice';
import profileReducer from './slices/profileSlice';
import authReducer from './slices/authSlice';

export const store = configureStore({
    reducer: {
        //chat: chatReducer,
        profile: profileReducer,
        auth: authReducer
    }
});
