import React from 'react';
import { motion } from 'framer-motion';

import { Login, Register } from '../../components';

// LoginPage component for displaying the login page
const LoginPage = () => {

  // State to track whether to display login or register form
  const [isLogin, setIsLogin] = React.useState(true);

  return (
    <div className='w-full h-screen flex justify-center items-center mt-40 md:mt-0 '>
      <div className='backdrop-blur-xl bg-white/50 rounded-lg overflow-hidden relative w-full h-[800px] lg:w-[640px] xl:w-[800px] 2xl:w-[1000px] '>
        {/* Display login form if isLogin is true */}
        {isLogin && 
          <motion.div
            initial={{ x: 1000, opacity: 0 }}
            animate={{ x: 0, opacity: 1 }}
            exit={{ x: -1000, opacity: 0 }}
            className='w-full h-full shadow-signTable'
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
            className='w-full h-full shadow-signTable'
          >
            <Register setIsLogin={setIsLogin} />
          </motion.div>
        }
      </div>
    </div>
  );
}

export default LoginPage; // Export the LoginPage component
