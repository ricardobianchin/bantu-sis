unit App.Est.Venda.Caixa.CaixaSessaoOperacao;

interface

uses App.Est.Venda.Caixa.CaixaSessao,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo;

type
  ICxOperacao = interface(IInterface)
    ['{6FFFAF55-A5B0-497C-AC05-E80936536F68}']
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
  end;

implementation

end.
