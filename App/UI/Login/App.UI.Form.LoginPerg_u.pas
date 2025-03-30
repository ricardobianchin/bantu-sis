unit App.UI.Form.LoginPerg_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Sis.ModuloSistema.Types,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Sis.Usuario.DBI,
  Sis.UI.Form.Login.Config;

type
  TLoginPergForm = class(TDiagBtnBasForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginPergForm: TLoginPergForm;

function LoginPerg(//pLoginConfig: ILoginConfig;
  pTipoOpcaoSisModulo: TOpcaoSisIdModulo; out UsuarioLojaId: SmallInt;
  out UsuarioTerminalId: SmallInt; out UsuarioPessoaId: integer;
  out UsuarioNomeCompleto: string; out UsuarioNomeDeUsuario: string;
  out UsuarioNomeExib: string; //pUsuarioDBI: IUsuarioDBI;
  pTestaAcessaModuloSistema: boolean; pLogo1NomeArq: string): boolean;

implementation

{$R *.dfm}
                              trazer variaveis de login config
                              devolver variaveis de usuario

function LoginPerg( //pLoginConfig: ILoginConfig;
  pTipoOpcaoSisModulo: TOpcaoSisIdModulo; out UsuarioLojaId: SmallInt;
  out UsuarioTerminalId: SmallInt; out UsuarioPessoaId: integer;
  out UsuarioNomeCompleto: string; out UsuarioNomeDeUsuario: string;
  out UsuarioNomeExib: string; //pUsuarioDBI: IUsuarioDBI;
  pTestaAcessaModuloSistema: boolean; pLogo1NomeArq: string): boolean;
var
  Resultado: TModalResult;
begin
  LoginPergForm := TLoginPergForm.Create
    (nil { pLoginConfig{, pTipoOpcaoSisModulo,
      pUsuario, pUsuarioDBI, pTestaAcessaModuloSistema, pLogo1NomeArq } );
  try
    // testando aqui loginpreg
    Resultado := mrok; // LoginPergForm.ShowModal;
    Result := IsPositiveResult(Resultado);
    // pUsuario.Pegar(1, 0, 1);
    // pUsuario.NomeCompleto := 'ANDERSON ARAGAO';
    // pUsuario.NomeDeUsuario := 'ANDERSON';
    // pUsuario.NomeExib := 'ANDERSON';
  finally
    LoginPergForm.Free;
  end;
end;

end.
