# 日本語口座アプリケーションを呼び出すOpenLegacy Hubプロジェクトの作成手順
(English guide follows Japanese guide)

## 要件

- OpenLegacy CLI が利用するPCにインストールされ、OpenLegacy Hubで発行したAPI Keyでログインされていること。
- Java 11。
- OpenLegacy Hub アカウント。
- TCP/IP ポート 12344でmainframe.openlegacy.comにアクセスできること。
- resourcesにあるCOBOLのソースコードファイルやdockerフォルダー下のファイルがダウンロードされていること:
　 [YYOACTJP.cbl](./resources/YYOACTJP.cbl), [YYGACTJP.cbl](./resources/YYGACTJP.cbl), [YYGACTJP.cbl](./resources/YYLACTJP.cbl), [YYGACTJP.cbl](./resources/YYDACTJP.cbl).
- Docker
- docker-compose

## モジュールの作成
以下のol コマンドを実行して account-cics-jpというModuleを作成します。
`ol create module --connector mf-cics-cobol account-cics-jp`

account-cics-jpディレクトリが作成されるので、そこへ移動します。

## Test Connection
以下のol コマンドを実行して、Connection Profileの作成と接続テストを行います。
` ol test connection --base-url http://mainframe.openlegacy.com --port 12344 --uri-map /OL/DEMOJP --code-page cp939`

## アセットの作成

アセットを作成する前に、すでにダウンロードしたCOBOLのソースファイルを、モジュールのディレクトリ下のresourcesディレクトリを作成して、そこにコピーします。もしくはコマンド実行する際、すでにコピーしたソースファイルのPathで置き換えて実行してください。
以下のコマンドを実行して、アセットを作成します。
- **口座の開設**  
  `ol add --source-path .\resources\YYOACTJP.cbl --program-path YYOACTJP --asset-name open-account`
- **口座情報の取得**  
  `ol add --source-path .\resources\YYGACTJP.cbl --program-path YYGACTJP --asset-name get-account`
- **口座リストの取得**  
  `ol add --source-path .\resources\YYLACTJP.cbl --program-path YYLACTJP --asset-name list-account`
- **口座の削除**  
  `ol add --source-path .\resources\YYDACTJP.cbl --program-path YYDACTJP --asset-name delete-account`


## アセットのテスト

> **注意**  
> ol test assetコマンドは必ずモジュールのディレクトリから実行すること。また以下のコマンドでOpenLegacy Hubにログインしていることを確認してください。
> `ol login -api-key <your api key>`

### List Account
まず最初に list-account を実行してください。そしてactiAccountIdに指定されている値を確認してください。.
1.  `accounts-cics\assets\yylactjp\test_data\case-1\in.json`をエディタでオープンし、下記JSONファイルの内容で置き換えてください:

- [mod-list-account.json](./testcases/mod-list-account.json)

2.  `ol test asset yylactjp`を実行してください。

### Open Account

1.  `accounts-cics\assets\yyoactjp\test_data\case-1\in.json` をエディタでオープンし、下記JSONファイルの内容で置き換えてください:
  
- [mod-open-account.json](./testcases/mod-open-account.json)
- そしてList Accountの結果を見て、まだ指定されていない11バイトの数字からなる文字列をactiAccountIdに指定してください。

2.  `ol test asset yyoactjp`を実行してください。

### Get Single Account

1.  `accounts-cics\assets\gactcs9\test_data\case-1\in.json`をエディタでオープンし、下記JSONファイルの内容で置き換えてください:

- [mod-get-account.json](./testcases/mod-get-account.json)
- そしてOpen Accountで指定したactiAccountIdの値で、actiAccountIdの値を置き換えてください。

2.  Run `ol test asset yygactjp`を実行してください。

### Delete Single Account

1.  `accounts-cics\assets\yydactjp\test_data\case-1\in.json`をエディタでオープンし、下記JSONファイルの内容で置き換えてください:

- [mod-delete-account.json](./testcases/mod-delete-account.json)
- そしてOpen Accountで指定したactiAccountIdの値で、actiAccountIdの値を置き換えてください。

2.  `ol test asset yydactjp`を実行してください。

## モジュールをOpenLegacy HubにPushします
- `ol push module`を実行します。

## OpenLegacy Hubプロジェクトを作成します。

- `ol create project accounts-cics-svc-jp --modules account-cics-jp`を実行します。
  このとき指定したモジュールの情報からContractとメソッドフローが自動生成されます。

## No Codeを実行

- `resources\docker`をオープンして[account-cics-nocode.json](./resources/docker/account-cics-nocode.json) をエディタでオープンしてproject name and API keyを置き換えます。

- `resources\docker` で、[docker-compose.yaml](./resources/docker/docker-compose.yml) を使った、`docker-compose up -d`コマンドを実行します。

## Open API

- ブラウザでhttp://localhost:8080/openapiをオープンすると、swaggerページがオープンされます。

- Sagger Pageで APIのテストを行います。


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

