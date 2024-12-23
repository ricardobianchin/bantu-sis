unit App.PDV.VendaItem_u;

interface

uses App.PDV.VendaItem, App.Est.MoviItem_u, Sis.Types, Sis.Sis.Constants;

type
  TPDVVendaItem = class(TEstMovItem, IPDVVendaItem)
  private
    FCustoUnit: Currency;
    FCusto: Currency;
    FPrecoUnitOriginal: Currency;
    FPrecoUnitPromo: Currency;
    FPrecoUnit: Currency;
    FPrecoBruto: Currency;
    FDesconto: Currency;
    FPreco: Currency;

    function GetCustoUnit: Currency;
    procedure SetCustoUnit(Value: Currency);

    function GetCusto: Currency;
    procedure SetCusto(Value: Currency);

    function GetPrecoUnitOriginal: Currency;
    procedure SetPrecoUnitOriginal(Value: Currency);

    function GetPrecoUnitPromo: Currency;
    procedure SetPrecoUnitPromo(Value: Currency);

    function GetPrecoUnit: Currency;
    procedure SetPrecoUnit(Value: Currency);

    function GetPrecoBruto: Currency;
    procedure SetPrecoBruto(Value: Currency);

    function GetDesconto: Currency;
    procedure SetDesconto(Value: Currency);

    function GetPreco: Currency;
    procedure SetPreco(Value: Currency);
  public
    property CustoUnit: Currency read GetCustoUnit write SetCustoUnit;
    property Custo: Currency read GetCusto write SetCusto;
    property PrecoUnitOriginal: Currency read GetPrecoUnitOriginal
      write SetPrecoUnitOriginal;
    property PrecoUnitPromo: Currency read GetPrecoUnitPromo
      write SetPrecoUnitPromo;
    property PrecoUnit: Currency read GetPrecoUnit write SetPrecoUnit;
    property PrecoBruto: Currency read GetPrecoBruto write SetPrecoBruto;
    property Desconto: Currency read GetDesconto write SetDesconto;
    property Preco: Currency read GetPreco write SetPreco;

    constructor Create( //
      pEstMovOrdem: SmallInt; //
      pEstMovProdId: TId; //
      pEstMovQtd: Currency; //

      pCustoUnit: Currency; //
      pCusto: Currency; //
      pPrecoUnitOriginal: Currency; //
      pPrecoUnitPromo: Currency; //
      pPrecoUnit: Currency; //
      pPrecoBruto: Currency; //
      pDesconto: Currency; //
      pPreco: Currency; //

      pEstMovCancelado: Boolean = False; //
      pEstMovCriadoEm: TDateTime = DATA_ZERADA; //
      pEstMovAlteradoEm: TDateTime = DATA_ZERADA; //
      pEstMovCanceladoEm: TDateTime = DATA_ZERADA //
      );
  end;

implementation

{ TPDVVendaItem }

constructor TPDVVendaItem.Create( //
  pEstMovOrdem: SmallInt; //
  pEstMovProdId: TId; //
  pEstMovQtd: Currency; //

  pCustoUnit: Currency; //
  pCusto: Currency; //
  pPrecoUnitOriginal: Currency; //
  pPrecoUnitPromo: Currency; //
  pPrecoUnit: Currency; //
  pPrecoBruto: Currency; //
  pDesconto: Currency; //
  pPreco: Currency; //

  pEstMovCancelado: Boolean; //
  pEstMovCriadoEm: TDateTime; //
  pEstMovAlteradoEm: TDateTime; //
  pEstMovCanceladoEm: TDateTime //
  );
begin
  inherited Create(
    pEstMovOrdem //
    , pEstMovProdId //
    , pEstMovQtd //
    , pEstMovCriadoEm //
    , pEstMovCancelado //
    , pEstMovAlteradoEm //
    , pEstMovCanceladoEm //
    );

  FCustoUnit := pCustoUnit;
  FCusto := pCusto;
  FPrecoUnitOriginal := pPrecoUnitOriginal;
  FPrecoUnitPromo := pPrecoUnitPromo;
  FPrecoUnit := pPrecoUnit;
  FPrecoBruto := pPrecoBruto;
  FDesconto := pDesconto;
  FPreco := pPreco;
end;

function TPDVVendaItem.GetCusto: Currency;
begin
  Result := FCusto;
end;

function TPDVVendaItem.GetCustoUnit: Currency;
begin
  Result := FCustoUnit;
end;

function TPDVVendaItem.GetDesconto: Currency;
begin
  Result := FDesconto;
end;

function TPDVVendaItem.GetPreco: Currency;
begin
  Result := FPreco;
end;

function TPDVVendaItem.GetPrecoBruto: Currency;
begin
  Result := FPrecoBruto;
end;

function TPDVVendaItem.GetPrecoUnit: Currency;
begin
  Result := FPrecoUnit;
end;

function TPDVVendaItem.GetPrecoUnitOriginal: Currency;
begin
  Result := FPrecoUnitOriginal;
end;

function TPDVVendaItem.GetPrecoUnitPromo: Currency;
begin
  Result := FPrecoUnitPromo;
end;

procedure TPDVVendaItem.SetCusto(Value: Currency);
begin
  FCusto := Value;
end;

procedure TPDVVendaItem.SetCustoUnit(Value: Currency);
begin
  FCustoUnit := Value;
end;

procedure TPDVVendaItem.SetDesconto(Value: Currency);
begin
  FDesconto := Value;
end;

procedure TPDVVendaItem.SetPreco(Value: Currency);
begin
  FPreco := Value;
end;

procedure TPDVVendaItem.SetPrecoBruto(Value: Currency);
begin
  FPrecoBruto := Value;
end;

procedure TPDVVendaItem.SetPrecoUnit(Value: Currency);
begin
  FPrecoUnit := Value;
end;

procedure TPDVVendaItem.SetPrecoUnitOriginal(Value: Currency);
begin
  FPrecoUnitOriginal := Value;
end;

procedure TPDVVendaItem.SetPrecoUnitPromo(Value: Currency);
begin
  FPrecoUnitPromo := Value;
end;

end.
