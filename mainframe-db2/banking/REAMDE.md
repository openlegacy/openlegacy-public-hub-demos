## Note - this demo is still not ready due to product limitations

# How To Create Z/OS DB2 Banking Accounts Module

- Schema: `DEMO001`.
- Procedures: `LACTSQL`, `GACTSQL`, `OACTSQL`, `UACTSQL`, `DACTSQL`, `RACTSQL`.

## Pre-Requirements

- OpenLegacy cli installed on your PC.
- Copy DB2 driver and license jars: https://hub-support.openlegacy.com/en/article/db2-zoa-sp-connector
- Java 11.
- OpenLegacy Hub account.

> **_NOTE:_**  When preparing for a DB2 project, Db2 driver and license should be provided by the client.

## Create a module

`ol create module --connector db2-zos-db account-db2`

Enter to the module folder.

## Test Connection


```
ol test connection --url jdbc:db2://mainframe.openlegacy.com:5035/DALLASB --username DEMO001 --password LEGACY --driver-class-name com.ibm.db2.jcc.DB2Driver
```

## Create the assets

- **Open Account**
  
  `ol add --executable DEMO001.OACTSQL`
 
- **Get Account**

  `ol add --executable DEMO001.GACTSQL --advanced-result-set-query "CALL DEMO001.GACTSQL('68841327752')"`


## Test the resources

> **NOTE:**  
> The test asset command must run from the module directory and you must be logged in to the hub.  
> `ol login -api-key <your api key>`

### Open Account

1.  Go to `account-db2/assets/oactsql/test_data/case-1/in.json` and replace it with the following Json:

- [oactsql json](https://github.com/openlegacy/openlegacy-hub-demos/blob/master/mainframe-db2/banking/resources/test-json/open-account.json)

2.  Run `ol test asset oactsql`

###  Get Account 

1.  <s> Go to `account-db2/assets/gactsql/test_data/case-1/in.json` and replace it with the following Json: </s>

- [gactsql json](https://github.com/openlegacy/openlegacy-hub-demos/blob/master/mainframe-db2/banking/resources/test-json/get-account.json)

2.  <s> Run `ol test asset gactsql` </s>

## Push Module To The Hub

- Run `ol push module`

## Create Hub project

- `ol create project account-db2-microservice --modules account-db2`
