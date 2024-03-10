import { useState } from 'react'
//import Chat from './Chat';

import {
  Header
} from './components';

import { 
  MainPage 
} from './pages';

//Router
import { 
  BrowserRouter, 
  Routes, 
  Route,
  useLocation
} from "react-router-dom";

import { useLayoutEffect } from 'react';

// Scroll to the top of the page when the location changes
function ScrollToTop() {
  const location = useLocation();

  useLayoutEffect(() => {
    // Scroll to the top of the page when the location changes
    window.scrollTo(0, 0);
  }, [location]);

  // Return null as this component doesn't render anything
  return null;
}

function App() {

  return (
    <BrowserRouter>
      <ScrollToTop />
      <div className="relative w-full min-h-screen flex flex-col bg-background">
        {/* Header */}
        <Header />

        {/* Main Component */}
        <main className={`flex-1 relative w-full`}>
            <Routes>
              <Route path="/" element={(<MainPage />)} />
              {/* <Route path="/chat" element={(<Chat />)} /> */}
              <Route path="*" element={(<MainPage />)} />
            </Routes>
        </main>
      </div>
    </BrowserRouter>
  )
}

export default App
