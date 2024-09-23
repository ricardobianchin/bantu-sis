unit Sis.Usuario;

interface

uses Sis.Lists.IdLojaTermItem;

type
  IUsuario = interface(IIdLojaTermItem)
    ['{E586E972-544E-41C9-9232-CB492B58084B}']

    function GetNomeCompleto: string;
    procedure SetNomeCompleto(const Value: string);
    property NomeCompleto: string read GetNomeCompleto write SetNomeCompleto;

    function GetNomeExib: string;
    procedure SetNomeExib(const Value: string);
    property NomeExib: string read GetNomeExib write SetNomeExib;

    function GetNomeDeUsuario: string;
    procedure SetNomeDeUsuario(const Value: string);
    property NomeDeUsuario: string read GetNomeDeUsuario write SetNomeDeUsuario;

    function GetSenha: string;
    procedure SetSenha(const Value: string);
    property Senha: string read GetSenha write SetSenha;

    function GetCryVer: smallint;
    procedure SetCryVer(const Value: smallint);
    property CryVer: smallint read GetCryVer write SetCryVer;
  end;

implementation

end.
