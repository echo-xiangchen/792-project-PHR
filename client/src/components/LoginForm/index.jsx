import React, { useState } from 'react';
import { motion } from 'framer-motion';

// Import styles
import style from "../../style.module.scss";

// Import React Router hooks
import { useNavigate, useLocation } from 'react-router-dom';

// Import Redux hooks and actions
import { useDispatch } from 'react-redux';
import { login } from "../../redux/slices/authSlice";
import { setProfile } from "../../redux/slices/profileSlice";

// Import fake user data
import { loginUser } from "../../testData/UserDB";

// Import Ant Design components
import { Space, Divider, message } from 'antd';

// Import icon
import { ImGoogle } from "react-icons/im";

//import { getProfile } from '../../api';
import { fetchProfile } from '../../redux/slices/profileSlice';

// Login component for user authentication
const Login = ({ setIsLogin }) => {
  const dispatch = useDispatch();
  const navigate = useNavigate();
  const location = useLocation();
  
  // Get the redirect path from the previous location or default to '/my-profile'
  const from = location.state?.from?.pathname || "/my-profile";

  // State to manage user input data and error message
  const [userInfo, setUserInfo] = useState({
    email: '',
    birth: '',
    password: ''
  });
  const [errorMessage, setErrorMessage] = useState("");

  // Handle user input changes
  const onChange = (e) => {
    setUserInfo({
      ...userInfo,
      [e.target.name]: e.target.value
    });
  };

  // Handle user login
  const handleSignIn = async (e) => {
    // let page stay on the same page
    e.preventDefault();

    try{
      const data = await dispatch(fetchProfile("1"));
      //Login notification
      if (data) {
        message.success("Login success");
        dispatch(login(userInfo)); // Make sure userInfo is defined
        
        // Navigate to a new route, replace the current entry in the history stack
        navigate(from, { replace: true });
      } else {
        message.error("Incorrect login");
      }
    } catch (error) {
      // Handle any errors that occur during the fetchProfile call
      console.error("Login failed:", error);
      message.error("Login failed");
    }
  };
  
  return (
    <div className='w-full h-full flex items-center'>
      {/* Left section for welcome message and join option */}
      <div className='sm:flex hidden py-32 flex-1 min-h-[700px] h-full flex-col justify-between border-r border-1'>
        <div className='w-full px-12 flex flex-col gap-5'>
          <h1 className='text-center text-2xl font-bold tracking-widest'>Diabetes tip</h1>
          <div className='text-center text-md'>
            <p>Monitor your blood glucose regularly</p>
            <p>and stay consistent with your meal timings to better manage diabetes.</p>
          </div>
        </div>
        <div className='w-full px-12 flex flex-col'>
          <motion.div 
            className='h-auto rounded-md text-center'
            whileTap={{ scale: 0.9 }}
            whileHover={{ scale: 1.05 }}
          >
            <button 
              className="w-full h-auto border border-1 rounded-md p-2 text-center" 
              onClick={() => {setIsLogin(false)}}
            >Sign Up</button>
          </motion.div>
        </div>
      </div>
      
      {/* Right section for login form */}
      <form className='h-full flex-1 py-32 min-h-[700px] sm:w-1/2 flex flex-col justify-start md:justify-center gap-12 items-center'>
        <div>
          <h1 className='text-center text-2xl font-bold tracking-widest'>Welcome Back !</h1>
        </div>
        <Space direction="vertical" size="large">
          <div>
            <label className='font-mainPageFont tracking-wider'>Email</label>
            <input 
              name='email' 
              className={`${style.input} px-5 h-12 text-sm`} 
              type="text" 
              onChange={onChange} 
              placeholder='example@gmail.com'
              required
            />
          </div>

          <div>
            <label className='font-mainPageFont tracking-wider'>Date of birth</label>
            <input 
              name='birth' 
              className={`${style.input} px-5 h-12 text-sm`} 
              type="date" 
              onChange={onChange} 
              placeholder='example@gmail.com'
              required
            />
          </div>

          <div>
            <label className='tracking-wider'>Password</label>
            <input 
              name='password' 
              className={`${style.input} px-5 h-12 text-sm`} 
              type="password" 
              onChange={onChange}
              required
            />
            <div>
              {errorMessage && <p className='text-red-500'>{errorMessage}</p>}
            </div>
            <div className='w-full flex justify-end'>
              <span className='text-sm underline mt-2 cursor-pointer'>Forgot password?</span>
            </div>
          </div>
          <div className='flex sm:hidden'>
            <p className='text-sm'>
              Dont have account? <span className='text-[#E4405F] cursor-pointer underline' onClick={() => {setIsLogin(false)}}>Join us</span>
            </p>
          </div>
          {/* Login button */}
          <motion.div 
            whileTap={{ scale: 0.9 }}
            whileHover={{ scale: 1.05 }}
          >
            <button  
              className='w-full h-auto border border-1 rounded-md p-2 text-center'
              onClick={handleSignIn}>Log In</button>
          </motion.div>
        
        </Space>
      </form>
    </div>
  );
}

export default Login; // Export the Login component
