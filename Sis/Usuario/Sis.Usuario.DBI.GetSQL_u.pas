unit Sis.Usuario.DBI.GetSQL_u;

interface

function GetSQLUsuarioPeloNomeUsu(pNomeUsu: string): string;

implementation

uses System.SysUtils;

function GetSQLUsuarioPeloNomeUsu(pNomeUsu: string): string;
var
  sFormato: string;
begin
  sFormato := 'SELECT LOJA_ID, PESSOA_ID, APELIDO, CRY_VER, SENHA'
    + ' FROM USUARIO_PA.TENTE_LOGIN(''%s'');';
  Result := Format(sFormato, [pNomeUsu]);
end;

end.
