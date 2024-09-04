unit App.Pess.Ent_u;

interface

uses App.Pess.Ent, App.Ent.Ed.Id, App.Ent.Ed.Id_u, Data.DB, App.PessEnder.List,
  Sis.Types, App.Pess.Utils;

type
  TPessEnt = class(TEntEdId, IPessEnt)
  private
    FTerminalId: smallint;
    FLojaId: smallint;
    FNome: string;
    FNomeFantasia: string;
    FApelido: string;
    FGeneroId: char;
    FGeneroDescr: string;
    FEstadoCivilId: char;
    FEstadoCivilDescr: string;
    FC: string;
    FI: string;
    FM: string;
    FMUF: string;
    FEMail: string;
    FDtNasc: TDateTime;
    FAtivo: boolean;

    FCriadoEm: TDateTime;
    FAlteradoEm: TDateTime;

    FPessEnderList: IPessEnderList;
    //FEnderQuantidadePermitida: TEnderQuantidadePermitida;
    //FCodUsaTerminalId: boolean;

    //FCObrigatorio: boolean;

    function GetTerminalId: smallint;
    procedure SetTerminalId(const Value: smallint);

    function GetLojaId: smallint;
    procedure SetLojaId(const Value: smallint);

    function GetNome: string;
    procedure SetNome(const Value: string);

    function GetNomeFantasia: string;
    procedure SetNomeFantasia(const Value: string);

    function GetApelido: string;
    procedure SetApelido(const Value: string);

    function GetGeneroId: char;
    procedure SetGeneroId(const Value: char);

    function GetGeneroDescr: string;
    procedure SetGeneroDescr(const Value: string);

    function GetEstadoCivilId: char;
    procedure SetEstadoCivilId(const Value: char);

    function GetEstadoCivilDescr: string;
    procedure SetEstadoCivilDescr(const Value: string);

    function GetC: string;
    procedure SetC(const Value: string);

    function GetI: string;
    procedure SetI(const Value: string);

    function GetM: string;
    procedure SetM(const Value: string);

    function GetMUF: string;
    procedure SetMUF(const Value: string);

    function GetEMail: string;
    procedure SetEMail(const Value: string);

    function GetDtNasc: TDateTime;
    procedure SetDtNasc(const Value: TDateTime);

    function GetAtivo: boolean;
    procedure SetAtivo(const Value: boolean);

    function GetCriadoEm: TDateTime;
    procedure SetCriadoEm(const Value: TDateTime);

    function GetAlteradoEm: TDateTime;
    procedure SetAlteradoEm(const Value: TDateTime);

    function GetPessEnderList: IPessEnderList;

    function GetCodAsString: string;
    procedure SetCObrigatorio(const Value: boolean);
  protected
    function GetCObrigatorio: boolean; virtual;
    function GetEnderQuantidadePermitida: TEnderQuantidadePermitida; virtual;
    function GetCodUsaTerminalId: boolean; virtual;
  public
    property TerminalId: smallint read GetTerminalId write SetTerminalId;
    property LojaId: smallint read GetLojaId write SetLojaId;
    property Nome: string read GetNome write SetNome;
    property NomeFantasia: string read GetNomeFantasia write SetNomeFantasia;
    property Apelido: string read GetApelido write SetApelido;

    property GeneroId: char read GetGeneroId write SetGeneroId;
    property GeneroDescr: string read GetGeneroDescr write SetGeneroDescr;

    property EstadoCivilId: char read GetEstadoCivilId write SetEstadoCivilId;
    property EstadoCivilDescr: string read GetEstadoCivilDescr write SetEstadoCivilDescr;

    property C: string read GetC write SetC;
    property I: string read GetI write SetI;
    property M: string read GetM write SetM;
    property MUF: string read GetMUF write SetMUF;
    property EMail: string read GetEMail write SetEMail;
    property DtNasc: TDateTime read GetDtNasc write SetDtNasc;
    property Ativo: boolean read GetAtivo write SetAtivo;
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;
    property AlteradoEm: TDateTime read GetAlteradoEm write SetAlteradoEm;

    property PessEnderList: IPessEnderList read GetPessEnderList;
    property EnderQuantidadePermitida: TEnderQuantidadePermitida
      read GetEnderQuantidadePermitida;
    property CodUsaTerminalId: boolean read GetCodUsaTerminalId;
    property CodAsString: string read GetCodAsString;

    property CObrigatorio: boolean read GetCObrigatorio write SetCObrigatorio;

    constructor Create(pPessEnderList: IPessEnderList);

    procedure LimparEnt; override;
  end;

implementation

uses System.SysUtils;

{ TPessEnt }

constructor TPessEnt.Create(pPessEnderList: IPessEnderList);
begin
  inherited Create(dsBrowse, 0);
  FPessEnderList := pPessEnderList;
  LimparEnt;
end;

function TPessEnt.GetApelido: string;
begin
  Result := FApelido;
end;

