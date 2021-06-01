# How To Create CICS Banking Accounts Hub Project

## Pre-Requirements

- OpenLegacy cli installed on your PC.
- Java 11.
- OpenLegacy Hub account.
- Legacy sources from the resources folder:  
  [RACTCS9.cbl](./resources/RACTCS9.cbl) , [LACTCS9.cbl](./resources/LACTCS9.cbl) , [OLACTCS9.cbl](./resources/OACTCS9.cbl), [UACTCS9.cbl](./resources/UACTCS9.cbl), [GACTCS9.cbl](./resources/GACTCS9.cbl), [DACTCS9.cbl](./resources/DACTCS9.cbl).

## Create a module

`ol create module --connector mf-cics-cobol accounts-cics`

Enter to the module folder.

## Test Connection

` ol test connection --base-url mainframe.openlegacy.com --port 12345 --uri-map /ol/demos`

## Create the assets

Before creating the assets please save the files from the resources folder into your module folder.

- **Reset Accounts**  
  `ol add --source-path .\RACTCS9.cbl --program-path RACTCS9`
- **Get All Accounts**  
  `ol add -i ..\resources\LACTCS9I.cpy -o ..\resources\LACTCS9O.cpy --program-path LACTCS9`
- **Open Single Account**  
  `ol add --source-path .\OACTCS9.cbl --program-path OACTCS9`
- **Update Single Account**  
  `ol add --source-path .\UACTCS9.cbl --program-path UACTCS9`
- **Get Single Account**  
  `ol add -i ..\resources\GACTCS9I.cpy -o ..\resources\GACTCS9O.cpy --program-path GACTCS9`
- **Delete Single Account**  
  `ol add -i ..\resources\DACTCS9I.cpy -o ..\resources\DACTCS9O.cpy --program-path DACTCS9`

## Test the assets

> **NOTE:**  
> The test asset command must run from the module directory and you must be logged in to the hub.  
> `ol login -api-key <your api key>`

### Reset Accounts

1.  Go to `accounts-cics\assets\ractcs9\test_data\case-1\in.json` and replace it with the following Json:

- [ractcs9 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/banking/resources/test-json/ractcs9.json)

2.  Run `ol test asset ractcs9`

### Get All Accounts

1.  Go to `accounts-cics\assets\lactcs9\test_data\case-1\in.json` and replace it with the following Json:

- [lactcs9 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/banking/resources/test-json/lactcs9.json)

2. Run `ol test asset lactcs9`

### Open Account

1.  Go to `accounts-cics\assets\oactcs9\test_data\case-1\in.json` and replace it with the following Json:

- [oactcs9 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/banking/resources/test-json/oactcs9.json)

2.  Run `ol test asset oactcs9`

### Update Single Account

1.  Go to `accounts-cics\assets\uactcs9\test_data\case-1\in.json` and replace it with the following Json:

- [uactcs9 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/banking/resources/test-json/uactcs9.json)

2.  Run `ol test asset uactcs9`

### Get Single Account

1.  Go to `accounts-cics\assets\gactcs9\test_data\case-1\in.json` and replace it with the following Json:

- [gactcs9 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/banking/resources/test-json/gactcs9.json)

2.  Run `ol test asset gactcs9`

### Delete Single Account

1.  Go to `accounts-cics\assets\dactcs9\test_data\case-1\in.json` and replace it with the following Json:

- [dactcs9 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/banking/resources/test-json/dactcs9.json)

2.  Run `ol test asset dactcs9`

## Push Module To The Hub

- Run `ol push module`

## Create Hub project

- `ol create project accounts-cics-microservice --modules accounts-cics`