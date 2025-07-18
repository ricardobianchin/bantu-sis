unit App.Retag.Est.VendaItem_u;

interface

uses App.Est.EstMovItem_u, App.Retag.Est.VendaItem, Sis.Types,
  Sis.Sis.Constants, App.Est.Prod;

type
  TRetagVendaItem = class(TEstMovItem, IRetagVendaItem)
  private
    FPrecoUnit: Currency;
    FPreco: Currency;

    function GetPrecoUnit: Currency;
    procedure SetPrecoUnit(Value: Currency);

    function GetPreco: Currency;
    procedure SetPreco(Value: Currency);
  public
    property PrecoUnit: Currency read GetPrecoUnit write SetPrecoUnit;
    property Preco: Currency read GetPreco write SetPreco;

    constructor Create( //
      pOrdem: SmallInt; //

      pProd: IProd; //

      pQtd: Currency; //

      FPrecoUnit: Currency;
      FPreco: Currency
      );
  end;

implementation

uses App.Est.Factory_u;

{ TRetagVendaItem }

constructor TRetagVendaItem.Create( //
      pOrdem: SmallInt; //

      pProd: IProd; //

      pQtd: Currency; //

      FPrecoUnit: Currency;
      FPreco: Currency
  );
begin
  inherited Create(pOrdem, pProd, pQtd, DATA_ZERADA);
end;


function TRetagVendaItem.GetPreco: Currency;
begin
  Result := FPreco;
end;

function TRetagVendaItem.GetPrecoUnit: Currency;
begin
  Result := FPrecoUnit;
end;

procedure TRetagVendaItem.SetPreco(Value: Currency);
begin
  FPreco := Value;
end;

procedure TRetagVendaItem.SetPrecoUnit(Value: Currency);
begin
  FPrecoUnit := Value;
end;

end.
