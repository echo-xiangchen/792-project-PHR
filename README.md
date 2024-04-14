## Link to our web portal
Link to our website is here: [DiabeNet](https://echo-xiangchen.github.io/792-PHR-web/)

## Instructions to create and run the FHIR servers using Docker
After cloning the repo, navigate to the fhir-servers folder and run the following command to start the FHIR servers using Docker Compose: `docker-compose up`       
This will create and run:          
1. A HAPI FHIR server for DiabeNet (local port:8080)          
2. A Postgre Database for the DiabeNet FHIR server (local port:5432)          
3. A HAPI FHIR server for OLIS (local port:8081)          
4. A Postgre Database for the OLIS FHIR server (local port:5433)

Everything is already set (volumes, ports, etc.), and once created, the databases will have the mimic data for all the FHIR resources we need to make our demo.

**After running the FHIR servers locally, go to our [web portal](https://echo-xiangchen.github.io/792-PHR-web/) and everything should work.**
