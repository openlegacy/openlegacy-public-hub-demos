# 日本語口座アプリケーションを呼び出すOpenLegacy Hubプロジェクトの作成手順

## 要件

- OpenLegacy CLI が利用するPCにインストールされ、OpenLegacy Hubで発行したAPI Keyが設定されていること。
- Java 11。
- OpenLegacy Hub アカウント。
- TCP/IP ポート 12344でmainframe.openlegacy.comにアクセスできること。
- COBOLのソースコードファイルがダウンロードされていること:
　 [YYOACTJP.cbl](./resources/YYOACTJP.cbl), [YYGACTJP.cbl](./resources/YYGACTJP.cbl), [YYGACTJP.cbl](./resources/YYLACTJP.cbl), [YYGACTJP.cbl](./resources/YYDACTJP.cbl).
- Docker
- docker-compose

## モジュールの作成
以下のol コマンドを実行して account-cics-jpというModuleを作成する。
`ol create module --connector mf-cics-cobol account-cics-jp`

account-cics-jpディレクトリが作成されるので、そこへ移動する.

## Test Connection
以下のol コマンドを実行して、Connection Profileの作成と接続テストを行う。
` ol test connection --base-url http://mainframe.openlegacy.com --port 12344 --uri-map /OL/DEMOJP --code-page cp939`

## アセットの作成

アセットを作成する前に、resourcesフォルダーにあるCOBOLのソースファイルを、モジュールのディレクトリ下のresourcesディレクトリを作成して、そこにコピーすること。

- **口座の開設**  
  `ol add --source-path .\resources\YYOACTJP.cbl --program-path YYOACTJP`
- **口座情報の取得**  
  `ol add --source-path .\resources\YYGACTJP.cbl --program-path YYGACTJP`
- **口座リストの取得**  
  `ol add --source-path .\resources\YYLACTJP.cbl --program-path YYLACTJP`
- **口座の削除**  
  `ol add --source-path .\resources\YYDACTJP.cbl --program-path YYDACTJP`


## アセットのテスト

> **注意**  
> ol test assetコマンドは必ずモジュールのディレクトリから実行すること。また以下のコマンドでOpenLegacy Hubにログインすること。  
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

- `ol create project accounts-cics-svc-jp --modules account-cics-jp`

## Run No Code

- Go to `resources\docker` and update the [account-cics-nocode.json](./resources/docker/account-cics-nocode.json) with project name and API key.

- Go to `resources\docker` and run the [docker-compose.yaml](./resources/docker/docker-compose.yml) file using the following command: `docker-compose up -d`

## Open API

- Go to http://localhost:8080/openapi.

- Send the request to test the API


# How To Create CICS Banking Accounts Hub Project which invoke Japanese account applications

## Pre-Requirements

- OpenLegacy CLI installed on your PC.
- Java 11.
- OpenLegacy Hub account.
- Legacy sources from the resources folder:
  [YYOACTJP.cbl](./resources/YYOACTJP.cbl), [YYGACTJP.cbl](./resources/YYGACTJP.cbl), [YYGACTJP.cbl](./resources/YYLACTJP.cbl), [YYGACTJP.cbl](./resources/YYDACTJP.cbl).
- Docker
- docker-compose

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

- `ol create project accounts-cics-svc-jp --modules account-cics-jp`

## Run No Code

- Go to `resources\docker` and update the [account-cics-nocode.json](./resources/docker/account-cics-nocode.json) with project name and API key.

- Go to `resources\docker` and run the [docker-compose.yaml](./resources/docker/docker-compose.yml) file using the following command: `docker-compose up -d`

## Open API

- Go to http://localhost:8080/openapi.

- Send the request to test the API

