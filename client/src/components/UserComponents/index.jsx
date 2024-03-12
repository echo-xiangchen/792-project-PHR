import React from 'react'

//router
import { 
  BrowserRouter, // Router component for managing browser navigation
  Routes, // Routes component for defining routes within the application
  Route, // Route component for defining individual routes
  useLocation // Hook for accessing the current location in the navigation
} from "react-router-dom";

//component
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



const UserComponents = () => {
  return (
    <div className='p-5 h-full'>
      <Routes>
        <Route path="/" element={(<Home />)} />
        <Route path="/lab-result" element={(<LabResult />)} />
        <Route path="/medications" element={(<Medications />)} />
        <Route path="/clinical-visits" element={(<ClinicalVisits />)} />
        <Route path="/blood-glucose" element={(<BloodGlucose />)} />
        <Route path="/blood-pressure" element={(<BloodPressure />)} />
        <Route path="/insulin" element={(<Insulin />)} />
        <Route path="/dietary-intake" element={(<DietaryIntake />)} />
        <Route path="/exercise" element={(<Exercise />)} />
        <Route path="/weight-control" element={(<WeightControl />)} />
      </Routes>
    </div>
  )
}

export default UserComponents