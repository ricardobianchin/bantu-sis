unit ShopApp.PDV.Venda_u;

interface

uses ShopApp.PDV.Venda, App.PDV.Venda_u, Sis.Entities.Types, App.Est.Types_u,
  Sis.Types, Sis.Sis.Constants;

type
  TShopPDVVenda = class(TPDVVenda, IShopPDVVenda)
    ['{62DA6C32-4160-47B5-B492-CCD56F626923}']
    function PegueItem( //
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
      ): integer;

  end;

implementation

uses ShopApp.PDV.VendaItem, ShopApp.PDV.Factory_u;

{ TShopPDVVenda }

function TShopPDVVenda.PegueItem(pEstMovOrdem: SmallInt; pEstMovProdId: TId;
  pEstMovQtd, pCustoUnit, pCusto, pPrecoUnitOriginal, pPrecoUnitPromo,
  pPrecoUnit, pPrecoBruto, pDesconto, pPreco: Currency;
  pEstMovCancelado: Boolean; pEstMovCriadoEm, pEstMovAlteradoEm,
  pEstMovCanceladoEm: TDateTime): integer;
var
  oItem: IShopPdvVendaItem;
begin
  oItem := ShopPdvVendaItemCreate(pEstMovOrdem //
    , pEstMovProdId //
    , pEstMovQtd //

    , pCustoUnit //
    , pCusto //
    , pPrecoUnitOriginal //
    , pPrecoUnitPromo //
    , pPrecoUnit //
    , pPrecoBruto //
    , pDesconto //
    , pPreco //

    , pEstMovCancelado //
    , pEstMovCriadoEm //
    , pEstMovAlteradoEm //
    , pEstMovCanceladoEm //
    );
end;

end.
