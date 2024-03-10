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

//icon


const userNav = [
    {
        name: 'Home',
        icon: '',
        to : '/'
    },
    {
        name: 'Lab Result',
        icon: '',
        to : '/lab-result'
    },
    {
        name: 'Medications',
        icon: '',
        to : '/medications'
    },
    {
        name: 'Clinical Visits',
        icon: '',
        to : '/clinical-visits'
    },
]

//Showing LOGO
const LOGO = ({color = "text-primary"}) => (
    <NavLink to={'/'} className='text-2xl font-bold'>
        <motion.div 
        whileHover={{scale:1.1}}
        className={color}
        >Echo</motion.div>
    </NavLink>
)

const UserNav = ({currentUser}) =>{
    const [ isOpen, setIsOpen] = useState(false);
    const dispatch = useDispatch();
    const navigate = useNavigate();

    const handleSignOut = () => {
        const data = dispatch(signOut());
        //debugger
        if (data) {
        navigate('/')
        }
    }
    const liStyle = "rounded-lg hover:bg-slate-100 h-10 p-2 flex items-center cursor-pointer";
    return(
        <motion.nav 
            initial={false} 
            animate={isOpen ? "open" : "closed"} 
            className="flex flex-col items-start justify-start gap-1 ">
            
            <div className='w-36 xl:w-48 flex justify-end'>
                <motion.button 
                    whileTap={{ scale: 0.97 }}
                    onClick={() => setIsOpen(!isOpen)}
                    className= "w-auto flex justify-center items-center h-full rounded-md text-1xl border  px-4 py-2 cursor-pointer">
                        <span>Hi, {currentUser.username}</span>
                        {/* <img src={user.avatar} alt="profile" className="rounded-full w-5 h-5"/> */}
                </motion.button>
                </div>
                <motion.ul
                variants={dropdown.ulVariant}
                style={{ pointerEvents: isOpen ? "auto" : "none" }}
                className="bg-white w-auto flex flex-col gap-1 px-5 py-2 mt-5 border ">
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

//Showing Navigation Bar
const NavigationBar = ({color}) => {
    const isAuthenticated = false; //TODO: change to true when auth is implemented
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
                <motion.div
                    whileHover={{ scale: 1.05}}
                    whileTap={{ scale: 0.97 }}
                    onClick={navSignIn}
                    className="w-auto flex justify-center items-center h-full rounded-md text-1xl px-4 py-3 border cursor-pointer">
                    <span >Log in / Sign up</span>
                </motion.div> 
            }
        </nav>
    )
}

const HeaderDesktop = () => {

    const location = useLocation(); //get the current path
    const path = location.pathname;
    const [ currentPath, setCurrentPath ] = useState(path); //set the active path
    const [ headerStyle, setHeaderStyle ] = useState({background:"bg-none",color:"text-white"}); //set the active path
    
    const handleScroll = () => {
        if (window.scrollY > 0) {
            setHeaderStyle({background:"bg-white",color:"text-black"}); 
        } else {
            setHeaderStyle({background:"bg-none",color:"text-white"});
        }
    }
    
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
        <header className={`${pageSetting.padding} hidden md:flex z-10 h-12 w-full ${headerStyle.background} ${headerStyle.color} justify-between items-center`}>
            <LOGO color={headerStyle.color} />
            <div className='flex space-x-5 h-10 items-center'>
                <NavigationBar color={headerStyle.color} />
            </div>
        </header>
    )
}


export default HeaderDesktop