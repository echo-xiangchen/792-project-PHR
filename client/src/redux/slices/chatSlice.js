import { createSlice, configureStore } from '@reduxjs/toolkit';
// import avatarExample from '../assets/example.jpg'
// import echoAvatar from '../assets/echo.jpg'
import {
    echoAvatar,
    avatarExample
} from '../../assets'

const chatSlice = createSlice({
    name: 'chat',
    initialState: {
        messages: [
            {
                type: 'message', // 'message' or 'Diabetes report'
                avatar: 'https://i.pravatar.cc/150?u=1',
                text: 'Hello, I am Dr. Cooper. How can I help you today?',
                time: '2024-01-20T10:00:00.000Z'
            },
            {
                type: 'message', // 'message' or 'Diabetes report'
                avatar: echoAvatar,
                text: 'Hello, Here is my diet today',
                time: '2024-01-20T10:00:00.000Z'
            }
        ]
    },
    reducers: {
        addMessage: (state, action) => {
        // 在这里添加消息到状态
        state.messages.push(action.payload);
        },
        deleteMessage: (state, action) => {
        // 根据id或index删除消息
        state.messages = state.messages.filter(
            (message, index) => index !== action.payload
        );
        }
    }
});

export const { addMessage, deleteMessage } = chatSlice.actions;

export default chatSlice.reducer;
