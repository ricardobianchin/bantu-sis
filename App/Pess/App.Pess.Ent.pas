unit App.Pess.Ent;

interface

uses App.Ent.Ed.Id, App.PessEnder.List, App.Pess.Utils;

type
  IPessEnt = interface(IEntEdId)
    ['{28F14DDF-1FED-4A58-9BE0-B71F8669261A}']

    function GetUsuarioId: integer;
    property UsuarioId: integer read GetUsuarioId;

    function GetMachineIdentId: smallint;
    property MachineIdentId: smallint read GetMachineIdentId;

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

    function GetGeneroId: char;
    procedure SetGeneroId(const Value: char);
    property GeneroId: char read GetGeneroId write SetGeneroId;

    function GetGeneroDescr: string;
    procedure SetGeneroDescr(const Value: string);
    property GeneroDescr: string read GetGeneroDescr write SetGeneroDescr;

    function GetEstadoCivilId: char;
    procedure SetEstadoCivilId(const Value: char);
    property EstadoCivilId: char read GetEstadoCivilId write SetEstadoCivilId;

    function GetEstadoCivilDescr: string;
    procedure SetEstadoCivilDescr(const Value: string);
    property EstadoCivilDescr: string read GetEstadoCivilDescr write SetEstadoCivilDescr;

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

    function GetAtivo: boolean;
    procedure SetAtivo(const Value: boolean);
    property Ativo: boolean read GetAtivo write SetAtivo;

    function GetCriadoEm: TDateTime;
    procedure SetCriadoEm(const Value: TDateTime);
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;

    function GetAlteradoEm: TDateTime;
    procedure SetAlteradoEm(const Value: TDateTime);
    property AlteradoEm: TDateTime read GetAlteradoEm write SetAlteradoEm;

    function GetPessEnderList: IPessEnderList;
    property PessEnderList: IPessEnderList read GetPessEnderList;

    function GetPessTipoAceito: TPessTipoAceito;
    property PessTipoAceito: TPessTipoAceito read GetPessTipoAceito;

    function GetEnderQuantidadePermitida: TEnderQuantidadePermitida;
    property EnderQuantidadePermitida: TEnderQuantidadePermitida read GetEnderQuantidadePermitida;

    function GetCodUsaTerminalId: boolean;
    property CodUsaTerminalId: boolean read GetCodUsaTerminalId;

    function GetCObrigatorio: boolean;
    property CObrigatorio: boolean read GetCObrigatorio;

    function GetCodAsString: string;
    property CodAsString: string read GetCodAsString;
  end;

implementation

end.
