# How To Create SAP-RFC Customers Hub Project

## Pre-Requirements

- OpenLegacy CLI installed on your PC.
- Java 11.
- OpenLegacy Hub account.
- Copy SAP libraries: https://hub-support.openlegacy.com/en/article/sap-connector
- Docker
- docker-compose

## Create a module

- `ol create module --connector sap-rfc customers-sap`

## Test Connection

1. Enter the module folder: `cd customers-sap/` 
2. Test connection to SAP: `ol test connection --hostname sap.openlegacy.com --user user02 --password open1234 --system-number 04 --client 800 --language en`

## Create the asset

- `ol add --bapi-name BAPI_CUSTOMER_GETLIST`

## Test the Assets

> **NOTE:**  
> The test asset command must be run from the module directory and you must be logged into the hub.  
> `ol login -api-key <your api key>`

1.  Go to `customers-sap\assets\bapi_customer_getlist\test_data\case-1\in.json` and replace it with the following Json:

    ```  
      {
        "cpdonly" : "",
        "maxrows" :5,
       
        "idrange" : [ {
          "sign" : "I",
          "option" : "CP",
          "low" : "*",
          "high" : ""
        } ],
        "specialdata" : [ {
          "customer" : "FIO-CUST01",
          "acc1Time" : ""
        } ]
      }
    ```

2.  Run `ol test asset bapi_customer_getlist`


## Push Module to the Hub

- Run `ol push module`

## Create Hub project

- `ol create project customer-sap-microservice --modules customers-sap`

## Run No Code

- Go to `resources\docker` save and update the [customer-sap-nocode.json](./resources/docker/customer-sap-nocode.json) with project name and API key.

- Go to `resources\docker` save and run the [docker-compose.yaml](./resources/docker/docker-compose.yml) file using the following command: `docker-compose up -d`

## Open API

- Go to http://localhost:8080/openapi.

- Send the request to test the API
