unit App.PDV.VendaItem_u;

interface

uses App.PDV.VendaItem, App.Est.MoviItem_u, Sis.Types, Sis.Sis.Constants;

type
  TVendaItem = class(TEstMovItem, IVendaItem)
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

{ TVendaItem }

constructor TVendaItem.Create( //
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

function TVendaItem.GetCusto: Currency;
begin

end;

function TVendaItem.GetCustoUnit: Currency;
begin

end;

function TVendaItem.GetDesconto: Currency;
begin

end;

function TVendaItem.GetPreco: Currency;
begin

end;

function TVendaItem.GetPrecoBruto: Currency;
begin

end;

function TVendaItem.GetPrecoUnit: Currency;
begin

end;

function TVendaItem.GetPrecoUnitOriginal: Currency;
begin

end;

function TVendaItem.GetPrecoUnitPromo: Currency;
begin

end;

procedure TVendaItem.SetCusto(Value: Currency);
begin

end;

procedure TVendaItem.SetCustoUnit(Value: Currency);
begin

end;

procedure TVendaItem.SetDesconto(Value: Currency);
begin

end;

procedure TVendaItem.SetPreco(Value: Currency);
begin

end;

procedure TVendaItem.SetPrecoBruto(Value: Currency);
begin

end;

procedure TVendaItem.SetPrecoUnit(Value: Currency);
begin

end;

procedure TVendaItem.SetPrecoUnitOriginal(Value: Currency);
begin

end;

procedure TVendaItem.SetPrecoUnitPromo(Value: Currency);
begin

end;

end.
