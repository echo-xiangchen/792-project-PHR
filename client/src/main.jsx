//react
import React from 'react'

//react-dom
import ReactDOM from 'react-dom/client'

//component
import App from './App.jsx'

//import Tailwindcss
import './index.css'

//redux
import { Provider } from 'react-redux';
import { store } from './redux/store';

//framer-motion
import { AnimatePresence } from 'framer-motion'

// Creating a root element where the React app will be attached
ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <Provider store={store}>
      <AnimatePresence>
        <App />
      </AnimatePresence>
    </Provider>
  </React.StrictMode>,
)
