unit Sis.Terminal_u;

interface

uses Sis.Entities.Types, Sis.Terminal, Sis.Threads.Crit.CriticalSections, Sis.UI.Impressao.Types_u;

type
  TTerminal =  class(TInterfacedObject, ITerminal)
  private
    FTerminalId: TTerminalId;

    FApelido: string;
    FNomeNaRede: string;
    FIP: string;
    FLetraDoDrive: string;

    FNFSerie: smallint;

    FGavetaTem: Boolean;
    FGavetaComando: string;
    FGavetaImprNome: string;

    FBalancaModoUsoId: smallint;
    FBalancaModoUsoDescr: string;

    FBalancaId: smallint;
    FBalancaFabrModelo: string;

    FBarCodigoIni: smallint;
    FBarCodigoTam: smallint;

    FImpressoraModoEnvioId: smallint;
    FImpressoraModoEnvioDescr: string;

    FImpressoraModeloId: smallint;
    FImpressoraModeloDescr: string;
    FImpressoraNome: string;
    FImpressoraColsQtd: smallint;

    FCupomQtdLinsFinal: smallint;

    FSempreOffLine: Boolean;
    FAtivo: Boolean;

    FBALANCA_PORTA: smallint;
    FBALANCA_BAUDRATE: smallint;
    FBALANCA_DATABITS: smallint;
    FBALANCA_PARIDADE: smallint;
    FBALANCA_STOPBITS: smallint;
    FBALANCA_HANDSHAKING: smallint;

    FLocalArqDados: string;
    FDatabase: string;

    FCriticalSections: ICriticalSections;


    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);

    function GetApelido: string;
    procedure SetApelido(Value: string);

    function GetNomeNaRede: string;
    procedure SetNomeNaRede(Value: string);

    function GetIP: string;
    procedure SetIP(Value: string);

    function GetLetraDoDrive: string;
    procedure SetLetraDoDrive(Value: string);

    function GetNFSerie: smallint;
    procedure SetNFSerie(Value: smallint);

    function GetGavetaTem: Boolean;
    procedure SetGavetaTem(Value: Boolean);

    function GetGavetaComando: string;
    procedure SetGavetaComando(Value: string);

    function GetGavetaImprNome: string;
    procedure SetGavetaImprNome(Value: string);

    function GetBalancaModoUsoId: smallint;
    procedure SetBalancaModoUsoId(Value: smallint);

    function GetBalancaModoUsoDescr: string;
    procedure SetBalancaModoUsoDescr(Value: string);

    function GetBalancaId: smallint;
    procedure SetBalancaId(Value: smallint);

    function GetBalancaFabrModelo: string;
    procedure SetBalancaFabrModelo(Value: string);

    function GetBarCodigoIni: smallint;
    procedure SetBarCodigoIni(Value: smallint);

    function GetBarCodigoTam: smallint;
    procedure SetBarCodigoTam(Value: smallint);

    function GetImpressoraModoEnvioId: smallint;
    procedure SetImpressoraModoEnvioId(Value: smallint);

    function GetImpressoraModoEnvioDescr: string;
    procedure SetImpressoraModoEnvioDescr(Value: string);

    function GetImpressoraModeloId: smallint;
    procedure SetImpressoraModeloId(Value: smallint);

    function GetImpressoraModeloDescr: string;
    procedure SetImpressoraModeloDescr(Value: string);

    function GetImpressoraNome: string;
    procedure SetImpressoraNome(Value: string);

    function GetImpressoraColsQtd: smallint;
    procedure SetImpressoraColsQtd(Value: smallint);

    function GetCupomQtdLinsFinal: smallint;
    procedure SetCupomQtdLinsFinal(Value: smallint);

    function GetSempreOffLine: Boolean;
    procedure SetSempreOffLine(Value: Boolean);

    function GetAtivo: Boolean;
    procedure SetAtivo(Value: Boolean);

    function GetBALANCA_PORTA: smallint;
    procedure SetBALANCA_PORTA(Value: smallint);

    function GetBALANCA_BAUDRATE: smallint;
    procedure SetBALANCA_BAUDRATE(Value: smallint);

    function GetBALANCA_DATABITS: smallint;
    procedure SetBALANCA_DATABITS(Value: smallint);

    function GetBALANCA_PARIDADE: smallint;
    procedure SetBALANCA_PARIDADE(Value: smallint);

    function GetBALANCA_STOPBITS: smallint;
    procedure SetBALANCA_STOPBITS(Value: smallint);

    function GetBALANCA_HANDSHAKING: smallint;
    procedure SetBALANCA_HANDSHAKING(Value: smallint);

    function GetLocalArqDados: string;
    procedure SetLocalArqDados(Value: string);

    function GetDatabase: string;
    procedure SetDatabase(Value: string);

    function GetAsText: string;

    function GetIdentStr: string;
    function GetCriticalSections: ICriticalSections;

  public
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;

    property Apelido: string read GetApelido write SetApelido;
    property NomeNaRede: string read GetNomeNaRede write SetNomeNaRede;
    property IP: string read GetIP write SetIP;
    property LetraDoDrive: string read GetLetraDoDrive write SetLetraDoDrive;

    property NFSerie: smallint read GetNFSerie write SetNFSerie;

    property GavetaTem: Boolean read GetGavetaTem write SetGavetaTem;
    property GavetaComando: string read GetGavetaComando write SetGavetaComando;
    property GavetaImprNome: string read GetGavetaImprNome write SetGavetaImprNome;

    property BalancaModoUsoId: smallint read GetBalancaModoUsoId write SetBalancaModoUsoId;
    property BalancaModoUsoDescr: string read GetBalancaModoUsoDescr write SetBalancaModoUsoDescr;

    property BalancaId: smallint read GetBalancaId write SetBalancaId;
    property BalancaFabrModelo: string read GetBalancaFabrModelo write SetBalancaFabrModelo;

    property BarCodigoIni: smallint read GetBarCodigoIni write SetBarCodigoIni;
    property BarCodigoTam: smallint read GetBarCodigoTam write SetBarCodigoTam;

    property ImpressoraModoEnvioId: smallint read GetImpressoraModoEnvioId write SetImpressoraModoEnvioId;
    property ImpressoraModoEnvioDescr: string read GetImpressoraModoEnvioDescr write SetImpressoraModoEnvioDescr;

    property ImpressoraModeloId: smallint read GetImpressoraModeloId write SetImpressoraModeloId;
    property ImpressoraModeloDescr: string read GetImpressoraModeloDescr write SetImpressoraModeloDescr;
    property ImpressoraNome: string read GetImpressoraNome write SetImpressoraNome;
    property ImpressoraColsQtd: smallint read GetImpressoraColsQtd write SetImpressoraColsQtd;

    property CupomQtdLinsFinal: smallint read GetCupomQtdLinsFinal write SetCupomQtdLinsFinal;

    property SempreOffLine: Boolean read GetSempreOffLine write SetSempreOffLine;
    property Ativo: Boolean read GetAtivo write SetAtivo;

    property BALANCA_PORTA: smallint read GetBALANCA_PORTA write SetBALANCA_PORTA;
    property BALANCA_BAUDRATE: smallint read GetBALANCA_BAUDRATE write SetBALANCA_BAUDRATE;
    property BALANCA_DATABITS: smallint read GetBALANCA_DATABITS write SetBALANCA_DATABITS;
    property BALANCA_PARIDADE: smallint read GetBALANCA_PARIDADE write SetBALANCA_PARIDADE;
    property BALANCA_STOPBITS: smallint read GetBALANCA_STOPBITS write SetBALANCA_STOPBITS;
    property BALANCA_HANDSHAKING: smallint read GetBALANCA_HANDSHAKING write SetBALANCA_HANDSHAKING;

    property LocalArqDados: string read GetLocalArqDados write SetLocalArqDados;
    property Database: string read GetDatabase write SetDatabase;


    property AsText: string read GetAsText;
    property IdentStr: string read GetIdentStr;

    property CriticalSections: ICriticalSections read GetCriticalSections;
    constructor Create;
  end;


