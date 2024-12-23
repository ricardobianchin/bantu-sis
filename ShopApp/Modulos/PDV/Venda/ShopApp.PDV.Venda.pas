unit ShopApp.PDV.Venda;

interface

uses App.PDV.Venda, Sis.Entities.Types, App.Est.Types_u, Sis.Types,
  Sis.Sis.Constants;

type
  IShopPDVVenda = interface(IPDVVenda)
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

end.
