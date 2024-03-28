//icon
import { FaHospitalAlt } from "react-icons/fa";
import { ImLab } from "react-icons/im";
import { HomeFilled,PictureFilled,HeartFilled } from '@ant-design/icons';
import { MdBloodtype } from "react-icons/md";
import { GiLoveInjection } from "react-icons/gi";
import { MdFastfood } from "react-icons/md";
import { MdOutlineSportsGymnastics } from "react-icons/md";
import { FaWeightScale } from "react-icons/fa6";

// define a mapping of navigation items for authenticated users
export const iconMap = {
    'Home': <HomeFilled />,
    'Lab Result': <ImLab />,
    'Medications': <PictureFilled />,
    'Clinical Visits': <FaHospitalAlt />,
    'Blood Glucose': <MdBloodtype />,
    'Blood Pressure': <HeartFilled />,
    'Insulin': <GiLoveInjection />,
    'Dietary Intake': <MdFastfood />,
    'Exercise': <MdOutlineSportsGymnastics />,
    'Weight Control': <FaWeightScale />
}

//Constants value

// lower bond and upper bond for blood glucose
export const BGLOWERLIMITE = 3.9;
export const BGUPPERLIMIT = 7.2;
export const BGBelowColor = 'error';
export const BGInColor = 'success';
export const BGAboveColor = 'yellow';

//---lower bond and upper bond for blood pressure---
// systolic 

//normal range: X < 120
export const SYSTOLIC_NORMAL = 120;
//elevated: 120 <= X < 130
export const SYSTOLIC_UPPERLIMIT = 140;

// diastolic

//normal range: X < 80
export const DIASTOLIC_NORMAL = 80;

//elevated: 80 <= X < 90
export const DIASTOLIC_UPPERLIMIT = 90;

//pulse
export const PULSE_LOWERLIMITE = 60;
export const PULSE_UPPERLIMIT = 100;

export const BPLowerColor = 'yellow';
export const BPInColor = 'success';
export const BPAboveColor = 'error';

//data
export const boundList = {
    'Sodium' : {
        unit: 'mmol/L',
        lower: 135,
        upper: 145,
    },
    'Potassium' : {
        unit: 'mmol/L',
        lower: 3.5,
        upper: 5.1,
    },
    'Chloride' : {
        unit: 'mmol/L',
        lower: 98,
        upper: 108,
    },
    'Carbon Dioxide' : {
        unit: 'mmol/L',
        lower: 21,
        upper: 30,
    },
    'ureaNitrogen' : {
        unit: 'mg/dL',
        lower: 7,
        upper: 20,
    },
    'creatinine' : {
        unit: 'mg/dL',
        lower: 0.4,
        upper: 1.0,
    },
    'bloodglucose' : {
        unit: 'mg/dL',
        lower: 70,
        upper: 140,
    }
}


export const userNav = [
    {
        name: 'Home',
        url : '/my-profile'
    },
    {
        name: 'Lab Result',
        url : 'lab-result'
    },
    {
        name: 'Medications',
        url : 'medications'
    },
    {
        name: 'Clinical Visits',
        url : 'clinical-visits'
    },
]

export const dataNav = [
    {
        name: 'Blood Glucose',
        url : 'blood-glucose'
    },
    {
        name: 'Blood Pressure',
        url : 'blood-pressure'
    },
    {
        name: "Insulin",
        url : 'insulin'
    },
    {
        name: "Dietary Intake",
        url : 'dietary-intake'
    },
    {
        name: "Exercise",
        url : 'exercise'
    },
    {
        name: "Weight Control",
        url : 'weight-control'
    }
  ]