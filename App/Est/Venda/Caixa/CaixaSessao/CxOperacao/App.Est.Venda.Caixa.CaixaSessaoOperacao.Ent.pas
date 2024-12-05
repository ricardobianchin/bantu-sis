unit App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent;

interface

uses App.Est.Venda.Caixa.CaixaSessao, App.Ent.Ed, Sis.Entities.Types,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo, App.Est.Venda.Caixa.CxValor,
  App.Types, Sis.Types;

type
  ICxOperacaoEnt = interface(IEntEd)
    ['{66B85245-BBB5-4671-9C93-E2671C1CAE05}']
    procedure SetLojaId(Value: TLojaId);
    function GetLojaId: TLojaId;
    property LojaId: TLojaId read GetLojaId write SetLojaId;

    procedure SetTerminalId(Value: TTerminalId);
    function GetTerminalId: TTerminalId;
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;

    function GetCaixaSessao: ICaixaSessao;
    property CaixaSessao: ICaixaSessao read GetCaixaSessao;

    function GetOperOrdem: SmallInt;
    property OperOrdem: SmallInt read GetOperOrdem;

    function GetCxOperacaoTipo: ICxOperacaoTipo;
    property CxOperacaoTipo: ICxOperacaoTipo read GetCxOperacaoTipo;

    function GetLogId: Int64;
    procedure SetLogId(Value: Int64);
    property LogId: Int64 read GetLogId write SetLogId;

    function GetOperTipoOrdem: SmallInt;
    procedure SetOperTipoOrdem(Value: SmallInt);
    property OperTipoOrdem: SmallInt read GetOperTipoOrdem;

    function GetValor: Currency;
    procedure SetValor(Value: Currency);
    property Valor: Currency read GetValor write SetValor;

    function GetObs: string;
    procedure SetObs(Value: string);
    property Obs: string read GetObs write SetObs;

    function GetCancelado: Boolean;
    procedure SetCancelado(Value: Boolean);
    property Cancelado: Boolean read GetCancelado write SetCancelado;

    function PegueCxValor(pPagamentoFormaId: TId; pValor: TPreco): ICxValor;

    function GetCxValor(Index: integer): ICxValor;
    property CxValor[Index: integer]: ICxValor read GetCxValor; default;

  end;

implementation

end.
