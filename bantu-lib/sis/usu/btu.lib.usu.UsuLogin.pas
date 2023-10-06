unit btu.lib.usu.UsuLogin;

interface

type
  IUsuLogin = interface(IInterface)
    ['{E586E972-544E-41C9-9232-CB492B58084B}']
    function GetId: LongInt;
    procedure SetId(const Value: LongInt);
    property Id: LongInt read GetId write SetId;

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
