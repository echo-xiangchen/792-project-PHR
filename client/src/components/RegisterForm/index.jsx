//style
import style from "../../style.module.scss"

//redux
import { useSelector, useDispatch } from 'react-redux';
import { login, register } from '../../redux/slices/authSlice';

//react
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';

//framer-motion
import { motion } from 'framer-motion';

//antd
import { Space,Divider } from 'antd';

//icons
import { ImGoogle } from "react-icons/im";



const Register = ({setIsLogin}) => {

  const [userInfo, setUserInfo] = useState({
    username: '',
    firstname: '',
    lastname: '',
    birth : null,
    ohip: "",
    password: '',
    email: '',
  });

  const [errorMessage, setErrorMessage] = useState({
    username: '',
    password: '',
    email: '',
  })
  
  const dispatch = useDispatch();
  const navigate = useNavigate(); 

  
  const { isLoggedIn, message, currentUser } = useSelector(state => state.auth);

  const onChange = (e) => {
    setUserInfo({
      ...userInfo,
      [e.target.name]: e.target.value
    });
  };

  const handleCreateAccount = (e) => {
    e.preventDefault()
    dispatch(register(userInfo));
  };

  return (
    <div className='w-full h-full flex items-center'>
      <form className='h-full flex-1 py-10 min-h-[700px] sm:w-1/2 flex flex-col justify-start md:justify-center gap-12 items-center px-6'>
        <div className=''>
          <h1 className='text-center text-2xl font-bold tracking-widest'>Join us!</h1>
        </div>
        <Space direction="vertical" size="large">

        <div>
            <label className='tracking-wider'>Login Email<span className="text-error">*</span></label>
            <input className={`${style.input} px-5 h-12`} name='email' type="email" onChange={onChange} />
            {errorMessage.email && <p className='text-red-500'>{errorMessage.email}</p>}
          </div>

          <div>
            <label className='tracking-wider'>Password<span className="text-error">*</span></label>
            <input className={`${style.input} px-5 h-12`} name='password' type="password" onChange={onChange} required/>
            {errorMessage.password && <p className='text-red-500'>{errorMessage.password}</p>}
          </div>

          <div className="flex gap-2">
            <div className="flex-1">
              <label className='tracking-wider'>First Name<span className="text-error">*</span></label>
              <input className={`${style.input} px-5 h-12`} name='firstname' type="text" onChange={onChange} required/>
            </div>
            <div className="flex-1">
              <label className='tracking-wider'>Last Name<span className="text-error">*</span></label>
              <input className={`${style.input} px-5 h-12`} name='lastname' type="text" onChange={onChange} required/>
            </div>
          </div>

          <div>
            <label className='tracking-wider'>OHIP or Medical Record Numebr<span className="text-error">*</span></label>
            <input className={`${style.input} px-5 h-12`} name='ohip' type="text" onChange={onChange} required/>
          </div>

          <div>
            <label className='tracking-wider'>Date of birth<span className="text-error">*</span></label>
            <input className={`${style.input} px-5 h-12`} name='birth' type="date" onChange={onChange} required/>
          </div>
          {/** check box */}
          <div className='flex items-center gap-5'>
            <input type="checkbox" className='h-5 w-5' />
            <label className='text-sm'>By clicking on sign-up, you agree to DiabeNet's <span className='text-[#E4405F] cursor-pointer underline'>Terms and Conditions of Use</span></label>
          </div>
          <div className='flex items-center gap-5'>
            <label className='text-sm'>To learn more about how DiabeNet collects, uses, shares and protects yourpersonal data, please see <span className='text-[#E4405F] cursor-pointer underline'>DiabeNet's Privacy Policy.</span></label>
          </div>
          
          <div className='flex sm:hidden'>
            <p className='text-sm'>
              Already have account? <span className='text-[#E4405F] cursor-pointer underline' onClick={() => {setIsLogin(true)}}>Login</span>
            </p>
          </div>
          <motion.div 
            whileTap={{ scale: 0.9 }}
            whileHover={{ scale: 1.05 }}
          >
            <button  
              className='w-full h-auto border border-1 rounded-md p-2 text-center'
              onClick={handleCreateAccount}>Sign up</button>
          </motion.div>

        </Space>
      </form>

      <div className='sm:flex hidden py-32 flex-1 min-h-[700px] h-full flex-col justify-between border-l border-1'>
        <div className='w-full px-12 flex flex-col gap-5'>
            <h1 className='text-center text-2xl font-bold tracking-widest'>Wecome back!</h1>
            <div className='text-center text-md'>
              <p>Great to see you again! Let's get you signed in and on your way. hoping you've been doing well since your last visit !</p>
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
              onClick={() => {setIsLogin(true)}}
            >Sign In here</button>
          </motion.div>
        </div>

      </div>
    </div>
  )
}

export default Register