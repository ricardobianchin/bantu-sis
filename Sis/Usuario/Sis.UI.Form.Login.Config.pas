unit Sis.UI.Form.Login.Config;

interface

uses Sis.ModuloSistema.Types, Sis.Config.ConfigXMLI;

type
  ILoginConfig = interface(IConfigXMLI)
    ['{1EFB09EA-5B92-449E-9C26-9ECCA3FB5E8F}']
    function GetPreencheLogin: boolean;
    procedure SetPreencheLogin(Value: boolean);
    property PreencheLogin: boolean read GetPreencheLogin write SetPreencheLogin;

    function GetTipoOpcaoSisModulo: TOpcaoSisIdModulo;
    procedure SetTipoOpcaoSisModulo(Value: TOpcaoSisIdModulo);
    property TipoOpcaoSisModulo: TOpcaoSisIdModulo read GetTipoOpcaoSisModulo write SetTipoOpcaoSisModulo;

    function GetNomeDeUsuario: string;
    procedure SetNomeDeUsuario(Value: string);
    property NomeDeUsuario: string read GetNomeDeUsuario write SetNomeDeUsuario;

    function GetSenhaAtual: string;
    procedure SetSenhaAtual(Value: string);
    property SenhaAtual: string read GetSenhaAtual write SetSenhaAtual;

    function GetExecuteOk: boolean;
    procedure SetExecuteOk(Value: boolean);
    property ExecuteOk: boolean read GetExecuteOk write SetExecuteOk;
  end;

implementation

end.
