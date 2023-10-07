unit btu.lib.db.updater.firebird.GetSql_u;

interface

uses btu.lib.db.firebird.GetSql;

//function GetSQLTabelaExiste(pNomeTabela: string): string;
//function GetSQLProcedureExiste(pNomeProcedure: string): string;

function GetSQLTabelaExisteParams: string;
function GetSQLIndexNamesParams: string;
function GetSQLProcedureExisteParams: string;
function GetSQLDomainExisteParams: string;

function GetSQLPackagGetCodigoParams: string;

function GetSQLHistInsParams: string;
function GetSQLVersaoGet: string;

implementation

uses System.SysUtils, System.StrUtils;

function GetSQLTabelaExiste(pNomeTabela: string): string;
var
  sSql: string;
begin
  pNomeTabela := UpperCase(pNomeTabela);

  sSql := 'select * from RDB$RELATIONS where RDB$RELATION_NAME=' +
    QuotedStr(pNomeTabela);
  Result := sSql;
end;

function GetSQLTabelaExisteParams: string;
var
  sSql: string;
begin
  sSql := 'SELECT RDB$RELATION_NAME FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = :TABELA_NOME';
  sSql := GetSQLExists(sSql);
  Result := sSql;
end;

function GetSQLIndexNamesParams: string;
begin
  Result := 'select RDB$FIELD_NAME from RDB$INDEX_SEGMENTS'
    +' where rdb$index_name=:INDEX_NAME'
    +' ORDER BY RDB$FIELD_POSITION'
    ;
end;

function GetSQLProcedureExiste(pNomeProcedure: string): string;
var
  sSql: string;
begin
  pNomeProcedure := UpperCase(pNomeProcedure);

  sSql := 'select * from rdb$procedures'
    + ' where upper(rdb$procedure_name) ='
    + ' upper(' + pNomeProcedure.QuotedString + ')'
    ;

  Result := sSql;
end;

function GetSQLVersaoGet: string;
begin
  Result := 'SELECT DBUPDATE_PA.VERSAO_GET() AS DBVERSAO FROM RDB$DATABASE;';
end;

function GetSQLHistInsParams: string;
begin
  Result := 'EXECUTE PROCEDURE DBUPDATE_PA.HIST_INS(:NUM, :ASSUNTO, :OBJETIVO, :OBS);';
end;

{
function GetSQLPackagExisteParams: string;
var
  sSql: string;
begin
  sSql := 'SELECT RDB$PACKAGE_NAME'
    + ' FROM RDB$PACKAGES'
    + ' WHERE RDB$PACKAGE_NAME = :PACKAGE_NAME';

  sSql := GetSQLExists(sSql);

  Result := sSql;
end;
}

function GetSQLPackagGetCodigoParams: string;
var
  sSql: string;
begin
  sSql := 'SELECT RDB$PACKAGE_HEADER_SOURCE, RDB$PACKAGE_BODY_SOURCE'
    + ' from RDB$PACKAGES'
    + ' WHERE RDB$PACKAGE_NAME = :PACKAGE_NAME'
    ;

  Result := sSql;
end;

function GetSQLProcedureExisteParams: string;
var
  sSql: string;
begin
  sSql := 'SELECT RDB$PROCEDURE_NAME FROM RDB$PROCEDURES'
    + ' WHERE RDB$PROCEDURE_NAME = :PROCEDURE_NOME';
  sSql := GetSQLExists(sSql);
  Result := sSql;
end;

function GetSQLDomainExisteParams: string;
var
  sSql: string;
begin
  sSql := 'SELECT RDB$FIELD_NAME FROM RDB$FIELDS'
    + ' WHERE RDB$FIELD_NAME = :DOMAIN_NAME';
  sSql := GetSQLExists(sSql);
  Result := sSql;
end;

end.
