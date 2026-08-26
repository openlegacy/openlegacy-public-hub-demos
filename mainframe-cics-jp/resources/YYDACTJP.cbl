CBL NODYNAM,OBJECT,APOST,NOSEQ
      **************************************************************
      * YYDACTJP - DELETE ACCOUNT FOR CICS AND DB2.
      **************************************************************
        IDENTIFICATION DIVISION.
        PROGRAM-ID. YYDACTJP.
        DATA DIVISION.
      **************************************************************
        WORKING-STORAGE SECTION.
      **************************************************************
            EXEC SQL
              INCLUDE SQLCA
            END-EXEC.
      **************************************************************
       01  DCLACCOUNT.
           10 ACCT_ACCOUNT_ID      PIC X(11).
           10 ACCT_CUSTOMER_ID     PIC X(16).
           10 ACCT_CUSTOMER_NAME   PIC G(16) USAGE DISPLAY-1.
           10 ACCT_ZIP_CODE        PIC X(10).
           10 ACCT_ADDRESS         PIC G(30) USAGE DISPLAY-1.
           10 ACCT_IBAN            PIC X(32).
           10 ACCT_BNK_ID          PIC X(4).
           10 ACCT_BRNCH_ID        PIC S9(9) COMP.
           10 ACCT_CNTRY_CD        PIC X(2).
           10 ACCT_TYPCD           PIC X(1).
           10 ACCT_SUB_TYPCD       PIC X(3).
           10 ACCT_TYPE_NAME       PIC X(12).
           10 ACCT_TYPE_DESCRIPTION  PIC X(40).
           10 ACCT_BALANCE         PIC S9(11)V9(3) USAGE COMP-3.
           10 ACCT_CURRENCY        PIC X(3).
           10 ACCT_CRT_DT          PIC X(8).
           10 ACCT_UPDT_DT         PIC X(8).
           10 ACCT_LOCKED          PIC X(1).
      **************************************************************
        01 ACCOUNT-WS.
          05 ACCOUNT-DETAILS.
            07 ACTW-ACCOUNT-ID      PIC X(11).
            07 ACTW-CUSTOMER-ID     PIC X(16).
            07 ACTW-CUSTOMER-NAME   PIC G(16) USAGE DISPLAY-1.
            07 ACTW-ZIP-CODE        PIC X(10).
            07 ACTW-ADDRESS         PIC G(30) USAGE DISPLAY-1.
            07 ACTW-IBAN            PIC X(32).
            07 ACTW-BNK-ID          PIC X(4).
            07 ACTW-BRNCH-ID        PIC S9(9) COMP.
            07 ACTW-CNTRY-CD        PIC X(2).
            07 ACTW-TYPCD           PIC X(1).
            07 ACTW-SUB-TYPCD       PIC X(3).
            07 ACTW-TYPE-NAME       PIC X(12).
            07 ACTW-TYPE-DESCRIPTION  PIC X(40).
            07 ACTW-BALANCE         PIC S9(11)V9(3) USAGE COMP-3.
            07 ACTW-CURRENCY        PIC X(3).
            07 ACTW-CRT-DT          PIC X(8).
            07 ACTW-UPDT-DT         PIC X(8).
            07 ACTW-LOCKED          PIC X(1).
      ****************************************************
        01 SPACE-COUNT              PIC S9.
        01 TXT-SQLCODE              PIC X(12) VALUE SPACES.
        01 TXT-SQLSTATE             PIC X(12) VALUE SPACES.
        01 TXT-SQLERRMC             PIC X(70) VALUE SPACES.
        01 WS-ME                    PIC X(9) VALUE "YYDACTJP".
      **************************************************************
        LINKAGE SECTION.
      **************************************************************
        01 DFHCOMMAREA.
          03 IN-PUT.
            05 ACTI-ACCOUNT-ID               PIC X(11).
          03 ACCOUNT-OUT.
            05 ACCOUNT-DETAILS.
              07 ACTO-ACCOUNT-ID             PIC X(11).
              07 ACTO-CUSTOMER-ID            PIC X(16).
              07 ACTO-CUSTOMER-NAME          PIC G(16) USAGE DISPLAY-1.
              07 ACTO-ZIP-CODE               PIC X(10).
              07 ACTO-ADDRESS                PIC G(30) USAGE DISPLAY-1.
              07 ACTO-IBAN                   PIC X(32).
              07 ACTO-CNTRY-CD               PIC X(2).
              07 ACTO-BNK-ID                 PIC X(4).
              07 ACTO-BRNCH-ID               PIC S9(9) COMP.
              07 ACTO-TYPCD                  PIC X.
              07 ACTO-TYPE-NAME              PIC X(12).
              07 ACTO-SUB-TYPCD              PIC X(3).
              07 ACTO-TYPE-DESCRIPTION       PIC X(40).
              07 ACTO-BALANCE                PIC S9(11)V9(3) COMP-3.
              07 ACTO-CURRENCY               PIC X(3).
              07 ACTO-CRT-DT                 PIC X(8).
              07 ACTO-UPDT-DT                PIC X(8).
              07 ACTO-LOCKED                 PIC X.
                88 ACTO-LOCKED-YES              VALUE 'Y'.
                88 ACTO-LOCKED-NO               VALUE 'N'.
            05 RT-MSG                        PIC X(60).
      **************************************************************
       PROCEDURE DIVISION.
       MAIN-RTN.
           PERFORM GET-INPUT THRU GET-INPUT-END
           PERFORM DO-SQL THRU DO-SQL-END
           GOBACK.
      **************************************************************
       GET-INPUT.
            MOVE ACTI-ACCOUNT-ID   TO ACTW-ACCOUNT-ID.
            DISPLAY WS-ME ' ACCOUNT-ID = ' ACTW-ACCOUNT-ID.
       GET-INPUT-END.
           EXIT.
      **************************************************************
       DO-SQL.
            MOVE LOW-VALUES TO ACCOUNT-OUT
            DISPLAY  WS-ME ' ACTW-ACCOUNT-ID FOR DELETE: '
                     ACTW-ACCOUNT-ID
            EXEC SQL
                 DELETE FROM OLS0002.ACCOUNT2 WHERE
                   ACCT_ACCOUNT_ID = :ACTW-ACCOUNT-ID
              END-EXEC.
              PERFORM DO-POSTSQL THRU DO-POSTSQL-END.
       DO-SQL-END.
           EXIT.
      **************************************************************
       DO-POSTSQL.
            IF SQLCODE = 0
               MOVE 'SUCCESSFUL DELETE' TO RT-MSG
            ELSE
               MOVE 'NOT SUCCESSFUL DELETE' TO RT-MSG
               DISPLAY WS-ME ' NOT SUCCESSFUL DELETE'
               MOVE SQLCODE TO TXT-SQLCODE
               MOVE SQLSTATE TO TXT-SQLSTATE
               MOVE SQLERRMC TO TXT-SQLERRMC
               DISPLAY WS-ME ' SQLCODE:  ' TXT-SQLCODE
               DISPLAY WS-ME ' SQLSTATE: ' TXT-SQLSTATE
               DISPLAY WS-ME ' SQLERRMC: ' TXT-SQLERRMC
            END-IF.
       DO-POSTSQL-END.
           EXIT.
      **************************************************************