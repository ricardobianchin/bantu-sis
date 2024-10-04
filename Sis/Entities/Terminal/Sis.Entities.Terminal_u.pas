unit Sis.Entities.Terminal_u;

interface

uses Sis.Entities.Types, Sis.Entities.Terminal;

type
  TTerminal =  class(TInterfacedObject, ITerminal)
  private
    FTerminalId: TTerminalId;
    FApelido: string;
    FNomeNaRede: string;
    FIP: string;
    FNFSerie: smallint;
    FLetraDoDrive: string;
    FGavetaTem: Boolean;
    FBalancaModoId: smallint;
    FBalancaId: smallint;
    FBarCodigoIni: smallint;
    FBarCodigoTam: smallint;
    FCupomNLinsFinal: smallint;
    FSempreOffLine: Boolean;

    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);

    function GetApelido: string;
    procedure SetApelido(Value: string);

    function GetNomeNaRede: string;
    procedure SetNomeNaRede(Value: string);

    function GetIP: string;
    procedure SetIP(Value: string);

    function GetNFSerie: smallint;
    procedure SetNFSerie(Value: smallint);

    function GetLetraDoDrive: string;
    procedure SetLetraDoDrive(Value: string);

    function GetGavetaTem: Boolean;
    procedure SetGavetaTem(Value: Boolean);

    function GetBalancaModoId: smallint;
    procedure SetBalancaModoId(Value: smallint);

    function GetBalancaId: smallint;
    procedure SetBalancaId(Value: smallint);

    function GetBarCodigoIni: smallint;
    procedure SetBarCodigoIni(Value: smallint);

    function GetBarCodigoTam: smallint;
    procedure SetBarCodigoTam(Value: smallint);

    function GetCupomNLinsFinal: smallint;
    procedure SetCupomNLinsFinal(Value: smallint);

    function GetSempreOffLine: Boolean;
    procedure SetSempreOffLine(Value: Boolean);
  public
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;
    property Apelido: string read GetApelido write SetApelido;
    property NomeNaRede: string read GetNomeNaRede write SetNomeNaRede;
    property IP: string read GetIP write SetIP;
    property NFSerie: smallint read GetNFSerie write SetNFSerie;
    property LetraDoDrive: string read GetLetraDoDrive write SetLetraDoDrive;
    property GavetaTem: Boolean read GetGavetaTem write SetGavetaTem;
    property BalancaModoId: smallint read GetBalancaModoId write SetBalancaModoId;
    property BalancaId: smallint read GetBalancaId write SetBalancaId;
    property BarCodigoIni: smallint read GetBarCodigoIni write SetBarCodigoIni;
    property BarCodigoTam: smallint read GetBarCodigoTam write SetBarCodigoTam;
    property CupomNLinsFinal: smallint read GetCupomNLinsFinal write SetCupomNLinsFinal;
    property SempreOffLine: Boolean read GetSempreOffLine write SetSempreOffLine;
  end;


implementation

{ TTerminal }

function TTerminal.GetApelido: string;
begin
  Result := FApelido;
end;

function TTerminal.GetBalancaId: smallint;
begin
  Result := FBalancaId;
end;

function TTerminal.GetBalancaModoId: smallint;
begin
  Result := FBalancaModoId;
end;

function TTerminal.GetBarCodigoIni: smallint;
begin
  Result := FBarCodigoIni;
end;

function TTerminal.GetBarCodigoTam: smallint;
begin
  Result := FBarCodigoTam;
end;

function TTerminal.GetCupomNLinsFinal: smallint;
begin
  Result := FCupomNLinsFinal;
end;

function TTerminal.GetGavetaTem: Boolean;
begin
  Result := FGavetaTem;
end;

function TTerminal.GetIP: string;
begin
  Result := FIP;
end;

function TTerminal.GetLetraDoDrive: string;
begin
  Result := FLetraDoDrive;
end;

function TTerminal.GetNFSerie: smallint;
begin
  Result := FNFSerie;
end;

function TTerminal.GetNomeNaRede: string;
begin
  Result := FNomeNaRede;
end;

function TTerminal.GetSempreOffLine: Boolean;
begin
  Result := FSempreOffLine;
end;

function TTerminal.GetTerminalId: TTerminalId;
begin
  Result := FTerminalId;
end;

procedure TTerminal.SetApelido(Value: string);
begin
  FApelido := Value;
end;

procedure TTerminal.SetBalancaId(Value: smallint);
begin
  FBalancaId := Value;
end;

procedure TTerminal.SetBalancaModoId(Value: smallint);
begin
  FBalancaModoId := Value;
end;

procedure TTerminal.SetBarCodigoIni(Value: smallint);
begin
  FBarCodigoIni := Value;
end;

procedure TTerminal.SetBarCodigoTam(Value: smallint);
begin
  FBarCodigoTam := Value;
end;

procedure TTerminal.SetCupomNLinsFinal(Value: smallint);
begin
  FCupomNLinsFinal := Value;
end;

procedure TTerminal.SetGavetaTem(Value: Boolean);
begin
  FGavetaTem := Value;
end;

procedure TTerminal.SetIP(Value: string);
begin
  FIP := Value;
end;

procedure TTerminal.SetLetraDoDrive(Value: string);
begin
  FLetraDoDrive := Value;
end;

procedure TTerminal.SetNFSerie(Value: smallint);
begin
  FNFSerie := Value;
end;

procedure TTerminal.SetNomeNaRede(Value: string);
begin
  FNomeNaRede := Value;
end;

procedure TTerminal.SetSempreOffLine(Value: Boolean);
begin
  FSempreOffLine := Value;
end;

procedure TTerminal.SetTerminalId(Value: TTerminalId);
begin
  FTerminalId := Value;
end;

end.