implementation

uses System.SysUtils, Sis.Threads.Factory_u;

{ TTerminal }

constructor TTerminal.Create;
begin
  FCriticalSections := CriticalSectionsCreate;
end;

function TTerminal.GetApelido: string;
begin
  Result := FApelido;
end;

function TTerminal.GetAsText: string;
begin
  Result := FTerminalId.ToStrZero + ' '+IdentStr;
  if FApelido <> '' then
  begin
    Result := Result + ' ' + FApelido;
  end;

  if FNFSerie > 0 then
  begin
    Result := Result + ' NFe:' + FNFSerie.ToString;
  end;

  if SempreOffLine then
    Result := Result + ' Sem WEB';
end;

function TTerminal.GetAtivo: Boolean;
begin
  Result := FAtivo;
end;

function TTerminal.GetBalancaFabrModelo: string;
begin
  Result := FBalancaFabrModelo;
end;

function TTerminal.GetBalancaId: smallint;
begin
  Result := FBalancaId;
end;

function TTerminal.GetBalancaModoUsoId: smallint;
begin
  Result := FBalancaModoUsoId;
end;

function TTerminal.GetBALANCA_BAUDRATE: smallint;
begin
  Result := FBALANCA_BAUDRATE;
end;

function TTerminal.GetBALANCA_DATABITS: smallint;
begin
  Result := FBALANCA_DATABITS;
