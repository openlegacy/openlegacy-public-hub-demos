# How To Create t24 customer Hub Project

## Pre-Requirements

- OpenLegacy cli installed on your PC.
- Java 11.
- OpenLegacy Hub account.

## Create a module

`ol create module --connector temenos-t24-tafc customer-t24`

## Test Connection

`ol test connection --host t24-tafc.openlegacy.com --port 20002 --username INPUTT --password 123456 --source TEST`

> **NOTE:**  
> The test connection command can run only from a module folder

## Create the assets

`ol add --protocol http:// --charset UTF-8 --timeout 30000 --t24-application CUSTOMER --gts-control 1 --company openlegacy --function I`

## Test the assets

> **NOTE:**  
> The test asset command must run from the module directory and you must be logged in to the hub.  
> `ol login -api-key <your api key>`

### Get customer

1.  Go to `customer-t24\assets\customer\test_data\case-1\in.json` and replace it with the following Json:

- [customer json](https://github.com/openlegacy/openlegacy-public-hub-demos/blob/master/t24/customer/resources/test-json/customer.json)

2.  Run `ol test asset customer`

## Push Module To The HUB

-Run `ol push module`

## Create Hub project

`ol create project customer-t24-microservice --modules customer-t24`
