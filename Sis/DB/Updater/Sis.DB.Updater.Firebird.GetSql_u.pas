unit Sis.DB.Updater.Firebird.GetSql_u;

interface

//function GetSQLTabelaExiste(pNomeTabela: string): string;
//function GetSQLProcedureExiste(pNomeProcedure: string): string;

function GetSQLTabelaExisteParams: string;
function GetSQLIndexNamesParams: string;
function GetSQLProcedureExisteParams: string;

function GetSQLDomainExisteParams: string;
function GetSQLDomainExiste(pDomainName: string): string;

function GetSQLSequenceExisteParams: string;
function GetSQLForeignKeyInfoParams: string;
function GetSQLUniqueKeyInfoParams: string;

function GetSQLPackagGetCodigoParams: string;

function GetSQLHistInsParams: string;
function GetSQLVersaoGet: string;

function GetSQLCreateDatabase(pNomeArqFDB: string): string;

implementation

uses System.SysUtils, System.StrUtils, Sis.DB.Firebird.GetSQL_u,
  Sis.Win.Utils_u;

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


function GetSQLDomainExiste(pDomainName: string): string;
var
  sSql: string;
begin
  sSql := 'SELECT RDB$FIELD_NAME FROM RDB$FIELDS'
    + ' WHERE TRIM(RDB$FIELD_NAME) = ' + QuotedStr(pDomainName);
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

function GetSQLSequenceExisteParams: string;
var
  sSql: string;
begin
  sSql := 'SELECT RDB$GENERATOR_NAME'
    +' FROM RDB$GENERATORS WHERE RDB$GENERATOR_NAME = :SEQUENCE_NAME'
    ;

  sSql := GetSQLExists(sSql);
  Result := sSql;
end;


function GetSQLForeignKeyInfoParams: string;
var
  sSql: string;
begin
  sSql := 'SELECT RC.RDB$RELATION_NAME, RF.RDB$FIELD_NAME,'
    + ' RI.RDB$RELATION_NAME, ISGMT.RDB$FIELD_NAME'

    + ' FROM RDB$RELATION_CONSTRAINTS RC'

    + ' JOIN RDB$REF_CONSTRAINTS RR ON'
    + ' RC.RDB$CONSTRAINT_NAME = RR.RDB$CONSTRAINT_NAME'

    + ' JOIN RDB$RELATION_CONSTRAINTS RI ON'
    + ' RI.RDB$CONSTRAINT_NAME = RR.RDB$CONST_NAME_UQ'

    + ' JOIN RDB$INDEX_SEGMENTS RF ON'
    + ' RF.RDB$INDEX_NAME = RC.RDB$INDEX_NAME'

    + ' JOIN RDB$INDEX_SEGMENTS ISGMT ON'
    + ' ISGMT.RDB$INDEX_NAME = RI.RDB$INDEX_NAME'

    + ' WHERE RC.RDB$CONSTRAINT_TYPE = ''FOREIGN KEY'''
    + ' AND RC.RDB$CONSTRAINT_NAME = :FOREIGN_KEY_NAME'

    + ' AND RF.RDB$FIELD_NAME = ISGMT.RDB$FIELD_NAME'

    ;
  Result := sSql;
end;

function GetSQLUniqueKeyInfoParams: string;
var
  sSql: string;
begin
  sSql := 'SELECT RDB$FIELD_NAME'
    + ' FROM RDB$INDICES'
    + ' JOIN RDB$INDEX_SEGMENTS ON'
    + ' RDB$INDICES.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME'
    + ' WHERE RDB$INDICES.RDB$UNIQUE_FLAG = 1'
    + ' AND RDB$INDICES.RDB$INDEX_NAME = :UNIQUE_KEY_NAME'
    + ' ORDER BY RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION'
    ;
  Result := sSql;
end;


function GetSQLCreateDatabase(pNomeArqFDB: string): string;
begin
  Result := 'CREATE DATABASE ''' +
    pNomeArqFDB +
    ''' page_size 8192 user ''' +
    'sysdba'' password ''masterkey'';'
    ;

end;

end.
