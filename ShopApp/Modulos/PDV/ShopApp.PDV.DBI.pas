unit ShopApp.PDV.DBI;

interface

uses Sis.DBI, ShopApp.PDV.VendaItem, App.Est.Venda.Caixa.CaixaSessao,
  App.PDV.DBI;

type
  IShopAppPDVDBI = interface(IAppPDVDBI)
    ['{D68CE23C-D386-407C-B532-D2D017A17580}']
    function ItemCreatePelaStrBusca(pStrBusca: string; out pEncontrou: Boolean;
      out pMensagem: string): IShopPDVVendaItem;

    procedure CarregueVendaPendente(out pCarregou: Boolean);

    procedure ItemCancelar(pShopPDVVendaItem: IShopPDVVendaItem;
      out pExecutouOk: Boolean; out pMensagem: string);
  end;

implementation

end.
