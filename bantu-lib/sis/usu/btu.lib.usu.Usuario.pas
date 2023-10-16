unit btu.lib.usu.Usuario;

interface

uses btu.lib.lists.LojaTermIdItem;

type
  IUsuario = interface(ILojaTermIdItem)
    ['{E586E972-544E-41C9-9232-CB492B58084B}']

    function GetNomeExib: string;
    procedure SetNomeExib(const Value: string);
    property NomeExib: string read GetNomeExib write SetNomeExib;

    function GetNomeUsu: string;
    procedure SetNomeUsu(const Value: string);
    property NomeUsu: string read GetNomeUsu write SetNomeUsu;

    function GetSenha: string;
    procedure SetSenha(const Value: string);
    property Senha: string read GetSenha write SetSenha;
  end;

implementation

end.
