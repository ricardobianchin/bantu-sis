unit App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent;

interface

uses App.Est.Venda.Caixa.CaixaSessao, App.Ent.Ed, Sis.Entities.Types,
  App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo, App.Est.Venda.Caixa.CxValor, App.Est.Venda.Caixa.CxValorList,
  App.Types, Sis.Types, System.Classes;

type
  ICxOperacaoEnt = interface(IEntEd)
    ['{66B85245-BBB5-4671-9C93-E2671C1CAE05}']
    function GetCaixaSessao: ICaixaSessao;
    property CaixaSessao: ICaixaSessao read GetCaixaSessao;

    function GetOperOrdem: SmallInt;
    procedure SetOperOrdem(Value: SmallInt);
    property OperOrdem: SmallInt read GetOperOrdem write SetOperOrdem;

    function GetCxOperacaoTipo: ICxOperacaoTipo;
    property CxOperacaoTipo: ICxOperacaoTipo read GetCxOperacaoTipo;

    function GetLogId: Int64;
    procedure SetLogId(Value: Int64);
    property LogId: Int64 read GetLogId write SetLogId;

    function GetOperTipoOrdem: SmallInt;
    procedure SetOperTipoOrdem(Value: SmallInt);
    property OperTipoOrdem: SmallInt read GetOperTipoOrdem write SetOperTipoOrdem;

    function GetValor: Currency;
    procedure SetValor(Value: Currency);
    property Valor: Currency read GetValor write SetValor;

    function GetObs: string;
    procedure SetObs(Value: string);
    property Obs: string read GetObs write SetObs;

    function GetCancelado: Boolean;
    procedure SetCancelado(Value: Boolean);
    property Cancelado: Boolean read GetCancelado write SetCancelado;

    function GetCxValorList: ICxValorList;
    property CxValorList: ICxValorList read GetCxValorList;

    function GetCod(pSeparador: string = '-'): string;

    function GetCriadoEm: TDateTime;
    procedure SetCriadoEm(Value: TDateTIme);
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;

    function GetLinhas: TStrings;
    property Linhas: TStrings read GetLinhas;
  end;
{
OPER_LOG_ID;BIGINT;S;S

OPER_TIPO_ID;ID_CHAR_DOM;S
OPER_TIPO_ORDEM;SMALLINT;S
VALOR;PRECO_DOM;S
OBS;OBS_DOM
CANCELADO;BOOLEAN DEFAULT FALSE;S


}
implementation

end.
