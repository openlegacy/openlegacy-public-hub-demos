# How To Create CICS Policy Module

## Pre-Requirements

- OpenLegacy cli installed on your PC.
- Java 11.
- OpenLegacy Hub account.
- Legacy sources from the resources folder:  
  [GPOLCS2.cbl](./resources/GPOLCS2.cbl) , 
  [LPOLCS2.cpy](./resources/LPOLCS2.cpy) , [OPOLCS2.cbl](./resources/OPOLCS2.cbl).


## Create a module

`ol create module --connector mf-cics-cobol policy-cics`

Enter to the module folder.

## Test connection

` ol test connection --base-url mainframe.openlegacy.com --port 12345 --uri-map ol/demos`

## Create the assets

Before creating the assets please save the files from the resources folder into your module folder and enter the module folder.

- **Rest Policy** 
`ol add --program-path  RPOLCS2  -i  ../resources/RPOLCS2.cpy -o ../resources/RPOLCS2.cpy`

- **Get All Policies**  
 `ol add --program-path  LPOLCS2  -i  ..\resources\LPOLCS2.in.cpy -o ..\resources\LPOLCS2.out.cpy`

- **Open Policy**  
  ` ol add --program-path OPOLCS2 -i ..\resources\OPOLCS2.in.cpy -o ..\resources\OPOLCS2.out.cpy`

- **Get Policy**  
  `ol add --program-path GPOLCS2 -i ..\resources\GPOLCS2.in.cpy -o ..\resources\GPOLCS2.out.cpy`

- **Update Policy**
  `ol add --program-path UPOLCS2 -i ..\resources\UPOLCS2.in.cpy -o ..\resources\UPOLCS2.out.cpy`

- **Delete Policy** 
  `ol add --program-path DPOLCS2 -i ..\resources\DPOLCS2.in.cpy -o ..\resources\DPOLCS2.out.cpy`

## Test the assets

> **NOTE:**  
> The test asset command must run from the module directory and you must be logged in to the hub.  
> `ol login -api-key <your api key>`


### Reset Policies
 1. Go to `policy-cics\assets\rpolcs2\test_data\case-1\in.json` and replace it with the following Json:

- [rpolcs2 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/insurance/resources/test-json/rpolcs2.json)

2.  Run `ol test asset rpolcs2`.

### Get All Policies

1.  Run `ol test asset lpolcs2`.

### Open Policy

1.  Go to `policy-cics\assets\opolcs2\test_data\case-1\in.json` and replace it with the following Json:

- [opolcs2 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/insurance/resources/test-json/opolcs2.json)

2.  Run `ol test asset opolcs2`

### Get Policy

1.  Go to `policy-cics\assets\gpolcs2\test_data\case-1\in.json` and replace it with the following Json:

- [gpolcs2 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/insurance/resources/test-json/gpolcs2.json)

2.  Run `ol test asset gpolcs2`

## Upadate Policy
1.  Go to `policy-cics\assets\upolcs2\test_data\case-1\in.json` and replace it with the following Json:

- [upolcs2 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/insurance/resources/test-json/upolcs2.json)

2. Run `ol test asset upolcs2`

## Delete policy

1.  Go to `policy-cics\assets\dpolcs2\test_data\case-1\in.json` and replace it with the following Json:

- [dpolcs2 json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/mainframe-cics/insurance/resources/test-json/dpolcs2.json)

2.  Run `ol test asset dpolcs2`


## Push module to the Hub

- `ol push module`

## Create Hub project

- `ol create project policy-cics-microservice --modules policy-cics`
