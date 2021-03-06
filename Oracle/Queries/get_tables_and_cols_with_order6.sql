/* Formatted on 13/2/2016 16:04:34 (QP5 v5.252.13127.32867) */
  SELECT ATC.TABLE_NAME AS TBL_NM,
         ATC.COLUMN_NAME AS COL_NM,
         ATC.DATA_TYPE AS DT_TYP,
         ATC.*
    FROM USER_TAB_COLS ATC
         INNER JOIN USER_TABLES ATB ON ATC.TABLE_NAME = ATB.TABLE_NAME
   WHERE                                      --ATC.COLUMN_NAME NOT LIKE '%$%'
         --AND
         ATC.VIRTUAL_COLUMN = 'NO' AND ATC.HIDDEN_COLUMN = 'NO'
ORDER BY ATC.TABLE_NAME ASC, ATC.COLUMN_ID ASC;