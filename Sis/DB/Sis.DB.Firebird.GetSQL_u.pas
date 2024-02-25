unit Sis.DB.Firebird.GetSQL_u;

interface

function GetSQLExists(pSQL: string): string;
function GetSQLUniqueKey(pNomeTabela, pCampos: string): string;
function GetSQLDropUniqueKey(pNomeTabela, pKeyName: string): string;
function CamposToUKName(pNomeTabela, pCampos: string): string;

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
  sNome := CamposToUKName(pNomeTabela, pCampos);

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

function CamposToUKName(pNomeTabela,pCampos: string): string;
begin
  Result := StrSemStr(pCampos, ' ');
  Result := StrToName(Result);
  Result := pNomeTabela +'_'+ Result + UKINDEXNAME_SUFIXO;

  Result := TruncSnakeCase(Result, FB_MAX_IDENTIFIER_LENGHT);
end;

end.
