unit ShopApp.PDV.Venda_u;

interface

uses ShopApp.PDV.Venda, App.PDV.Venda_u, Sis.Entities.Types, App.Est.Types_u,
  Sis.Types, Sis.Sis.Constants;

type
  TShopPDVVenda = class(TPDVVenda, IShopPDVVenda)
    ['{62DA6C32-4160-47B5-B492-CCD56F626923}']
  end;

implementation

end.
