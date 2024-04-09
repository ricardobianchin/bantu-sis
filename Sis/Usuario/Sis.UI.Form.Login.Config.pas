unit Sis.UI.Form.Login.Config;

interface

uses Sis.ModuloSistema.Types, Sis.Config.ConfigXMLI;

type
  ILoginConfig = interface(IConfigXMLI)
    ['{1EFB09EA-5B92-449E-9C26-9ECCA3FB5E8F}']
    function GetPreencheLogin: boolean;
    procedure SetPreencheLogin(Value: boolean);
    property PreencheLogin: boolean read GetPreencheLogin write SetPreencheLogin;

    function GetTipoModuloSistema: TTipoModuloSistema;
    procedure SetTipoModuloSistema(Value: TTipoModuloSistema);
    property TipoModuloSistema: TTipoModuloSistema read GetTipoModuloSistema write SetTipoModuloSistema;

    function GetNomeUsu: string;
    procedure SetNomeUsu(Value: string);
    property NomeUsu: string read GetNomeUsu write SetNomeUsu;

    function GetSenha: string;
    procedure SetSenha(Value: string);
    property Senha: string read GetSenha write SetSenha;

    function GetExecuteOk: boolean;
    procedure SetExecuteOk(Value: boolean);
    property ExecuteOk: boolean read GetExecuteOk write SetExecuteOk;
  end;

implementation

end.
