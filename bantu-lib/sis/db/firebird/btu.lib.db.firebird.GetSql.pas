unit btu.lib.db.firebird.GetSql;

interface

function GetSQLExists(pSQL: string): string;

implementation

function GetSQLExists(pSQL: string): string;
begin
  Result := 'SELECT 1 FROM RDB$DATABASE WHERE EXISTS ('
    +pSql
    +');'
end;

end.
