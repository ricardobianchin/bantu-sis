unit Sis.Terminal;

interface

uses Sis.Entities.Types, Sis.Threads.Crit.CriticalSections;

type
  ITerminal = interface(IInterface)
    ['{94645E77-89FD-4CB3-82DC-E2E659C19D8C}']
    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;

    function GetApelido: string;
    procedure SetApelido(Value: string);
    property Apelido: string read GetApelido write SetApelido;

    function GetNomeNaRede: string;
    procedure SetNomeNaRede(Value: string);
    property NomeNaRede: string read GetNomeNaRede write SetNomeNaRede;

    function GetIP: string;
    procedure SetIP(Value: string);
    property IP: string read GetIP write SetIP;

    function GetLetraDoDrive: string;
    procedure SetLetraDoDrive(Value: string);
    property LetraDoDrive: string read GetLetraDoDrive write SetLetraDoDrive;

    function GetNFSerie: smallint;
    procedure SetNFSerie(Value: smallint);
    property NFSerie: smallint read GetNFSerie write SetNFSerie;

    function GetGavetaTem: Boolean;
    procedure SetGavetaTem(Value: Boolean);
    property GavetaTem: Boolean read GetGavetaTem write SetGavetaTem;

    function GetGavetaComando: string;
    procedure SetGavetaComando(Value: string);
    property GavetaComando: string read GetGavetaComando write SetGavetaComando;

    function GetGavetaImprNome: string;
    procedure SetGavetaImprNome(Value: string);
    property GavetaImprNome: string read GetGavetaImprNome write SetGavetaImprNome;

    function GetBalancaModoUsoId: smallint;
    procedure SetBalancaModoUsoId(Value: smallint);
    property BalancaModoUsoId: smallint read GetBalancaModoUsoId write SetBalancaModoUsoId;

    function GetBalancaModoUsoDescr: string;
    procedure SetBalancaModoUsoDescr(Value: string);
    property BalancaModoUsoDescr: string read GetBalancaModoUsoDescr write SetBalancaModoUsoDescr;

    function GetBalancaId: smallint;
    procedure SetBalancaId(Value: smallint);
    property BalancaId: smallint read GetBalancaId write SetBalancaId;

    function GetBalancaFabrModelo: string;
    procedure SetBalancaFabrModelo(Value: string);
    property BalancaFabrModelo: string read GetBalancaFabrModelo write SetBalancaFabrModelo;

    function GetBarCodigoIni: smallint;
    procedure SetBarCodigoIni(Value: smallint);
    property BarCodigoIni: smallint read GetBarCodigoIni write SetBarCodigoIni;

    function GetBarCodigoTam: smallint;
    procedure SetBarCodigoTam(Value: smallint);
    property BarCodigoTam: smallint read GetBarCodigoTam write SetBarCodigoTam;

    function GetImpressoraModoEnvioId: smallint;
    procedure SetImpressoraModoEnvioId(Value: smallint);
    property ImpressoraModoEnvioId: smallint read GetImpressoraModoEnvioId write SetImpressoraModoEnvioId;

    function GetImpressoraModoEnvioDescr: string;
    procedure SetImpressoraModoEnvioDescr(Value: string);
    property ImpressoraModoEnvioDescr: string read GetImpressoraModoEnvioDescr write SetImpressoraModoEnvioDescr;

    function GetImpressoraModeloId: smallint;
    procedure SetImpressoraModeloId(Value: smallint);
    property ImpressoraModeloId: smallint read GetImpressoraModeloId write SetImpressoraModeloId;

    function GetImpressoraModeloDescr: string;
    procedure SetImpressoraModeloDescr(Value: string);
    property ImpressoraModeloDescr: string read GetImpressoraModeloDescr write SetImpressoraModeloDescr;

    function GetImpressoraNome: string;
    procedure SetImpressoraNome(Value: string);
    property ImpressoraNome: string read GetImpressoraNome write SetImpressoraNome;

    function GetImpressoraColsQtd: smallint;
    procedure SetImpressoraColsQtd(Value: smallint);
    property ImpressoraColsQtd: smallint read GetImpressoraColsQtd write SetImpressoraColsQtd;

    function GetCupomQtdLinsFinal: smallint;
    procedure SetCupomQtdLinsFinal(Value: smallint);
    property CupomQtdLinsFinal: smallint read GetCupomQtdLinsFinal write SetCupomQtdLinsFinal;

    function GetSempreOffLine: Boolean;
    procedure SetSempreOffLine(Value: Boolean);
    property SempreOffLine: Boolean read GetSempreOffLine write SetSempreOffLine;

    function GetAtivo: Boolean;
    procedure SetAtivo(Value: Boolean);
    property Ativo: Boolean read GetAtivo write SetAtivo;

    function GetLocalArqDados: string;
    procedure SetLocalArqDados(Value: string);
    property LocalArqDados: string read GetLocalArqDados write SetLocalArqDados;

    function GetDatabase: string;
    procedure SetDatabase(Value: string);
    property Database: string read GetDatabase write SetDatabase;

    function GetAsText: string;
    property AsText: string read GetAsText;

    function GetIdentStr: string;
    property IdentStr: string read GetIdentStr;

    function GetCriticalSections: ICriticalSections;
    property CriticalSections: ICriticalSections read GetCriticalSections;
  end;

  TTerminalProcedure = reference to procedure(pFrame: ITerminal);

implementation

end.
