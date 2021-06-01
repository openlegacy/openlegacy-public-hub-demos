# How To Create CICS Banking Accounts Hub Project

## Pre-Requirements

- OpenLegacy cli installed on your PC.
- Java 11.
- OpenLegacy Hub account.
- Legacy sources from the resources folder:  
- Docker
- docker-compose
[OACTCS9.cbl](./resources/OACTCS9.cbl), [GACTCS9.cbl](./resources/GACTCS9.cbl).

## Create a module

`ol create module --connector mf-cics-cobol accounts-cics`

Enter to the module folder.

## Test Connection

` ol test connection --base-url mainframe.openlegacy.com --port 12345 --uri-map /ol/demos`

## Create the assets

Before creating the assets please save the resources folder into your module folder.

- **Open Single Account**  
  `ol add --source-path .\resources\OACTCS9.cbl --program-path OACTCS9`
- **Get Single Account**  
  `ol add -i .\resources\GACTCS9I.cpy -o .\resources\GACTCS9O.cpy --program-path GACTCS9`


## Test the assets

> **NOTE:**  
> The test asset command must run from the module directory and you must be logged in to the hub.  
> `ol login -api-key <your api key>`


### Open Account

1.  Go to `accounts-cics\assets\oactcs9\test_data\case-1\in.json` and replace it with the following Json:

- [oactcs9 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/banking/resources/test-json/oactcs9.json)

2.  Run `ol test asset oactcs9`

### Get Single Account

1.  Go to `accounts-cics\assets\gactcs9\test_data\case-1\in.json` and replace it with the following Json:

- [gactcs9 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/banking/resources/test-json/gactcs9.json)

2.  Run `ol test asset gactcs9`

## Push Module To The Hub

- Run `ol push module`

## Create Hub project

- `ol create project accounts-cics-microservice --modules accounts-cics`

## Run No Code

- Go to `resources\docker` [account-cics-nocode.json](./resources/docker/account-cics-nocode.json) and update the project name and api key.

- Go to `resources\docker` and run the [docker-compose.yml](./resources/docker/docker-compose.yml) using the following command: `docker-compose up -d`

## Open API

- Go to http://localhost:8080/openapi.

- Send the request to test the api