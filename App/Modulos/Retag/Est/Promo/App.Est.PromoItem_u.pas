unit App.Est.PromoItem_u;

interface

uses
  Sis.Types, App.Est.Prod, App.Est.PromoItem;

type
  TEstPromoItem = class(TInterfacedObject, IEstPromoItem)
  strict private
    FOrdem: SmallInt;
    FProd: IProd;
    FPrecoPromo: Currency;
    FAtivo: Boolean;
  private
    function GetOrdem: SmallInt;
    procedure SetOrdem(Value: SmallInt);

    function GetProd: IProd;

    function GetPrecoPromo: Currency;
    procedure SetPrecoPromo(Value: Currency);

    function GetAtivo: Boolean;
    procedure SetAtivo(Value: Boolean);
    public
    property Prod: IProd read GetProd;
    property Ordem: SmallInt read GetOrdem write SetOrdem;
    property PrecoPromo: Currency read GetPrecoPromo write SetPrecoPromo;
    property Ativo: Boolean read GetAtivo write SetAtivo;
  end;

implementation

{ TEstPromoItem }

function TEstPromoItem.GetAtivo: Boolean;
begin
    Result := FAtivo;
end;

function TEstPromoItem.GetOrdem: SmallInt;
begin
    Result := FOrdem;
end;

function TEstPromoItem.GetPrecoPromo: Currency;
begin
    Result := FPrecoPromo;
end;

function TEstPromoItem.GetProd: IProd;
begin
    Result := FProd;
end;

procedure TEstPromoItem.SetAtivo(Value: Boolean);
begin
    FAtivo := Value;
end;

procedure TEstPromoItem.SetPrecoPromo(Value: Currency);
begin
    FPrecoPromo := Value;
end;

procedure TEstPromoItem.SetOrdem(Value: SmallInt);
begin
    FOrdem := Value;
end;

end.
