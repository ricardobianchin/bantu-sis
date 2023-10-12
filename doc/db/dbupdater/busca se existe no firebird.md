# selects usados para descobrir se algum objeto existe no banco de dados firebird

## domains

### buscar se um domain existe

SELECT CASE WHEN EXISTS (SELECT 1 FROM RDB$FIELDS WHERE RDB$FIELD_NAME = ‘ID_DOM’) THEN 1 ELSE 0 END FROM RDB$DATABASE;


SELECT RDB$FIELD_NAME FROM RDB$FIELDS WHERE RDB$FIELD_NAME = 'ID_DOM';

) 

HEN 1 ELSE 0 END FROM RDB$DATABASE;

