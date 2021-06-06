# How To Create Oracle Banking Accounts Hub Project

## Pre-Requirements

- OpenLegacy cli installed on your PC.
- Java 11.
- OpenLegacy Hub account.
- Oracle Stored Procedures From `Schema`: `OPENLEGACY_TEAM`, `Package`: `BANK_ACCOUNTS_PACKAGE`.<br/>
  `OPEN_ACCOUNT`, `GET_ACCOUNT`.

## Create a module

`ol create module --connector oracle-db  account-oracle`

Enter to the module folder.

## Test Connection

```
ol test connection --driver-class-name oracle.jdbc.driver.OracleDriver --url jdbc:oracle:thin:@//oracle.openlegacy.com/ORCL --username openlegacy_team --password 'gp#6KN!yBiV'
```

## Create the assets
 
- **Open Account**

`ol add --executable OPENLEGACY_TEAM.BANK_ACCOUNTS_PACKAGE.OPEN_ACCOUNT`

- **Get Account**
  
 `ol add --executable OPENLEGACY_TEAM.BANK_ACCOUNTS_PACKAGE.GET_ACCOUNT`
     
## Test the assets

> **NOTE:**  
> The test asset command must run from the module directory and you must be logged into the hub.  
> `ol login -api-key <your api key>`

### Open Account

1.  Go to `account-oracle/assets/open_account/test_data/case-1/in.json` and replace it with the following Json:

- [open-account json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/oracle-db/banking/resources/test-json/open-account.json) 

2.  Run `ol test asset open_account`

### Get Account

1.  Go to `account-oracle/assets/get_account/test_data/case-1/in.json` and replace it with the following Json:

- [get-account json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/oracle-db/banking/resources/test-json/get-account.json) 

2.  Run `ol test asset get_account`

## Push Module to the Hub

- Run `ol push module`

## Create Hub project  

- `ol create project  account-oracle-microservice --modules account-oracle`

## Run No Code

- Go to `resources\docker` and update the [account-oracle-nocode.json](./resources/docker/account-cics-nocode.json) project name and API key.

- Go to `resources\docker` and run the [docker-compose.yml](./resources/docker/docker-compose.yml) file using the following command: `docker-compose up -d`

## Open API

- Go to http://localhost:8080/openapi.

- Send the request to test the API