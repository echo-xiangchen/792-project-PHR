import { pageSetting } from '../../styles'

import { motion } from 'framer-motion'
import { NavLink } from 'react-router-dom'
import { AiFillFacebook, AiFillInstagram, AiFillTwitterCircle, AiFillYoutube } from 'react-icons/ai'
import { Divider } from 'antd'

// Footer component definition
const Footer = () => {

  return (
    <footer className={`${pageSetting.padding} absolute bottom-0 w-full flex items-center justify-center`}>
      
      {/* Copyright information */}
      <p className='text-primary font-extralight pb-8'>©copyright 2024 PHR company in Evangelion of university</p>
    </footer>
  )
}

export default Footer
