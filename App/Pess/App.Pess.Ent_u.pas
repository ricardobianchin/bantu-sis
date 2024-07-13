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
    FEstadoCivil: char;
    FGenero: char;
    FC: string;
    FI: string;
    FM: string;
    FMUF: string;
    FEMail: string;
    FDtNasc: TDateTime;
    FCriadoEm: TDateTime;
    FAlteradoEm: TDateTime;

    FPessEnderList: IPessEnderList;
    FEnderQuantidadePermitida: TEnderQuantidadePermitida;
    FCodUsaTerminalId: boolean;

    FCObrigatorio: boolean;

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

    function GetEstadoCivil: char;
    procedure SetEstadoCivil(const Value: char);

    function GetGenero: char;
    procedure SetGenero(const Value: char);

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

    function GetCriadoEm: TDateTime;
    procedure SetCriadoEm(const Value: TDateTime);

    function GetAlteradoEm: TDateTime;
    procedure SetAlteradoEm(const Value: TDateTime);


    function GetPessEnderList: IPessEnderList;

    function GetEnderQuantidadePermitida: TEnderQuantidadePermitida;
    function GetCodUsaTerminalId: boolean;

    function GetCObrigatorio: boolean;
    procedure SetCObrigatorio(const Value: Boolean);

    function GetCodAsString: string;
  public
    property TerminalId: smallint read GetTerminalId write SetTerminalId;
    property LojaId: smallint read GetLojaId write SetLojaId;
    property Nome: string read GetNome write SetNome;
    property NomeFantasia: string read GetNomeFantasia write SetNomeFantasia;
    property Apelido: string read GetApelido write SetApelido;
    property EstadoCivil: char read GetEstadoCivil write SetEstadoCivil;
    property Genero: char read GetGenero write SetGenero;
    property C: string read GetC write SetC;
    property I: string read GetI write SetI;
    property M: string read GetM write SetM;
    property MUF: string read GetMUF write SetMUF;
    property EMail: string read GetEMail write SetEMail;
    property DtNasc: TDateTime read GetDtNasc write SetDtNasc;
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;
    property AlteradoEm: TDateTime read GetAlteradoEm write SetAlteradoEm;

    property PessEnderList: IPessEnderList read GetPessEnderList;
    property EnderQuantidadePermitida: TEnderQuantidadePermitida
      read GetEnderQuantidadePermitida;
    property CodUsaTerminalId: boolean read GetCodUsaTerminalId;
    property CodAsString: string read GetCodAsString;

    property CObrigatorio: boolean read GetCObrigatorio write SetCObrigatorio;

    constructor Create(pState: TDataSetState; pPessEnderList: IPessEnderList;
      pEnderQuantidadePermitida: TEnderQuantidadePermitida; pCodUsaTerminalId: boolean);

    procedure LimparEnt; override;
  end;

implementation

uses System.SysUtils;

{ TPessEnt }

constructor TPessEnt.Create(pState: TDataSetState;
  pPessEnderList: IPessEnderList;
  pEnderQuantidadePermitida: TEnderQuantidadePermitida; pCodUsaTerminalId: boolean);
begin
  inherited Create(dsBrowse, 0);
  FPessEnderList := pPessEnderList;
  FEnderQuantidadePermitida := pEnderQuantidadePermitida;
  CObrigatorio := True;
  FCodUsaTerminalId := pCodUsaTerminalId;
  LimparEnt;
end;

function TPessEnt.GetApelido: string;
begin
  Result := FApelido;
end;

function TPessEnt.GetC: string;
begin
  Result := FC;
end;

function TPessEnt.GetCObrigatorio: boolean;
begin
  Result := FCObrigatorio;
end;

function TPessEnt.GetCodAsString: string;
begin
  Result := CodsToCodAsString(LojaId, TerminalId, Id, CodUsaTerminalId);
end;

function TPessEnt.GetCodUsaTerminalId: boolean;
begin
  Result := FCodUsaTerminalId;
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
  Result := FEnderQuantidadePermitida;
end;

function TPessEnt.GetEstadoCivil: char;
begin
  Result := FEstadoCivil;
end;

function TPessEnt.GetGenero: char;
begin
  Result := FGenero;
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
  FEstadoCivil := ' '; // : char;
  FGenero := ' '; // : char;
  FC := ''; // : string;
  FI := ''; // : string;
  FM := ''; // : string;
  FMUF := '  '; // : string;
  FDtNasc := 0; // : TDateTime;
  FPessEnderList.Clear;
end;

procedure TPessEnt.SetApelido(const Value: string);
begin
  FApelido := Value;
end;

procedure TPessEnt.SetC(const Value: string);
begin
  FC := Value;
end;

procedure TPessEnt.SetCObrigatorio(const Value: Boolean);
begin
  FCObrigatorio := Value;
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

procedure TPessEnt.SetEstadoCivil(const Value: char);
begin
  FEstadoCivil := Value;
end;

procedure TPessEnt.SetGenero(const Value: char);
begin
  FGenero := Value;
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
