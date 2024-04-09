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
function GetSQLIndexInfoParams: string;


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
  sSql := 'SELECT '#13#10 +
    's.RDB$RELATION_NAME AS PK_TABLE_NAME, '#13#10 +
    'r.RDB$RELATION_NAME AS FK_TABLE_NAME, '#13#10 +

    #13#10 +

    '('#13#10+
    '  SELECT LIST(TRIM(i2.RDB$FIELD_NAME))'#13#10 +
//    '  SELECT TRIM(LIST('' '' ||TRIM( i2.RDB$FIELD_NAME)))'#13#10 +
    '  FROM RDB$INDEX_SEGMENTS i2'#13#10 +
    '  WHERE i2.RDB$INDEX_NAME = ref.RDB$CONST_NAME_UQ'#13#10 +
    ') AS PK_COLUMNS,'#13#10 +

    #13#10 +

    '('#13#10 +
    '  SELECT LIST(TRIM(i2.RDB$FIELD_NAME))'#13#10 +
//    '  SELECT TRIM(LIST('' '' ||TRIM(i2.RDB$FIELD_NAME)))'#13#10 +
    '  FROM RDB$INDEX_SEGMENTS i2'#13#10 +
    '  WHERE i2.RDB$INDEX_NAME = r.RDB$INDEX_NAME'#13#10 +
    ') AS FK_COLUMNS'#13#10 +

    #13#10 +

    'FROM RDB$RELATION_CONSTRAINTS r'#13#10 +
    'JOIN RDB$REF_CONSTRAINTS ref ON'#13#10 +
     'r.RDB$CONSTRAINT_NAME = ref.RDB$CONSTRAINT_NAME'#13#10 +

    'JOIN RDB$RELATION_CONSTRAINTS s ON'#13#10 +
    's.RDB$CONSTRAINT_NAME = ref.RDB$CONST_NAME_UQ'#13#10 +

    'WHERE r.RDB$CONSTRAINT_TYPE = ''FOREIGN KEY'''#13#10 +
    'AND r.RDB$CONSTRAINT_NAME = :CONSTRAINT_NAME'#13#10
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

function GetSQLIndexInfoParams: string;
var
  sSql: string;
begin
  sSql := 'SELECT RDB$FIELD_NAME'
    + ' FROM RDB$INDICES'
    + ' JOIN RDB$INDEX_SEGMENTS ON'
    + ' RDB$INDICES.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME'
    + ' WHERE RDB$INDICES.RDB$INDEX_NAME = :INDEX_NAME'
    + ' ORDER BY RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION'
    ;
  Result := sSql;
end;

function GetSQLCreateDatabase(pNomeArqFDB: string): string;
begin
  Result := 'CREATE DATABASE ''' +
    pNomeArqFDB +
    ''' PAGE_SIZE 8192' +
    ' USER ''SYSDBA'' PASSWORD ''MASTERKEY'''+
    ' DEFAULT CHARACTER SET WIN1252'+
    ' COLLATION WIN_PTBR;'
    ;
end;

end.
