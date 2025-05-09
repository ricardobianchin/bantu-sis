unit Sis.Usuario.Senha_u;

interface

uses Sis.DB.DBTypes;

function GravarSenha(pNovaSenha: string; pCryVer: integer; pLojaId: smallint;
  pUsuarioPessoaId, pLogPessoaId: integer; pMachineId: smallint; pDBConnection: IDBConnection;
  out pMens: string): Boolean;

implementation

uses System.SysUtils;

function GravarSenha(pNovaSenha: string; pCryVer: integer; pLojaId: smallint;
  pUsuarioPessoaId, pLogPessoaId: integer; pMachineId: smallint; pDBConnection: IDBConnection;
  out pMens: string): Boolean;
var
  sComandoSql: string;
begin
  Result := False;

  sComandoSql := 'EXECUTE PROCEDURE USUARIO_PA.SENHA_SET(' //
    + pLojaId.ToString //
    + ', ' + pUsuarioPessoaId.ToString //
    + ', ' + pLogPessoaId.ToString //
    + ', ' + pMachineId.ToString //

    + ', ' + QuotedStr(pNovaSenha) //
    + ', ' + pCryVer.ToString //
    + ');'; //

  Result := pDBConnection.Abrir;
  if not Result then
  begin
    pMens := 'Erro abrindo o banco ao tentar gravar a senha';
    exit;
  end;

  try
    try
      pDBConnection.ExecuteSQL(sComandoSql);
    except
      on E: exception do
      begin
        pMens := E.ClassName + ' ' + E.Message;
        Result := True;
      end;
    end;
  finally
    pDBConnection.Fechar;
  end;
end;

end.
