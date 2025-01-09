unit App.PDV.VendaPag_u;

interface

uses
  App.PDV.VendaPag, Sis.Types;

type
  TVendaPag = class(TInterfacedObject, IVendaPag)
  private
    FOrdem: SmallInt;
    FPagamentoFormaId: TId;
    FValorDevido: Currency;
    FValorEntregue: Currency;
    FTroco: Currency;
    FCancelado: Boolean;

    function GetOrdem: SmallInt;
    procedure SetOrdem(const Value: SmallInt);
    function GetPagamentoFormaId: TId;
    procedure SetPagamentoFormaId(const Value: TId);
    function GetValorDevido: Currency;
    procedure SetValorDevido(const Value: Currency);
    function GetValorEntregue: Currency;
    procedure SetValorEntregue(const Value: Currency);
    function GetTroco: Currency;
    procedure SetTroco(const Value: Currency);
    function GetCancelado: Boolean;
    procedure SetCancelado(const Value: Boolean);
  public
    constructor Create(AOrdem: SmallInt; APagamentoFormaId: TId; AValorDevido, AValorEntregue, ATroco: Currency; ACancelado: Boolean);

    property Ordem: SmallInt read GetOrdem write SetOrdem;
    property PagamentoFormaId: TId read GetPagamentoFormaId write SetPagamentoFormaId;
    property ValorDevido: Currency read GetValorDevido write SetValorDevido;
    property ValorEntregue: Currency read GetValorEntregue write SetValorEntregue;
    property Troco: Currency read GetTroco write SetTroco;
    property Cancelado: Boolean read GetCancelado write SetCancelado;
  end;

implementation

constructor TVendaPag.Create(AOrdem: SmallInt; APagamentoFormaId: TId; AValorDevido, AValorEntregue, ATroco: Currency; ACancelado: Boolean);
begin
  FOrdem := AOrdem;
  FPagamentoFormaId := APagamentoFormaId;
  FValorDevido := AValorDevido;
  FValorEntregue := AValorEntregue;
  FTroco := ATroco;
  FCancelado := ACancelado;
end;

function TVendaPag.GetOrdem: SmallInt;
begin
  Result := FOrdem;
end;

procedure TVendaPag.SetOrdem(const Value: SmallInt);
begin
  FOrdem := Value;
end;

function TVendaPag.GetPagamentoFormaId: TId;
begin
  Result := FPagamentoFormaId;
end;

procedure TVendaPag.SetPagamentoFormaId(const Value: TId);
begin
  FPagamentoFormaId := Value;
end;

function TVendaPag.GetValorDevido: Currency;
begin
  Result := FValorDevido;
end;

procedure TVendaPag.SetValorDevido(const Value: Currency);
begin
  FValorDevido := Value;
end;

function TVendaPag.GetValorEntregue: Currency;
begin
  Result := FValorEntregue;
end;

procedure TVendaPag.SetValorEntregue(const Value: Currency);
begin
  FValorEntregue := Value;
end;

function TVendaPag.GetTroco: Currency;
begin
  Result := FTroco;
end;

procedure TVendaPag.SetTroco(const Value: Currency);
begin
  FTroco := Value;
end;

function TVendaPag.GetCancelado: Boolean;
begin
  Result := FCancelado;
end;

procedure TVendaPag.SetCancelado(const Value: Boolean);
begin
  FCancelado := Value;
end;

end.
