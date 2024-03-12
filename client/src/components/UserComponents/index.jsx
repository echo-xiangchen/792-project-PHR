import React from 'react'

// Importing router components from React Router DOM
import { 
  BrowserRouter, // Router component for managing browser navigation
  Routes, // Routes component for defining routes within the application
  Route, // Route component for defining individual routes
  useLocation // Hook for accessing the current location in the navigation
} from "react-router-dom";

// Importing components for different user functionalities
import BloodGlucose from './BloodGlucose';
import BloodPressure from './BloodPressure';
import ClinicalVisits from './ClinicalVisits';
import DietaryIntake from './DietaryIntake';
import Exercise from './Exercise';
import Home from './Home';
import Insulin from './Insulin';
import LabResult from './LabResult';
import Medications from './Medications';
import WeightControl from './WeightControl';

// Component for rendering user-specific components based on routes
const UserComponents = () => {
  return (
    <div className='p-10 h-full'>
      {/* Using BrowserRouter to manage browser navigation */}
      <Routes>
        {/* Defining routes for different user functionalities */}
        <Route path="/" element={(<Home />)} /> {/* Home route */}
        <Route path="/lab-result" element={(<LabResult />)} /> {/* Lab Result route */}
        <Route path="/medications" element={(<Medications />)} /> {/* Medications route */}
        <Route path="/clinical-visits" element={(<ClinicalVisits />)} /> {/* Clinical Visits route */}
        <Route path="/blood-glucose" element={(<BloodGlucose />)} /> {/* Blood Glucose route */}
        <Route path="/blood-pressure" element={(<BloodPressure />)} /> {/* Blood Pressure route */}
        <Route path="/insulin" element={(<Insulin />)} /> {/* Insulin route */}
        <Route path="/dietary-intake" element={(<DietaryIntake />)} /> {/* Dietary Intake route */}
        <Route path="/exercise" element={(<Exercise />)} /> {/* Exercise route */}
        <Route path="/weight-control" element={(<WeightControl />)} /> {/* Weight Control route */}
      </Routes>
    </div>
  )
}

export default UserComponents
