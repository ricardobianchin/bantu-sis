unit App.Pess.Funcionario.Ent;

interface

uses App.Pess.Ent;

type
  IPessFuncionarioEnt = interface(IPessEnt)
    ['{86C91731-4F42-4863-87A2-63C8527F2D25}']

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
