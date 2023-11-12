unit btu.sis.db.updater.utils;

interface

uses btu.lib.db.types;

//function GetSQLExists(pSQL: string): string;

//function TabelaExiste(pDBConnection: IDBConnection; pNomeTab: string): boolean;
//function GetIndexFieldNames(pDBConnection: IDBConnection; pNomeIndice:string):string;
//function ProcedureExiste(pDBConnection: IDBConnection; pNomeProcedure: string): boolean;

implementation

uses btu.lib.db.updater.firebird.GetSql_u, Data.DB, System.StrUtils, System.SysUtils;
{
function GetSQLExists(pSQL: string): string;
begin
  result := 'select 1 from rdb$database where exists ('
    +pSql
    +');'
end;
 }
{
function TabelaExiste(pDBConnection: IDBConnection; pNomeTab: string): boolean;
var
  sSqlBuscaName, sSqlTeste: string;
  Resultado: Variant;
begin
  sSqlBuscaName := GetSQLTabelaExiste(pNomeTab);
  sSqlTeste := GetSQLExists(sSqlBuscaName);
  Resultado := pDBConnection.GetValue(sSqlTeste);
  Result := 1 = Resultado;
end;

function GetIndexFieldNames(pDBConnection: IDBConnection; pNomeIndice:string):string;
var
  s:string;
  Q:TDataSet;
begin
  result:='';
  s:='select RDB$FIELD_NAME from RDB$INDEX_SEGMENTS'
    +' where rdb$index_name='+QuotedStr(uppercase(trim(pNomeIndice)))
    +' ORDER BY RDB$FIELD_POSITION'
    ;
  pDBConnection.QueryDataSet(s, q);
  if q = nil then
    exit;
  try
    while not Q.Eof do
    begin
      if result <> '' then
        result := result + ', ';
      result := result + ansiuppercase(trim(Q.Fields[0].AsString));
      Q.Next;
    end;
  finally
    Q.Free
  end;
end;
}
{
function ProcedureExiste(pDBConnection: IDBConnection; pNomeProcedure: string): boolean;
var
  sSqlBuscaName, sSqlTeste: string;
  Resultado: Variant;
begin
  sSqlBuscaName := GetSQLProcedureExiste(pNomeProcedure);
  sSqlTeste := GetSQLExists(sSqlBuscaName);
  Resultado := pDBConnection.GetValue(sSqlTeste);
  Result := 1 = Resultado;
end;
}
end.
