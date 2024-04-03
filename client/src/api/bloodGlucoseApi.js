//axios
import axios from 'axios';

//constants
import { BASE_URL } from '../constants';
import { BGLOWERLIMITE,BGUPPERLIMIT } from "../constants";
const resourceType = "Observation";
const identifier = [{
    "use": "official",
    "system": "http://www.bmc.nl/zorgportal/identifiers/observations",
    "value": "6323"
}]
const status = "final";



export const postBloodGlucose = async (patientId,data) => {

    console.log('Posting blood glucose data...');
    console.log(data)
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
        const response = await axios.post(BASE_URL, sendData);
        console.log('Success:', response);
        return response;
    } catch (error) {
        // error catch
        console.error('Error:', error);
        
    }
}