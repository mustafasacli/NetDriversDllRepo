SELECT OWNER, NAME, COUNT(*) AS SATIRSAYISI-- TEXT 
  FROM ALL_SOURCE
  WHERE OWNER LIKE 'ISKUR'--NOT LIKE '%SYS%'
  GROUP BY NAME, OWNER
  ORDER BY NAME;