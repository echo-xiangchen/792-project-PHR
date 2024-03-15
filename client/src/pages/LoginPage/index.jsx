import React from 'react';
import { motion } from 'framer-motion';

import { Login, Register } from '../../components';

// LoginPage component for displaying the login page
const LoginPage = () => {

  // State to track whether to display login or register form
  const [isLogin, setIsLogin] = React.useState(true);

  return (
    <div className='h-screen flex justify-center items-center '>
      <div className='relative h-full md:h-auto w-full lg:w-[640px] xl:w-[800px] 2xl:w-[1000px] backdrop-blur-xl bg-white/50 rounded-lg overflow-hidden '>
        {/* Display login form if isLogin is true */}
        {isLogin && 
          <motion.div
            initial={{ x: 1000, opacity: 0 }}
            animate={{ x: 0, opacity: 1 }}
            exit={{ x: -1000, opacity: 0 }}
            className='w-full h-full'
          >
            <Login setIsLogin={setIsLogin}/>
          </motion.div>
        }
        {/* Display register form if isLogin is false */}
        {!isLogin &&
          <motion.div
            initial={{ x: -1000, opacity: 0 }}
            animate={{ x: 0, opacity: 1 }}
            exit={{ x: 1000, opacity: 0 }}
            className='w-full h-full'
          >
            <Register setIsLogin={setIsLogin} />
          </motion.div>
        }
      </div>
    </div>
  );
}

export default LoginPage; // Export the LoginPage component
