unit ShopApp.PDV.DBI_u;

interface

uses ShopApp.PDV.DBI, Sis.DBI_u, ShopApp.PDV.VendaItem;

type
  TShopAppPDVDBI = class(TDBI, IShopAppPDVDBI)
  private
  public
    function ItemCreatePelaStrBusca(pStrBusca: string; out pEncontrou: Boolean;
      out pMensagem: string): IShopPDVVendaItem;
  end;

implementation

{ TShopAppPDVDBI }

function TShopAppPDVDBI.ItemCreatePelaStrBusca(pStrBusca: string;
  out pEncontrou: Boolean; out pMensagem: string): IShopPDVVendaItem;
var
  s: string;
begin

end;

end.
