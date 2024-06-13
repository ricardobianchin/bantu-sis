unit App.Pess.Ent;

interface

uses App.Ent.Ed.Id, App.PessEnder.List, App.Pess.Types;

type
  IPessEnt = interface(IEntEdId)
    ['{28F14DDF-1FED-4A58-9BE0-B71F8669261A}']
    function GetTerminalId: smallint;
    procedure SetTerminalId(const Value: smallint);
    property TerminalId: smallint read GetTerminalId write SetTerminalId;

    function GetLojaId: smallint;
    procedure SetLojaId(const Value: smallint);
    property LojaId: smallint read GetLojaId write SetLojaId;

    function GetNome: string;
    procedure SetNome(const Value: string);
    property Nome: string read GetNome write SetNome;

    function GetNomeFantasia: string;
    procedure SetNomeFantasia(const Value: string);
    property NomeFantasia: string read GetNomeFantasia write SetNomeFantasia;

    function GetApelido: string;
    procedure SetApelido(const Value: string);
    property Apelido: string read GetApelido write SetApelido;

    function GetEstadoCivil: char;
    procedure SetEstadoCivil(const Value: char);
    property EstadoCivil: char read GetEstadoCivil write SetEstadoCivil;

    function GetGenero: char;
    procedure SetGenero(const Value: char);
    property Genero: char read GetGenero write SetGenero;

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

    function GetDtNasc: TDateTime;
    procedure SetDtNasc(const Value: TDateTime);
    property DtNasc: TDateTime read GetDtNasc write SetDtNasc;

    function GetCriadoEm: TDateTime;
    procedure SetCriadoEm(const Value: TDateTime);
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;

    function GetAlteradoEm: TDateTime;
    procedure SetAlteradoEm(const Value: TDateTime);
    property AlteradoEm: TDateTime read GetAlteradoEm write SetAlteradoEm;

    function GetPessEnderList: IPessEnderList;
    property PessEnderList: IPessEnderList read GetPessEnderList;

    function GetEnderQuantidadePermitida: TEnderQuantidadePermitida;
    property EnderQuantidadePermitida: TEnderQuantidadePermitida read GetEnderQuantidadePermitida;
  end;

implementation

end.
