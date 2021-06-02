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

`ol create module --connector sybase-db account-sybase`

Enter to the module folder.

## Test Connection

`ol test connection --verbose --url jdbc:jtds:sybase://54.86.8.16:5000 --username sa --password myPassword`

## Create the assets

Before creating the assets please save the resources folder into your module folder.

- **Open Single Account**  
  `ol add --executable "master.dbo.OPEN_ACCOUNT" --advanced-result-set-query "EXEC master.dbo.OPEN_ACCOUNT @P_ACCOUNT_ID = '00318662321', @P_CUSTOMER_ID = '1006200630033322', @P_CUSTOMER_NAME = 'John Doe', @P_IBAN = 'GB21BARC20035318623121', @P_COUNTRY_CODE = 'IS', @P_BANK_ID = 'HAPO', @P_BRNCH_ID = '20025', @P_TYPCD = 'P',   @P_TYPE_NAME = 'MM Personal', @P_SUB_TYPCD = '', @P_TYPE_DESCRIPTION = 'Money Market Account', @P_BALANCE = 8237,  @P_CURRENCY = 'USA',  @P_LOCKED = 'N'"`
- **Get Single Account**  
  `ol add --executable "master.dbo.GET_ACCOUNT" --advanced-result-set-query "EXEC master.dbo.GET_ACCOUNT @P_ACCOUNT_ID='00318663682'"`


## Test the assets

> **NOTE:**  
> The test asset command must run from the module directory and you must be logged in to the hub.  
> `ol login -api-key <your api key>`


### Open Account

1.  Go to `account-sybase\assets\open_account\test_data\case-1\in.json` and replace it with the following Json:

- [oactcs9 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/sybase/banking/resources/test-json/open_account.json)

2.  Run `ol test asset open_account`

### Get Single Account

1.  Go to `account-sybase\assets\get_account\test_data\case-1\in.json` and replace it with the following Json:

- [gactcs9 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/sybase/banking/resources/test-json/get_account.json)

2.  Run `ol test asset get_account`

## Push Module To The Hub

- Run `ol push module`

## Create Hub project

- `ol create project account-sybase-microservice --modules account-sybase`

## Run No Code

- Go to `resources\docker` [account-sybase-nocode.json](./resources/docker/account-sybase-nocode.json) and update the project name and api key.

- Go to `resources\docker` and run the [docker-compose.yml](./resources/docker/docker-compose.yml) using the following command: `docker-compose up -d`

## Open API

- Go to http://localhost:8080/openapi.

- Send the request to test the api