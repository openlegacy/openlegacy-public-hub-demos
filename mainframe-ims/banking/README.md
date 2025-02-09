# How to create IMS COBOL Accounts Hub Project 

## Pre-Requirements
- OpenLegacy CLI installed on your PC. 
- Java 11. 
- OpenLegacy Hub account. 
- Legacy sources from the resources folder:  
- [GACTIM8.in.cpy](./resources/GACTIM8.in.cpy) , [GACTIM8.out.cpy](./resources/GACTIM8.out.cpy), [OACTIM8.in.cpy](./resources/OACTIM8.in.cpy), [OACTIM8.out.cpy](./resources/OACTIM8.out.cpy)

## Create a module

`ol create module --connector  mf-ims-cobol   accounts-ims`

Enter the modue folder. 

## Test Connection

`ol test connection --host mainframe.openlegacy.com --port 9999 --group-name GROUP1 --data-store-name IVP1  --transaction-properties.commit-mode COMMIT_AND_SEND --username DEMO001 --password LEGACY --ssl-properties.is-ssl-enabled false`

## Create the Assets

- **Open Account**  
      `ol add --program-path OACTIM8 -i ../OACTIM8.in.cpy -o ../OACTIM8.out.cpy`

- **Get Account**  
    `ol add --program-path GACTIM8 -i ../GACTIM8.in.cpy -o ../GACTIM8.out.cpy`
 
  
          
 ## Test the Assets
 > **NOTE:**  
> The test asset command must run from the module directory and you must be logged into the hub.  
> `ol login -api-key <your api key>`

### Open Account 
1. Go to  `accounts-ims\assets\oactim8\test_data\case-1\in.json` and replace it with the following JSON:

- [oactim8 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-ims/banking/resources/test-json/oactim8.json) 

2. Run `ol test asset oactim8`

### Get Account 
1. Go to `accounts-ims\assets\gactim8\test_data\case-1\in.json` and replace it with the following JSON:

- [gactim8 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-ims/banking/resources/test-json/gactim8.json) 


2. Run `ol test asset gactim8`

## Push Module to the Hub
- Run `ol push module`

## Create Hub Project

- `ol create project  accounts-ims-microservice --modules accounts-ims`

## Run No Code
Go to resources\docker account-ims-nocode.json and update the project name and API key.

Go to resources\docker and run the docker-compose.yml using the following command: docker-compose up -d

## OpenAPI
Go to http://localhost:8080/openAPI.

Send the request to test the API
