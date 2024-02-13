unit Sis.Usuario.Factory;

interface

uses Sis.Usuario, Sis.Usuario.DBI, Sis.UI.Form.Login.Config,
  Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output
  ;

function UsuarioCreate(pLojaId: integer = 0; pTerminalId: integer = 0;
  pId: integer = 0; pNomeCompleto: string = ''; pNomeExib: string = '';
  pNomeUsu: string = ''; pSenha: string = ''): IUsuario;

function UsuarioDBICreate(pDBConnection: IDBConnection; pUsuario: IUsuario)
  : IUsuarioDBI;

function LoginConfigCreate(pProcessLog: IProcessLog; pOutput: IOutput)
  : ILoginConfig;

implementation

uses Sis.Usuario_u, Sis.Usuario.DBI_u, Sis.UI.Form.Login.Config_u;

function UsuarioCreate(pLojaId: integer = 0; pTerminalId: integer = 0;
  pId: integer = 0; pNomeCompleto: string = ''; pNomeExib: string = '';
  pNomeUsu: string = ''; pSenha: string = ''): IUsuario;
begin
  Result := TUsuario.Create(pLojaId, pTerminalId, pId, pNomeCompleto, pNomeExib,
    pNomeUsu, pSenha);
end;

function UsuarioDBICreate(pDBConnection: IDBConnection; pUsuario: IUsuario)
  : IUsuarioDBI;
begin
  Result := TUsuarioDBI.Create(pDBConnection, pUsuario);
end;

function LoginConfigCreate(pProcessLog: IProcessLog; pOutput: IOutput)
  : ILoginConfig;
begin
  Result := TLoginConfig.Create(pProcessLog, pOutput);
end;

end.