end;

function TTerminal.GetBALANCA_HANDSHAKING: smallint;
begin
  Result := FBALANCA_HANDSHAKING;
end;

function TTerminal.GetBALANCA_PARIDADE: smallint;
begin
  Result := FBALANCA_PARIDADE;
end;

function TTerminal.GetBALANCA_PORTA: smallint;
begin
  Result := FBALANCA_PORTA;
end;

function TTerminal.GetBALANCA_STOPBITS: smallint;
begin
  Result := FBALANCA_STOPBITS;
end;

function TTerminal.GetBarCodigoIni: smallint;
begin
  Result := FBarCodigoIni;
end;

function TTerminal.GetBarCodigoTam: smallint;
begin
  Result := FBarCodigoTam;
end;

function TTerminal.GetCriticalSections: ICriticalSections;
begin
  Result := FCriticalSections;
end;

function TTerminal.GetCupomQtdLinsFinal: smallint;
begin
  Result := FCupomQtdLinsFinal;
end;

function TTerminal.GetDatabase: string;
begin
  Result := FDatabase;
end;

function TTerminal.GetGavetaComando: string;
begin
  Result := FGavetaComando;
end;

function TTerminal.GetGavetaTem: Boolean;
begin
  Result := FGavetaTem;
end;

function TTerminal.GetGavetaImprNome: string;
begin
  Result := FGavetaImprNome;
end;

function TTerminal.GetIdentStr: string;
begin
  if NomeNaRede <> '' then
    Result := NomeNaRede
  else
    Result := IP;
end;

function TTerminal.GetImpressoraModoEnvioDescr: string;
begin
  Result := FImpressoraModoEnvioDescr;
end;

function TTerminal.GetImpressoraModoEnvioId: smallint;
begin
  Result := FImpressoraModoEnvioId;
end;

function TTerminal.GetIP: string;
begin
  Result := FIP;
end;

function TTerminal.GetLetraDoDrive: string;
begin
  Result := FLetraDoDrive;
end;

function TTerminal.GetLocalArqDados: string;
begin
  Result := FLocalArqDados;
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

function TTerminal.GetBalancaModoUsoDescr: string;
begin
  Result := FBalancaModoUsoDescr;
end;

