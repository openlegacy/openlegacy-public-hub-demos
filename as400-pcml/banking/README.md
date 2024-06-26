# How To Create AS400 PCML Banking Accounts Hub Project

## Pre-Requirements

- OpenLegacy CLI installed on your PC.
- Java 17.
- OpenLegacy Hub account.
- Legacy sources from the resources folder:  
  [GACTCS6X.pcml](./resources/GACTCS6X.pcml) , [OACTCS6X.pcml](./resources/OACTCS6X.pcml).

## Create a module

`ol create module --connector as400-pcml account-as400-pcml`

Enter the module folder

`cd account-as400-pcml`

## Add externalLibs property to module.json

1. Go to `module.json` and add the `externalLibs` property to the connection properties inside the generated default profile. This is needed to tell the jt400 which additional libraries to load.
 <details>
  <summary>module.json</summary>

```
{
  "profiles": {
    "$default": {
      "externalLibs": ["RMR2L1"],
       ...
       ...
    }
  }
}

```
</details>
 
## Test Connection

`ol test connection --host ibmi75.openlegacy.com --user OPENLEGA1 --password OPENLEGA --external-libs RMR2L1`


## Create the assets

Before creating the assets please save the resources folder into your module folder.

- **Open Account**  
  `ol add --source-path ..\resources\OACTCS6X.pcml`
- **Get Account**  
  `ol add --source-path ..\resources\GACTCS6X.pcml`

  ## Test the assets

> **NOTE:**  
> The test asset command must be run from the module directory and you must be logged into the hub.  
> `ol login -api-key <your api key>`

### Open Account

1.  Go to `account-as400-pcml\assets\oactcs6X\test_data\case-1\in.json` and replace it with the following Json:

- [oactcs6X json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/as400-pcml/banking/resources/test-json/oactcs6x.json)

2.  Run `ol test asset oactcs6X`

### Get Account

1.  Go to `account-as400-pcml\assets\gactcs6X\test_data\case-1\in.json` and replace it with the following Json:

- [gactcs6X json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/as400-pcml/banking/resources/test-json/gactcs6x.json)

2.  Run `ol test asset gactcs6X`

## Push Module To The Hub

- Run `ol push module`

## Create Hub project

- `ol create project account-as400-pcml-microservice --modules account-as400-pcml`

## Run No Code

- Go to `resources\docker` [account-as400-pcml-nocode.json](./resources/docker/account-as400-pcml-nocode.json) and update the project name and API key.

- Go to `resources\docker` and run the [docker-compose.yml](./resources/docker/docker-compose.yml) using the following command: `docker-compose up -d`

## OpenAPI

- Go to http://localhost:8080/openAPI.

- Send the request to test the API
