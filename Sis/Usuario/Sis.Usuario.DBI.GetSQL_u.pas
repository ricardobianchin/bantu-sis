unit Sis.Usuario.DBI.GetSQL_u;

interface

uses Sis.ModuloSistema.Types;


function GetSQLUsuarioPeloNomeUsu(pNomeUsu: string): string;
function GetSQLUsuarioAcessaModuloSistema(pLojaId, pPessoaId: integer;
  pTipoModuloSistema: TTipoModuloSistema): string;

implementation

uses System.SysUtils;

function GetSQLUsuarioAcessaModuloSistema(pLojaId, pPessoaId: integer;
  pTipoModuloSistema: TTipoModuloSistema): string;
var
  sFormato: string;
  cTipoModuloSistema: char;
begin
  cTipoModuloSistema := TipoModuloSistemaToChar(pTipoModuloSistema);
  sFormato := 'SELECT ACESSA FROM USUARIO_PA.USUARIO_ACESSA_MODULO_GET'
    + '(%d, %d,''%s'');'
    ;
  Result := Format(sFormato, [pLojaId, pPessoaId, cTipoModuloSistema]);
end;


function GetSQLUsuarioPeloNomeUsu(pNomeUsu: string): string;
var
  sFormato: string;
begin
  sFormato := 'SELECT LOJA_ID, PESSOA_ID, NOME, APELIDO, CRY_VER, SENHA' +
    ' FROM USUARIO_PA.BY_NOME_USU(''%s'');';
  Result := Format(sFormato, [pNomeUsu]);
end;

end.
