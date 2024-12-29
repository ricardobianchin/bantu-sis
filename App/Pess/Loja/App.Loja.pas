unit App.Loja;

interface

uses Sis.Loja, App.PessEnder;

type
  IAppLoja = interface(ISisLoja)
    ['{359DA0AA-3964-4409-BCA0-EE729D169B32}']
    function GetApelido: string;
    procedure SetApelido(const Value: string);
    property Apelido: string read GetApelido write SetApelido;

    function GetNome: string;
    procedure SetNome(Value: string);
    property Nome: string read GetNome write SetNome;

    function GetNomeFantasia: string;
    procedure SetNomeFantasia(Value: string);
    property NomeFantasia: string read GetNomeFantasia write SetNomeFantasia;

    function GetC: string;
    procedure SetC(const Value: string);
    property C: string read GetC write SetC;

    function GetI: string;
    procedure SetI(const Value: string);
    property I: string read GetI write SetI;

    function GetM: string;
    procedure SetM(const Value: string);
    property M: string read GetM write SetM;

    function GetMUF: string;
    procedure SetMUF(const Value: string);
    property MUF: string read GetMUF write SetMUF;

    function GetEMail: string;
    procedure SetEMail(const Value: string);
    property EMail: string read GetEMail write SetEMail;

    function GetEnder: IPessEnder;
    property Ender: IPessEnder read GetEnder;
  end;

implementation

end.
