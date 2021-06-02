# How To Create CICS Policy Module

## Pre-Requirements

- OpenLegacy cli installed on your PC.
- Java 11.
- OpenLegacy Hub account.
- Legacy sources from the resources folder:  
- [GPOLCS2.cbl](./resources/GPOLCS2.cbl) , [LPOLCS2.cpy](./resources/LPOLCS2.cpy) , [OPOLCS2.cbl](./resources/OPOLCS2.cbl).


## Create a module

`ol create module --connector mf-cics-cobol policy-cics`

Enter to the module folder.

## Test connection

` ol test connection --base-url mainframe.openlegacy.com --port 12345 --uri-map ol/demos`

## Create the assets

Before creating the assets please save the resources folder into your module folder.

- **Open Policy**  
  ` ol add --program-path OPOLCS2 -i .\resources\OPOLCS2.in.cpy -o .\resources\OPOLCS2.out.cpy`

- **Get Policy**  
  `ol add --program-path GPOLCS2 -i .\resources\GPOLCS2.in.cpy -o .\resources\GPOLCS2.out.cpy`


## Test the assets

> **NOTE:**  
> The test asset command must run from the module directory and you must be logged in to the hub.  
> `ol login -api-key <your api key>`


### Open Policy

1.  Go to `policy-cics\assets\opolcs2\test_data\case-1\in.json` and replace it with the following Json:

- [opolcs2 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/insurance/resources/test-json/opolcs2.json)

2.  Run `ol test asset opolcs2`

### Get Policy

1.  Go to `policy-cics\assets\gpolcs2\test_data\case-1\in.json` and replace it with the following Json:

- [gpolcs2 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/insurance/resources/test-json/gpolcs2.json)

2.  Run `ol test asset gpolcs2`

## Push module to the Hub

- `ol push module`

## Create Hub project

- `ol create project policy-cics-microservice --modules policy-cics`

## Run No Code

- Go to `resources\docker` and update the [account-cics-nocode.json](./resources/docker/policy-cics-nocode.json) with project name and api key.

- Go to `resources\docker` and run the [docker-compose.yaml](./resources/docker/docker-compose.yml) file using the following command: `docker-compose up -d`

## Open API

- Go to http://localhost:8080/openapi.

- Send the request to test the api