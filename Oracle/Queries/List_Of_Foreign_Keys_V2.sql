/* Formatted on 14.1.2016 15:27:45 (QP5 v5.252.13127.32867) */
WITH PK_LST
     AS (  SELECT COLS.TABLE_NAME,
                  COLS.COLUMN_NAME,
                  COLS.POSITION,
                  CONS.VALIDATED,
                  CONS.STATUS,
                  CONS.OWNER,
                  CONS.CONSTRAINT_NAME
             FROM ALL_CONSTRAINTS CONS
                  INNER JOIN ALL_CONS_COLUMNS COLS
                     ON     CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
                        AND CONS.OWNER = COLS.OWNER
            WHERE                         --COLS.TABLE_NAME = 'TABLE_NAME' AND
                 CONS .CONSTRAINT_TYPE = 'P'
                  AND UPPER (CONS.STATUS) = 'ENABLED'
                  AND UPPER (CONS.OWNER) = 'ISKUR'
                  AND COLS.TABLE_NAME NOT LIKE '%$%'
         ORDER BY COLS.TABLE_NAME, COLS.POSITION)
  SELECT C.OWNER,
         A.TABLE_NAME,
         A.COLUMN_NAME,
         A.CONSTRAINT_NAME,
         -- referenced pk
         C.R_OWNER,
         C_PK.TABLE_NAME R_TABLE_NAME,
         PK_LST.COLUMN_NAME AS R_COLUMN_NAME,
         C_PK.CONSTRAINT_NAME R_PK,
         C.CONSTRAINT_TYPE AS CTYP
         --,C_PK.R_CONSTRAINT_NAME
    --,C_PK.INDEX_NAME
    FROM ALL_CONS_COLUMNS A
         JOIN ALL_CONSTRAINTS C
            ON A.OWNER = C.OWNER AND A.CONSTRAINT_NAME = C.CONSTRAINT_NAME
         JOIN ALL_CONSTRAINTS C_PK
            ON     C.R_OWNER = C_PK.OWNER
               AND C.R_CONSTRAINT_NAME = C_PK.CONSTRAINT_NAME
         JOIN PK_LST
            ON     C_PK.CONSTRAINT_NAME = PK_LST.CONSTRAINT_NAME
               AND C_PK.TABLE_NAME = PK_LST.TABLE_NAME
   WHERE                                        --C_PK.CONSTRAINT_NAME IS NULL
                                                                         --AND
         C.CONSTRAINT_TYPE = 'R' AND UPPER (C.OWNER) = 'ISKUR'
--(   (A.TABLE_NAME LIKE '%' || UPPER ( :PTABLENAME) || '%')
-- OR (C_PK.TABLE_NAME LIKE '%' || UPPER ( :PTABLENAME) || '%'))

ORDER BY A.CONSTRAINT_NAME