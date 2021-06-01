## Note - this demo is still not ready due to product limitations

# How To Create Z/OS DB2 Insurance Module

- Schema: `DEMO001`.
- Procedures: `LPOLSQL`, `GPOLSQL`, `OPOLSQL`, `UPOLSQL`, `DPOLSQL`, `RPOLSQL`.

## Pre-Requirements

- OpenLegacy cli installed on your PC.
- Copy DB2 driver and license jars: https://hub-support.openlegacy.com/en/article/db2-zoa-sp-connector
- Java 11.
- OpenLegacy Hub account.

> **_NOTE:_**  When preparing for a DB2 project, Db2 driver and license should be provided by the client.

## Create a module

`ol create module --connector db2-zos-db policy-db2`

Enter to the module folder.

## Test Connection

```
ol test connection --url jdbc:db2://mainframe.openlegacy.com:5035/DALLASB --username DEMO001 --password LEGACY --driver-class-name com.ibm.db2.jcc.DB2Driver
```

## Create the assets

- **Open Account**
  
  `ol add --executable DEMO001.OPOLSQL`
 
- **Get Account**

  `ol add --executable DEMO001.GPOLSQL --advanced-result-set-query "CALL DEMO001.GPOLSQL('1498640006')"`
  
## Test the assets

> **NOTE:**  
> The test asset command must run from the module directory and you must be logged in to the hub.  
> `ol login -api-key <your api key>`

### Open Account

1.  Go to `policy-db2/assets/opolsql/test_data/case-1/in.json` and replace it with the following Json:

- [opolsql json](https://github.com/openlegacy/openlegacy-hub-demos/blob/master/mainframe-db2/insurance/resources/test-json/open-account.json)

2.  Run `ol test asset opolsql`

### Get Account

1.   Go to `policy-db2/assets/gpolsql/test_data/case-1/in.json` and replace it with the following Json: 

- [gpolsql json](https://github.com/openlegacy/openlegacy-hub-demos/blob/master/mainframe-db2/insurance/resources/test-json/get-account.json)

2.  <s>Run `ol test asset gpolsql`</s> 

## Push Module To The Hub

- Run `ol push module`

## Create Hub project

- `ol create project policy-db2-microservice --modules policy-db2`
