SELECT COLS.TABLE_NAME, COLS.COLUMN_NAME, COLS.POSITION, CONS.STATUS, CONS.OWNER
FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
WHERE 
--COLS.TABLE_NAME = 'TABLE_NAME' AND
CONS.CONSTRAINT_TYPE = 'P'
AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
AND CONS.OWNER = COLS.OWNER
ORDER BY COLS.TABLE_NAME, COLS.POSITION;