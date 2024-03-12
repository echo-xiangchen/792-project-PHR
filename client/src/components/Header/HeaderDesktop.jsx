//react
import { useState, useEffect } from 'react'

//router
import { NavLink, useNavigate, useLocation } from 'react-router-dom'

//redux
import { useSelector, useDispatch } from 'react-redux';
import { logout } from '../../redux/slices/authSlice';

//motion
import { motion } from 'framer-motion'
import { dropdown } from '../../motions';

//style
import { pageSetting } from '../../styles'

//component

//antd
import { message } from 'antd';

//icon
import { FaHospitalAlt } from "react-icons/fa";
import {  FiLogOut  } from 'react-icons/fi'
import { ImLab } from "react-icons/im";
import { HomeFilled,PictureFilled } from '@ant-design/icons';

// Array containing navigation items for authenticated users
const userNav = [
    {
        name: 'Home',
        icon: <HomeFilled />,
        url : '/my-profile'
    },
    {
        name: 'Lab Result',
        icon: <ImLab />,
        url : '/my-profile/lab-result'
    },
    {
        name: 'Medications',
        icon: <PictureFilled />,
        url : '/my-profile/medications'
    },
    {
        name: 'Clinical Visits',
        icon: <FaHospitalAlt />,
        url : '/my-profile/clinical-visits'
    },
]

// Component to display company logo
const LOGO = ({color}) => (
    <NavLink to={'/'} className={`${color} flex flex-col gap-0 items-center`}>
        <span className='text-3xl font-bold border-b border-b-primary'>P H R</span>
        <span className='text-[0.6rem] font-bold'>our project in 792</span>
    </NavLink>
)

// Component for user navigation
const UserNav = ({currentUser}) =>{
    //control the dropdown
    const [ isOpen, setIsOpen] = useState(false);

    const dispatch = useDispatch();
    const navigate = useNavigate();

    //handle sign out
    const handleSignOut = () => {
        message.success("Logout success");
        //sleep for 1 second
        const signOut = async () => {
            await new Promise(resolve => setTimeout(resolve, 1000));
        }
        const data = dispatch(signOut());
        //debugger
        if (data) {
            navigate('/')
        }
    }
    //li style
    const liStyle = "rounded-lg hover:bg-tertiary h-10 p-2 flex items-center cursor-pointer";
    return(
        <motion.nav 
            initial={false} 
            animate={isOpen ? "open" : "closed"} 
            className="flex flex-col items-start justify-start gap-1 ">
            
            <div className='w-36 xl:w-48 flex justify-end'>
                <motion.button 
                    whileHover={{ scale: 1.05}}
                    whileTap={{ scale: 0.97 }}
                    onClick={() => setIsOpen(!isOpen)}
                    className= "w-auto flex justify-center items-center h-full rounded-md text-1xl border  px-4 py-2 cursor-pointer">
                        <span>Hi, {currentUser.basicInfo.firstName}</span>
                        {/* <img src={user.avatar} alt="profile" className="rounded-full w-5 h-5"/> */}
                </motion.button>
                </div>
                <motion.ul
                    variants={dropdown.ulVariant}
                    style={{ pointerEvents: isOpen ? "auto" : "none" }}
                    className={`${isOpen ? "block" : "hidden" } bg-white w-auto flex flex-col gap-1 px-5 py-2 mt-5 shadow-product`}>
                    {userNav.map((nav,index) => (
                        <motion.li key={index} className={liStyle} variants={dropdown.itemVariant}>
                            <NavLink to={nav.url} className=" w-full flex gap-5 items-center"  onClick={()=>setIsOpen(false)}>
                                <p className='text-black'>{nav.icon}</p>
                                <span className="text-sm font-semibold text-black">{nav.name}</span>
                            </NavLink>
                        </motion.li>
                    ))}
                <hr />
                <motion.li className={liStyle} variants={dropdown.itemVariant}>
                    <NavLink 
                        to="/" 
                        className="flex gap-5 w-full"
                        onClick={handleSignOut}>
                        <p className='text-black'><FiLogOut /></p>
                        <span className="text-black text-sm font-semibold">Logout</span>
                    </NavLink>
                </motion.li>
            </motion.ul>
        </motion.nav>
    )
}

// Component to show navigation bar
const NavigationBar = ({color}) => {
    const isAuthenticated = useSelector(state => state.auth.isAuthenticated); //get the authentication status
    const currentUser = useSelector(state => state.profile); //get the current user information

    const navigate = useNavigate(); //navigate to other page
    const location = useLocation(); //get the path

    const navSignIn = () => {
        navigate('/login', { state: { from: location } });
    }

    return(
        <nav className="flex gap-10 items-center text-lg tracking-wide font-sans z-10">
            {isAuthenticated ?
                <div className='flex items-center'>
                    <div className="h-12 relative justify-self-start self-start">
                        <UserNav currentUser={currentUser}/> 
                    </div>
                </div>
                : 
                <div className='flex items-center'>
                    <div className="h-12 relative justify-self-start self-start flex gap-5">
                        <motion.div
                            whileHover= {{ scale: 1.05}}
                            whileTap={{ scale: 0.97 }}
                        >
                            <NavLink to="/contact" className="w-auto flex justify-center items-center h-full cursor-pointer">
                                <span>Contact Us</span>
                            </NavLink>
                        </motion.div>
                        <motion.div
                            whileHover={{ scale: 1.05}}
                            whileTap={{ scale: 0.97 }}
                            onClick={navSignIn}
                            className="w-auto flex justify-center items-center h-full rounded-md text-1xl px-4 py-3 border cursor-pointer">
                            <span >Log in / Sign up</span>
                        </motion.div>
                    </div>
                </div>
            }
        </nav>
    )
}

// Component for the desktop header
const HeaderDesktop = () => {

    const location = useLocation(); //get the current path
    const path = location.pathname;
    const [ currentPath, setCurrentPath ] = useState(path); //set the active path
    const [ headerStyle, setHeaderStyle ] = useState({background:"bg-none",color:"text-primary"}); //set the active path
    
    const isAuthenticated = useSelector(state => state.auth.isAuthenticated); //get the authentication status

    //handle the scroll event, change the header style
    const handleScroll = () => {
        if (window.scrollY > 0) {
            setHeaderStyle({background:"bg-white",color:"text-primary"}); 
        } else {
            setHeaderStyle({background:"bg-none",color:"text-primary"});
        }
    }
    
    //when the path changes, update the current path
    useEffect(() => {
        setCurrentPath(path);
    }, [path]);

    /**
     * Add event listener when component mounts
     */
    useEffect(() => {
        window.addEventListener('scroll', handleScroll);
        return () => {
            window.removeEventListener('scroll', handleScroll);
        }
    }, []);

    return (
        <header className={`${pageSetting.padding} hidden md:flex z-10 py-12 h-12 w-full ${headerStyle.background} ${headerStyle.color} justify-between items-center`}>
            <LOGO color={headerStyle.color} />
            <div className='flex space-x-5 h-10 items-center'>
                {isAuthenticated && <NavigationBar color={headerStyle.color} />}
            </div>
        </header>
    )
}

export default HeaderDesktop