procedure TTerminal.SetBalancaModoUsoDescr(Value: string);
begin
  FBalancaModoUsoDescr := Value;
end;

function TTerminal.GetImpressoraModeloId: smallint;
begin
  Result := FImpressoraModeloId;
end;

procedure TTerminal.SetImpressoraModeloId(Value: smallint);
begin
  FImpressoraModeloId := Value;
end;

function TTerminal.GetImpressoraModeloDescr: string;
begin
  Result := FImpressoraModeloDescr;
end;

procedure TTerminal.SetImpressoraModeloDescr(Value: string);
begin
  FImpressoraModeloDescr := Value;
end;

function TTerminal.GetImpressoraNome: string;
begin
  Result := FImpressoraNome;
end;

procedure TTerminal.SetImpressoraNome(Value: string);
begin
  FImpressoraNome := Value;
end;

function TTerminal.GetImpressoraColsQtd: smallint;
begin
  Result := FImpressoraColsQtd;
end;

procedure TTerminal.SetImpressoraColsQtd(Value: smallint);
begin
  FImpressoraColsQtd := Value;
end;

procedure TTerminal.SetApelido(Value: string);
begin
  FApelido := Value;
end;

procedure TTerminal.SetAtivo(Value: Boolean);
begin
  FAtivo := Value;
end;

procedure TTerminal.SetBalancaFabrModelo(Value: string);
begin
  FBalancaFabrModelo := Value;
end;

procedure TTerminal.SetBalancaId(Value: smallint);
begin
  FBalancaId := Value;
end;

procedure TTerminal.SetBalancaModoUsoId(Value: smallint);
begin
  FBalancaModoUsoId := Value;
end;

procedure TTerminal.SetBALANCA_BAUDRATE(Value: smallint);
begin
  FBALANCA_BAUDRATE := Value;
end;

procedure TTerminal.SetBALANCA_DATABITS(Value: smallint);
begin
  FBALANCA_DATABITS := Value;
end;

procedure TTerminal.SetBALANCA_HANDSHAKING(Value: smallint);
begin
  FBALANCA_HANDSHAKING := Value;
end;

procedure TTerminal.SetBALANCA_PARIDADE(Value: smallint);
begin
  FBALANCA_PARIDADE := Value;
end;

procedure TTerminal.SetBALANCA_PORTA(Value: smallint);
begin
  FBALANCA_PORTA := Value;
end;

procedure TTerminal.SetBALANCA_STOPBITS(Value: smallint);
begin
  FBALANCA_STOPBITS := Value;
end;

procedure TTerminal.SetBarCodigoIni(Value: smallint);
begin
  FBarCodigoIni := Value;
end;

procedure TTerminal.SetBarCodigoTam(Value: smallint);
begin
  FBarCodigoTam := Value;
end;

procedure TTerminal.SetCupomQtdLinsFinal(Value: smallint);
begin
  FCupomQtdLinsFinal := Value;
end;

procedure TTerminal.SetDatabase(Value: string);
begin
  FDatabase := Value;
end;

procedure TTerminal.SetGavetaComando(Value: string);
begin
  FGavetaComando := Value;
end;

procedure TTerminal.SetGavetaTem(Value: Boolean);
begin
  FGavetaTem := Value;
end;

procedure TTerminal.SetGavetaImprNome(Value: string);
begin
  FGavetaImprNome := Value;
end;

procedure TTerminal.SetImpressoraModoEnvioDescr(Value: string);
begin
  FImpressoraModoEnvioDescr := Value;
end;

procedure TTerminal.SetImpressoraModoEnvioId(Value: smallint);
begin
  FImpressoraModoEnvioId := Value;
end;

procedure TTerminal.SetIP(Value: string);
begin
  FIP := Value;
end;

procedure TTerminal.SetLetraDoDrive(Value: string);
begin
  FLetraDoDrive := Value;
end;

procedure TTerminal.SetLocalArqDados(Value: string);
begin
  FLocalArqDados := Value;
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
