unit App.Est.PromoItem_u;

interface

uses
  Sis.Types, App.Est.Prod, App.Est.PromoItem;

type
  TEstPromoItem = class(TInterfacedObject, IEstPromoItem)
  strict private
    FProd: IProd;
    FPrecoPromo: Currency;
    FAtivo: Boolean;
  private
    function GetProd: IProd;

    function GetPrecoPromo: Currency;
    procedure SetPrecoPromo(Value: Currency);

    function GetAtivo: Boolean;
    procedure SetAtivo(Value: Boolean);
  public
    property Prod: IProd read GetProd;
    property PrecoPromo: Currency read GetPrecoPromo write SetPrecoPromo;
    property Ativo: Boolean read GetAtivo write SetAtivo;

    constructor Create(pProd: IProd; pPrecoPromo: Currency; pAtivo: Boolean);
  end;

implementation

{ TEstPromoItem }

constructor TEstPromoItem.Create(pProd: IProd; pPrecoPromo: Currency;
  pAtivo: Boolean);
begin
  inherited Create;
  FProd := pProd;
  FPrecoPromo := pPrecoPromo;
  FAtivo := pAtivo;
end;

function TEstPromoItem.GetAtivo: Boolean;
begin
  Result := FAtivo;
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

end.