function TPessEnt.GetAtivo: boolean;
begin
  Result := FAtivo;
end;

function TPessEnt.GetC: string;
begin
  Result := FC;
end;

function TPessEnt.GetCObrigatorio: boolean;
begin
  Result := True;
end;

function TPessEnt.GetCodAsString: string;
begin
  Result := CodsToCodAsString(LojaId, TerminalId, Id, CodUsaTerminalId);
end;

function TPessEnt.GetCodUsaTerminalId: boolean;
begin
  Result := False;
end;

function TPessEnt.GetCriadoEm: TDateTime;
begin
  Result := FCriadoEm;
end;

function TPessEnt.GetDtNasc: TDateTime;
begin
  Result := FDtNasc;
end;

function TPessEnt.GetAlteradoEm: TDateTime;
begin
  Result := FAlteradoEm;
end;

function TPessEnt.GetEMail: string;
begin
  Result := FEMail;
end;

function TPessEnt.GetEnderQuantidadePermitida: TEnderQuantidadePermitida;
begin
  Result := TEnderQuantidadePermitida.endqtdUm;
end;

function TPessEnt.GetEstadoCivilDescr: string;
begin
  Result := FEstadoCivilDescr;
end;

function TPessEnt.GetEstadoCivilId: char;
begin
  Result := FEstadoCivilId;
end;

function TPessEnt.GetGeneroDescr: string;
begin
  Result := FGeneroDescr;
end;

function TPessEnt.GetGeneroId: char;
begin
  Result := FGeneroId;
end;

function TPessEnt.GetI: string;
begin
  Result := FI;
end;

function TPessEnt.GetLojaId: smallint;
begin
  Result := FLojaId;
end;

function TPessEnt.GetM: string;
begin
  Result := FM;
end;

function TPessEnt.GetMUF: string;
begin
  Result := FMUF;
end;

function TPessEnt.GetNome: string;
begin
  Result := FNome;
end;

function TPessEnt.GetNomeFantasia: string;
begin
  Result := FNomeFantasia;
end;

function TPessEnt.GetPessEnderList: IPessEnderList;
begin
  Result := FPessEnderList;
end;

function TPessEnt.GetTerminalId: smallint;
begin
  Result := FTerminalId;
end;

procedure TPessEnt.LimparEnt;
begin
  inherited;
  FTerminalId := 0; // : smallint;
  FLojaId := 0; // : smallint;
  FNome := ''; // : string;
  FNomeFantasia := ''; // : string;
  FApelido := ''; // : string;
  FEstadoCivilId := ' '; // : char;
  FEstadoCivilDescr := 'Nao Indicado'; // : char;
  FGeneroId := ' '; // : char;
  FGeneroDescr := 'Nao Indicado'; // : char;
  FC := ''; // : string;
  FI := ''; // : string;
  FM := ''; // : string;
  FMUF := '  '; // : string;
  FDtNasc := 0; // : TDateTime;
  FAtivo := True;
  FPessEnderList.Clear;
end;

procedure TPessEnt.SetApelido(const Value: string);
begin
  FApelido := Value;
end;

procedure TPessEnt.SetAtivo(const Value: boolean);
begin
  FAtivo := Value;
end;

procedure TPessEnt.SetC(const Value: string);
begin
  FC := Value;
end;

procedure TPessEnt.SetCObrigatorio(const Value: boolean);
begin

end;

procedure TPessEnt.SetCriadoEm(const Value: TDateTime);
begin
  FCriadoEm := Value;
end;

procedure TPessEnt.SetDtNasc(const Value: TDateTime);
begin
  FDtNasc := Value;
end;

procedure TPessEnt.SetAlteradoEm(const Value: TDateTime);
begin
  FAlteradoEm := Value;
end;

procedure TPessEnt.SetEMail(const Value: string);
begin
  FEMail := Value;
end;

procedure TPessEnt.SetEstadoCivilDescr(const Value: string);
begin
  FEstadoCivilDescr := Value;
end;

procedure TPessEnt.SetEstadoCivilId(const Value: char);
begin
  FEstadoCivilId := Value;
end;

procedure TPessEnt.SetGeneroId(const Value: char);
begin
  FGeneroId := Value;
end;

procedure TPessEnt.SetGeneroDescr(const Value: string);
begin
  FGeneroDescr := Value;
end;

procedure TPessEnt.SetI(const Value: string);
begin
  FI := Value;
end;

procedure TPessEnt.SetLojaId(const Value: smallint);
begin
  FLojaId := Value;
end;

procedure TPessEnt.SetM(const Value: string);
begin
  FM := Value;
end;

procedure TPessEnt.SetMUF(const Value: string);
begin
  FMUF := Value;
end;

procedure TPessEnt.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TPessEnt.SetNomeFantasia(const Value: string);
begin
  FNomeFantasia := Value;
end;

procedure TPessEnt.SetTerminalId(const Value: smallint);
begin
  FTerminalId := Value;
end;

end.
