//Axios
import axios from "axios"

//Simulate user profile
import { loginUser } from "../testData/UserDB"

//avatar
import {
    loginAvatar,
} from '../assets';

import { BGLOWERLIMITE,BGUPPERLIMIT } from "../constants";


//Observation constants
const resourceType = "Observation";
const identifier = [{
    "use": "official",
    "system": "http://www.bmc.nl/zorgportal/identifiers/observations",
    "value": "6323"
}]
const status = "final";
const patientId = "1";

export const bloodGluscosePost = async (data) => {
    const id = patientId; //patient id
    const display = "Glucose [Moles/volume] in Capillary blood by Glucometer"; //display
    const text = data.mealTime; //meal time
    const effectiveDateTime = data.time + "+00:00"; //time
    const issued = data.time + "+00:00"; //time
    //blood glucose code
    const code = "14743-9";
    //patient
    const patientReference = `Patient/${id}`;

    //CHECK LEVEL
    let interpretationCode, interpretationDisplay; //interpretation
    if(data.value < BGLOWERLIMITE ){
        interpretationCode = "L";
        interpretationDisplay = "Low";
    }else if(data.value > BGUPPERLIMIT){
        interpretationCode = "H";
        interpretationDisplay = "High";
    }else{
        interpretationCode = "N";
        interpretationDisplay = "Normal";
    }

    

    const sendData = {
        "resourceType": resourceType,
        "identifier" : identifier,
        "status": status,
        "code": {
            "coding": [
                {
                    "system": "http://loinc.org",
                    "code": code,
                    "display": display
                }
            ],
            "text": text
        },
        "subject": {
            "reference": patientReference
        },
        "effectiveDateTime": effectiveDateTime,
        "issued": issued,
        "performer": [
            {
                "reference": `Patient/${id}`
            }
        ],
        "valueQuantity": {
            "value": data.value,
            "unit": "mmol/l",
            "system": "http://unitsofmeasure.org",
            "code": "mmol/L"
        },
        "interpretation": [
            {
                "coding": [
                    {
                        "system": "http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation",
                        "code": interpretationCode,
                        "display": interpretationDisplay
                    }
                ]
            }
        ],
        "referenceRange": [
            {
                "low": {
                    "value": 3.9,
                    "unit": "mmol/l",
                    "system": "http://unitsofmeasure.org",
                    "code": "mmol/L"
                },
                "high": {
                    "value": 7.2,
                    "unit": "mmol/l",
                    "system": "http://unitsofmeasure.org",
                    "code": "mmol/L"
                },
                "type":{
                    "text": "Normal preprandial glucose range"
                }
            }
        ]
    }

    try {
        const response = await axios.post('http://localhost:8080/fhir/Observation', sendData);
        console.log('Success:', response);
        return response;
    } catch (error) {
        // error catch
        console.error('Error:', error);
        
    }
}

export const bloodGluscoseGet = async (id) => {

    //blood glucose code
    const code = "14743-9";
    const patientID = id;
    const start_date = "2024-02-29";
    const end_date = "2024-06-29";
    
    try {

        
        const response = await axios.get('http://localhost:8080/fhir/Observation', {
            params: {
                code: `http://loinc.org|${code}`,
                subject: `Patient/${patientID}`,
                // date: `ge${start_date}`,
                date: `le${end_date}`,
                _sort: '-date'
            }
        });
        console.log('Success:', response);

        const res = response.data;
        const entries  = res.entry;
        
        const array = entries.map((item) => {
            
            const resource = item.resource;
            const text = resource.code.text;

            const effectiveDateTime = resource.effectiveDateTime;

            const value = resource.valueQuantity.value;

            const unit = resource.valueQuantity.unit;

            const interpretation = resource.interpretation;

            return {
                mealTime: text,
                time: effectiveDateTime,
                value: value,
                unit: unit,
                interpretation: interpretation
            };
        });

        return array;
    } catch (error) {
        console.error('Error:', error);
        
    }
}

const GetallPatientData = async () => {
    const url = 'http://localhost:8081/fhir/DiagnosticReport';
    const params = {
        'patient.identifier': 'http://ehealthontario.ca/fhir/NamingSystem/id-pcr-eid|2923',
        'patient.birthdate': '1951-01-02',
        'issued': 'ge2022-01-01'
    };

    return axios.get(url, { params })
    .then(response => {
        if (response.status === 200) {
            return response.data;
    }
        throw new Error('Request failed with status ' + response.status);
    })
    .catch(error => {
        console.error('Error fetching data:', error);
        throw error; 
    });
}

const GetDiagnosticReport = async () => {
    //test data
    const data = "http://localhost:8081/fhir/DiagnosticReport?patient.identifier=http://ehealthontario.ca/fhir/NamingSystem/id-pcr-eid|2923&patient.birthdate=1951-01-02&issued=ge2022-01-01"
    
    const date = "2024-03-29";
    const issue_date = "2024-03-29";
    const system = "http://ehealthontario.ca/fhir/NamingSystem/id-pcr-eid"
    const value = "2923";
}