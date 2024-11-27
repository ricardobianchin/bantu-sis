unit App.Est.Venda.Caixa.CaixaSessaoOperacao_u;

interface

uses Sis.Types.Utils_u, App.Ent.Ed_u, Sis.Entities.Types,
  App.Est.Venda.Caixa.CaixaSessao, App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo,
  App.Est.Venda.Caixa.CaixaSessaoOperacao;

type
  TCxOperacao = class(TEntEd, ICxOperacao)
  private
    FLojaId: TLojaId;
    FTerminalId: TTerminalId;
    FCaixaSessao: ICaixaSessao;
    FOperOrdem: SmallInt;
    FCxOperacaoTipo: ICxOperacaoTipo;
    FLogId: Int64;
    FOperTipoOrdem: SmallInt;
    FValor: Currency;
    FObs: string;
    FCancelado: Boolean;

    function GetLojaId: TLojaId;
    procedure SetLojaId(Value: TLojaId);

    function GetTerminalId: TTerminalId;
    procedure SetTerminalId(Value: TTerminalId);

    function GetCaixaSessao: ICaixaSessao;
    function GetOperOrdem: SmallInt;
    function GetCxOperacaoTipo: ICxOperacaoTipo;

    function GetLogId: Int64;
    procedure SetLogId(Value: Int64);

    function GetOperTipoOrdem: SmallInt;
    procedure SetOperTipoOrdem(Value: SmallInt);

    function GetValor: Currency;
    procedure SetValor(Value: Currency);

    function GetObs: string;
    procedure SetObs(Value: string);

    function GetCancelado: Boolean;
    procedure SetCancelado(Value: Boolean);

  protected
    procedure LimparEnt;
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

  public
    property CaixaSessao: ICaixaSessao read GetCaixaSessao;
    property OperOrdem: SmallInt read GetOperOrdem;
    property CxOperacaoTipo: ICxOperacaoTipo read GetCxOperacaoTipo;
    property LogId: Int64 read GetLogId write SetLogId;
    property OperTipoOrdem: SmallInt read GetOperTipoOrdem;
    property Valor: Currency read GetValor write SetValor;
    property Obs: string read GetObs write SetObs;
    property Cancelado: Boolean read GetCancelado write SetCancelado;

    constructor Create(pCaixaSessao: ICaixaSessao;
      pCxOperacaoTipo: ICxOperacaoTipo);
  end;

implementation

{ TCxOperacao }

constructor TCxOperacao.Create(pCaixaSessao: ICaixaSessao;
  pCxOperacaoTipo: ICxOperacaoTipo);
begin
  FCaixaSessao := pCaixaSessao;
  FCxOperacaoTipo := pCxOperacaoTipo;
end;

function TCxOperacao.GetCaixaSessao: ICaixaSessao;
begin

end;

function TCxOperacao.GetCancelado: Boolean;
begin

end;

function TCxOperacao.GetCxOperacaoTipo: ICxOperacaoTipo;
begin

end;

function TCxOperacao.GetLogId: Int64;
begin

end;

function TCxOperacao.GetLojaId: TLojaId;
begin

end;

function TCxOperacao.GetNomeEnt: string;
begin

end;

function TCxOperacao.GetNomeEntAbrev: string;
begin

end;

function TCxOperacao.GetObs: string;
begin

end;

function TCxOperacao.GetOperOrdem: SmallInt;
begin

end;

function TCxOperacao.GetOperTipoOrdem: SmallInt;
begin

end;

function TCxOperacao.GetTerminalId: TTerminalId;
begin

end;

function TCxOperacao.GetTitulo: string;
begin

end;

function TCxOperacao.GetValor: Currency;
begin

end;

procedure TCxOperacao.LimparEnt;
begin
  FOperOrdem := 0;
  FLogId := 0;
  FOperTipoOrdem := 0;
  FValor := ZERO_CURRENCY;
  FObs := '';
  FCancelado := False;
end;

procedure TCxOperacao.SetCancelado(Value: Boolean);
begin

end;

procedure TCxOperacao.SetLogId(Value: Int64);
begin

end;

procedure TCxOperacao.SetLojaId(Value: TLojaId);
begin

end;

procedure TCxOperacao.SetObs(Value: string);
begin

end;

procedure TCxOperacao.SetOperTipoOrdem(Value: SmallInt);
begin

end;

procedure TCxOperacao.SetTerminalId(Value: TTerminalId);
begin

end;

procedure TCxOperacao.SetValor(Value: Currency);
begin

end;

end.
