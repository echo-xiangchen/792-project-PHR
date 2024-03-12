import { useState } from 'react'

// Components
import {
  Header, // Header component for displaying the website header
  Footer, // Footer component for displaying the website footer
} from './components';

// Pages
import { 
  MainPage, // Main page component for displaying the main content of the website
  LoginPage, // Login page component for displaying the login form
  UserProfilePage, // User profile page component for displaying the user profile
} from './pages';

// Router
import { 
  BrowserRouter, // Router component for managing browser navigation
  Routes, // Routes component for defining routes within the application
  Route, // Route component for defining individual routes
  useLocation // Hook for accessing the current location in the navigation
} from "react-router-dom";

//image
import { background } from './assets';


import { useLayoutEffect } from 'react';

// Scroll to the top of the page when the location changes
function ScrollToTop() {
  const location = useLocation();

  // Scroll to the top of the page when the location changes
  useLayoutEffect(() => {
    window.scrollTo(0, 0);
  }, [location]);

  // Return null as this component doesn't render anything
  return null;
}

function App() {

  return (
    <BrowserRouter>
      {/* Scroll to top component */}
      <ScrollToTop />

      {/* Main container */}
      <div className="relative w-full min-h-screen flex flex-col bg-background">
        {/* Header */}
        <Header />

        {/* Main Component */}
        <main className={`flex-1 relative w-full`}>
        <div className='z-10'>
                <img src={background} alt="" className='absolute z-0 top-0 right-0 w-full h-screen object-cover'/>
            </div>
          {/* Routing */}
          <Routes>
            {/* Main page route */}
            <Route path="/" element={(<MainPage />)} />

            {/* Login page route */}
            <Route path="/login" element={(<LoginPage />)} />

            {/* User profile page route */}
            <Route path="/my-profile/*" element={(<UserProfilePage />)} />
            
            {/* Default route */}
            <Route path="*" element={(<MainPage />)} />


          </Routes>
        </main>

        {/* Footer */}
        <Footer />
      </div>
    </BrowserRouter>
  )
}

export default App
