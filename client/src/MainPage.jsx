import React from 'react'
import { useState } from 'react'
import { motion } from 'framer-motion'
import { NavLink } from 'react-router-dom'
import { Modal, Button, Form, Input } from 'antd';
import { pageSetting } from './styles';

const Btn = ({ to,children, ...props }) => {
    return (
        <motion.button
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
        className="bg-primary text-white px-6 py-2 rounded hover:bg-secondary focus:outline-none focus:ring-2 focus:ring-secondary focus:ring-opacity-50"
        {...props}
        >
        <NavLink to={to}>{children}</NavLink>
        </motion.button>
    )
    
}

const MainPage = () => {

    const [LoginisModalVisible, LoginsetIsModalVisible] = useState(false);
    const [RegisterisModalVisible, RegistersetIsModalVisible] = useState(false);
    return (
        <div className={`${pageSetting.padding} flex flex-col items-center justify-center min-h-screen bg-gray-100 gap-16`}>
            <Login isModalVisible={LoginisModalVisible} setIsModalVisible={LoginsetIsModalVisible}/>
            <Register isModalVisible={RegisterisModalVisible} setIsModalVisible={RegistersetIsModalVisible}/>
            <div className=''>
                <h1 className="text-4xl font-bold">Daily Record of Diabetes</h1>
            </div>
            <div className="space-x-10">
            <Btn onClick={() =>LoginsetIsModalVisible(true) }>Login</Btn>
            <Btn onClick={() =>RegistersetIsModalVisible(true) }>Register</Btn>
            </div>
        </div>
    )
}

const Login = ({isModalVisible, setIsModalVisible}) => {
    
    const showModal = () => {
        setIsModalVisible(true);
    };
    const handleOk = () => {
      // Handle the submission of form data here
        setIsModalVisible(false);
    };
    const handleCancel = () => {
        setIsModalVisible(false);
    };
    return (
        <Modal 
            title="Login" 
            open={isModalVisible} 
            onOk={handleOk} 
            footer={null}
            onCancel={handleCancel}>
            <Form
                name="basic"
                initialValues={{ remember: true }}
                onFinish={handleOk}
                autoComplete="off"
            >
                <Form.Item
                label="Username"
                name="username"
                rules={[{ required: true, message: 'Please input your username!' }]}
                >
                    <Input />
                </Form.Item>
    
                <Form.Item
                label="Password"
                name="password"
                rules={[{ required: true, message: 'Please input your password!' }]}
                >
                    <Input.Password />
                </Form.Item>
    
                <div className='w-full flex justify-center mt-12'>
                    <motion.div
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                    >
                        <NavLink 
                            to="/chat"
                            type="submit" 
                            className="bg-primary text-white px-6 py-2 rounded hover:bg-secondary focus:outline-none focus:ring-2 focus:ring-secondary focus:ring-opacity-50"
                        >Login
                        </NavLink>
                    </motion.div>
                </div>
            </Form>
        </Modal>
    );
  };

  const Register = ({isModalVisible, setIsModalVisible}) => {
    
    const showModal = () => {
        setIsModalVisible(true);
    };
    const handleOk = () => {
      // Handle the submission of form data here
        setIsModalVisible(false);
    };
    const handleCancel = () => {
        setIsModalVisible(false);
    };
    return (
        <Modal 
            title="Register" 
            open={isModalVisible} 
            onOk={handleOk} 
            footer={null}
            onCancel={handleCancel}>
            <Form
                name="basic"
                initialValues={{ remember: true }}
                onFinish={handleOk}
                autoComplete="off"
            >
                <Form.Item
                label="Username"
                name="username"
                rules={[{ required: true, message: 'Please input your username!' }]}
                >
                    <Input />
                </Form.Item>
    
                <Form.Item
                label="Password"
                name="password"
                rules={[{ required: true, message: 'Please input your password!' }]}
                >
                    <Input.Password />
                </Form.Item>
    
                <div className='w-full flex justify-center mt-12'>
                    <motion.div
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                    >
                        <NavLink 
                            to="/chat"
                            type="submit" 
                            className="bg-purple-500 text-white px-6 py-2 rounded hover:bg-purple-600 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:ring-opacity-50"
                        >Login
                        </NavLink>
                    </motion.div>
                </div>
            </Form>
        </Modal>
    );
  };

export default MainPage