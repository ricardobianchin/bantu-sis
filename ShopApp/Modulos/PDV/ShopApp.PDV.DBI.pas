unit ShopApp.PDV.DBI;

interface

uses Sis.DBI, ShopApp.PDV.VendaItem;

type
  IShopAppPDVDBI = interface(IDBI)
    ['{D68CE23C-D386-407C-B532-D2D017A17580}']
    function ItemCreatePelaStrBusca(pStrBusca: string; out pEncontrou: Boolean;
      out pMensagem: string): IShopPDVVendaItem;
  end;

implementation

end.
