unit ShopApp.PDV.Venda;

interface

uses App.PDV.Venda, Sis.Entities.Types, App.Est.Types_u, Sis.Types,
  Sis.Sis.Constants, ShopApp.PDV.VendaItem;

type
  IShopPDVVenda = interface(IPDVVenda)
    ['{62DA6C32-4160-47B5-B492-CCD56F626923}']
    function GetVendaItem(Index: integer): IShopPDVVendaItem;
    property VendaItem[Index: integer]: IShopPDVVendaItem read GetVendaItem; default;
  end;

implementation

end.
