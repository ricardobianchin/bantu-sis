unit Sis.DB.Firebird.GetSQL_u;

interface

function GetSQLExists(pSQL: string): string;
function GetSQLUniqueKey(pNomeTabela, pNomeCampos: string): string;

implementation

uses Sis.Types.strings_u, Sis.DB.Updater.Constants_u, System.SysUtils;

function GetSQLExists(pSQL: string): string;
begin
  Result := 'SELECT 1 FROM RDB$DATABASE WHERE EXISTS ('
    +pSql
    +');'
end;

function GetSQLUniqueKey(pNomeTabela, pNomeCampos: string): string;
var
  sNome: string;
  sFormat: string;
begin
  sNome := pNomeTabela+'_'+pNomeCampos+'_UN';
  sNome := TruncSnakeCase(sNome, FB_MAX_IDENTIFIER_LENGHT);
  sFormat := 'ALTER TABLE %s ADD CONSTRAINT %s UNIQUE (%s);';
//ALTER TABLE usuario
//ADD CONSTRAINT nome_usu_unique UNIQUE (nome_usu); -- cria uma chave única para o campo nome_usu

  Result := Format(sFormat, [pNomeTabela, sNome, pNomeCampos]);
end;

end.
