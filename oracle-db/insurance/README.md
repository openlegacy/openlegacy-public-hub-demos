# How To Create Oracle Insurance Policy SP Module

## Pre-Requirements

- OpenLegacy CLI installed on your PC.
- Java 11.
- OpenLegacy Hub account.

## Log into the Hub

`ol login -api-key <your api key>`

## Create a module

`ol create module --connector oracle-db   policy-oracle`

Enter to the module folder.

## Test connection

```
ol test connection --driver-class-name oracle.jdbc.driver.OracleDriver --url jdbc:oracle:thin:@//oracle.openlegacy.com/ORCL --username openlegacy_team --password 'gp#6KN!yBiV' 
```

## Create the assets

- **Create Policy**  
  `ol add --executable OPENLEGACY_TEAM.INSURANCE_POLICIES_PACKAGE.CREATE_POLICY`
  
- **Get Policy**
`ol add --executable OPENLEGACY_TEAM.INSURANCE_POLICIES_PACKAGE.GET_POLICY`

## Test the assets

> **NOTE:**  
> The test asset command must be run from the module directory.  

### Create Policy

1. Go to `policy-oracle\assets\create_policy\test_data\case-1\in.json` and replace it with the following JSON:

- [create-policy json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/oracle-db/insurance/resources/test-json/create-policy.json) 

2. Run `ol test asset create_policy`

### Get Policy

1. Go to ` policy-oracle\assets\get_policy\test_data\case-1\in.json` and replace it with the following JSON:

- [get-policy json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/oracle-db/insurance/resources/test-json/get-policy.json) 

2. Run `ol test asset get_policy`

## Push module to the Hub

- `ol push module`

## Create Hub project

- `ol create project  policy-oracle-microservice --modules policy-oracle`

## Run No Code

- Go to `resources\docker` and update the [policy-oracle-nocode.json](./resources/docker/policy-oracle-nocode.json)  project name and API key.

- Go to `resources\docker` and run the [docker-compose.yml](./resources/docker/docker-compose.yml) file using the following command: `docker-compose up -d`

## Open API

- Go to http://localhost:8080/openapi.

- Send the request to test the API
