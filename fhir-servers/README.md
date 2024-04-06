# Instructions to create and run the FHIR servers
- Clone this repo: git clone https://github.com/belenbonilla/fhir-servers.git
- After cloning the repo, open it locally and run the command: docker-compose up

This will create and run:
1. A HAPI FHIR server for DiabeNet (local port:8080)
2. A Postgre Database for the DiabeNet FHIR server (local port:5432) 
3. A HAPI FHIR server for OLIS (local port:8081)
4. A Postgre Database for the OLIS FHIR server (local port:5433)

Everything is already set (volumes, ports, etc.), and once created, the FHIR servers will have the mimic data for all the FHIR resources we need to make our demo. 

