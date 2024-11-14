unit AppShop.PDV.Preco.PrecoBusca.Factory_u;

interface

uses Sis.DBI, Sis.DB.DBTypes, App.AppObj;

function ShopPrecoBuscaDBICreate(pDBConnection: IDBConnection; pAppObj: IAppObj): IDBI;

implementation

uses AppShop.PDV.Preco.PrecoBusca.DBI_u;

function ShopPrecoBuscaDBICreate(pDBConnection: IDBConnection; pAppObj: IAppObj): IDBI;
begin
  Result := TShopPrecoBuscaDBI.Create(pDBConnection, pAppObj);
end;

end.
