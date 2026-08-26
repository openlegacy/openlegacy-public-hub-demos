# How To Create CICS Banking Accounts Hub Project with Japanese

## Pre-Requirements

- OpenLegacy CLI installed on your PC.
- Java 11.
- OpenLegacy Hub account.
- Legacy sources from the resources folder:  
- Docker
- docker-compose
- [YYOACTJP.cbl](./resources/YYOACTJP.cbl), [YYGACTJP.cbl](./resources/YYGACTJP.cbl), [YYGACTJP.cbl](./resources/YYLACTJP.cbl), [YYGACTJP.cbl](./resources/YYDACTJP.cbl).

## Create a module

`ol create module --connector mf-cics-cobol account-cics-jp`

Enter the module folder.

## Test Connection

` ol test connection --base-url http://mainframe.openlegacy.com --port 12344 --uri-map /OL/DEMOJP --code-page cp939`

## Create the assets

Before creating the assets please save the resources folder into your module folder.

- **Open Single Account**  
  `ol add --source-path .\resources\YYOACTJP.cbl --program-path YYOACTJP`
- **Get Single Account**  
  `ol add --source-path .\resources\YYGACTJP.cbl --program-path YYGACTJP`
- **List Accounts**  
  `ol add --source-path .\resources\YYLACTJP.cbl --program-path YYLACTJP`
- **Delete Account**  
  `ol add --source-path .\resources\YYDACTJP.cbl --program-path YYDACTJP`


## Test the Assets

> **NOTE:**  
> The test asset command must be run from the module directory and you must be logged into the hub.  
> `ol login -api-key <your api key>`

### List Account
Run list-account first to see what account ids are in use.
1.  Go to `accounts-cics\assets\yylactjp\test_data\case-1\in.json` and replace it with the following Json:

- [mod-list-account.json](./testcases/mod-list-account.json)

2.  Run `ol test asset yylactjp`

### Open Account

1.  Go to `accounts-cics\assets\yyoactjp\test_data\case-1\in.json` and replace it with the following Json:

- [mod-open-account.json](./testcases/mod-open-account.json)
- And change the account id which is not same as any of the list of accounts returned List Account test.

2.  Run `ol test asset yyoactjp`

### Get Single Account

1.  Go to `accounts-cics\assets\gactcs9\test_data\case-1\in.json` and replace it with the following Json:

- [mod-get-account.json](./testcases/mod-get-account.json)
- And the change account id which is used in Open Account test in the previous step.

2.  Run `ol test asset yygactjp`

### Delete Single Account

1.  Go to `accounts-cics\assets\yydactjp\test_data\case-1\in.json` and replace it with the following Json:

- [mod-delete-account.json](./testcases/mod-delete-account.json)
- And the change account id which is used in Open Account test.

2.  Run `ol test asset yydactjp`

## Push Module to the Hub

- Run `ol push module`

## Create Hub project

- `ol create project accounts-cics-svc-jp --modules accounts-cics-jp`

## Run No Code

- Go to `resources\docker` and update the [account-cics-nocode.json](./resources/docker/account-cics-nocode.json) with project name and API key.

- Go to `resources\docker` and run the [docker-compose.yaml](./resources/docker/docker-compose.yml) file using the following command: `docker-compose up -d`

## Open API

- Go to http://localhost:8080/openapi.

- Send the request to test the API

