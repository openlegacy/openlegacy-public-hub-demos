# How To Create AS400 Cobol Insurance Module

## Pre-Requirements
- OpenLegacy CLI installed on your PC.
- Java 11.
- OpenLegacy Hub account.
- Legacy sources from the resources folder:
[POL2LST.cbl](./resources/POL2LST.cbl), [POL2GET.cbl](./resources/POL2GET.cbl).

## Create a module

`ol create module --connector as400-cobol policy-as400-cobol`

## Test Connection 
ol test connection --host as400.openlegacy.com --user openlega1 --password openlega

## Create the assets
- **Get All Policies**  
`ol add --source-path ../resources/POL2LST.cbl --program-path /QSYS.LIB/POLICY.LIB/POL2LST.PGM`
- **Get One Policy**  
`ol add --source-path ../resources/POL2GET.cbl --program-path /QSYS.LIB/POLICY.LIB/POL2GET.PGM`

> **NOTE:**  
> The test asset command must be run from the module directory and you must be logged into the hub.  
> `ol login -api-key <your api key>`

### Get All Policies

1. Run `ol test asset pol2lst`

### Get One Policy 
1. Go to `policy-as400-cobol\assets\pol2get\test_data\case-1\in.json` and replace it with the following JSON:

- [pol2get json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/as400-cobol/insurance/resources/test-json/pol2get.json)   

2. Run `ol test asset pol2get`
## Push module to the Hub

- `ol push module`

## Create Hub project

- `ol create project policy-as400-cobol-microservice --modules policy-as400-cobol`

## Run No Code

- Go to `resources\docker` [account-cics-nocode.json](./resources/docker/policy-as400-cobol-nocode.json) and update the project name and API key.

- Go to `resources\docker` and run the [docker-compose.yml](./resources/docker/docker-compose.yml) using the following command: `docker-compose up -d`

## Open API

- Go to http://localhost:8080/openapi.

- Send the request to test the API