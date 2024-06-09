unit App.Pess.Ent_u;

interface

uses App.Pess.Ent, App.Ent.Ed.Id, App.Ent.Ed.Id_u, Data.DB, App.PessEnder.List,
  App.Pess.Types;

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
    FDtNasc: TDateTime;
    FPessEnderList: IPessEnderList;
    FEnderQuantidadePermitida: TEnderQuantidadePermitida;

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

    function GetDtNasc: TDateTime;
    procedure SetDtNasc(const Value: TDateTime);

    function GetPessEnderList: IPessEnderList;

    function GetEnderQuantidadePermitida: TEnderQuantidadePermitida;

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
    property DtNasc: TDateTime read GetDtNasc write SetDtNasc;
    property PessEnderList: IPessEnderList read GetPessEnderList;
    property EnderQuantidadePermitida: TEnderQuantidadePermitida
      read GetEnderQuantidadePermitida;

    constructor Create(pState: TDataSetState; pPessEnderList: IPessEnderList;
      pEnderQuantidadePermitida: TEnderQuantidadePermitida);

    procedure LimparEnt; override;
  end;

implementation

{ TPessEnt }

constructor TPessEnt.Create(pState: TDataSetState;
  pPessEnderList: IPessEnderList;
  pEnderQuantidadePermitida: TEnderQuantidadePermitida);
begin
  inherited Create(dsBrowse, 0);
  FPessEnderList := pPessEnderList;
  FEnderQuantidadePermitida := pEnderQuantidadePermitida;
end;

function TPessEnt.GetApelido: string;
begin
  Result := FApelido;
end;

function TPessEnt.GetC: string;
begin
  Result := FC;
end;

function TPessEnt.GetDtNasc: TDateTime;
begin
  Result := FDtNasc;
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

procedure TPessEnt.SetDtNasc(const Value: TDateTime);
begin
  FDtNasc := Value;
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
