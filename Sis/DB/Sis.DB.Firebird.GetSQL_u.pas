unit Sis.DB.Firebird.GetSQL_u;

interface

function GetSQLExists(pSQL: string): string;

function GetSQLUniqueKey(pNomeTabela, pCampos: string): string;
function GetSQLDropUniqueKey(pNomeTabela, pKeyName: string): string;
function CamposToKeyName(pNomeTabela, pCampos, pSufixo: string): string;

function GetSQLIndex(pNomeTabela, pCampos: string): string;
function GetSQLDropIndex(pKeyName: string): string;

implementation

uses Sis.Types.strings_u, Sis.DB.Updater.Constants_u, System.SysUtils;

function GetSQLExists(pSQL: string): string;
begin
  Result := 'SELECT 1 FROM RDB$DATABASE WHERE EXISTS ('
    +pSql
    +');'
end;

function GetSQLUniqueKey(pNomeTabela, pCampos: string): string;
var
  sNome: string;
  sFormat: string;
begin
  sNome := CamposToKeyName(pNomeTabela, pCampos, UKINDEXNAME_SUFIXO);

  sFormat := 'ALTER TABLE %s ADD CONSTRAINT %s UNIQUE (%s);';

  Result := Format(sFormat, [pNomeTabela, sNome, pCampos]);
end;

function GetSQLDropUniqueKey(pNomeTabela, pKeyName: string): string;
var
  sFormat: string;
begin
  sFormat := 'ALTER TABLE %s DROP CONSTRAINT %s;';

  Result := Format(sFormat, [pNomeTabela, pKeyName]);
end;

function GetSQLIndex(pNomeTabela, pCampos: string): string;
var
  sNome: string;
  sFormat: string;
begin
  sNome := CamposToKeyName(pNomeTabela, pCampos, INDEXNAME_SUFIXO);

  sFormat := 'CREATE INDEX %s ON %s (%s);';

  Result := Format(sFormat, [sNome, pNomeTabela, pCampos]);
end;

function GetSQLDropIndex(pKeyName: string): string;
var
  sFormat: string;
begin
  sFormat := 'DROP INDEX %s;';

  Result := Format(sFormat, [pKeyName]);
end;

function CamposToKeyName(pNomeTabela,pCampos, pSufixo: string): string;
begin
  Result := StrSemStr(pCampos, ' ');
  Result := StrToName(Result);
  Result := pNomeTabela +'_'+ Result + pSufixo;

  Result := TruncSnakeCase(Result, FB_MAX_IDENTIFIER_LENGHT);
end;

end.
