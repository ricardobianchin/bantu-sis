unit ShopApp.PDV.Factory_u;

interface

uses App.Est.Venda.Caixa.CaixaSessao, App.PDV.Venda, ShopApp.PDV.Venda,
  ShopApp.PDV.VendaItem, Sis.Entities.Types, App.Est.Types_u, Sis.Sis.Constants,
  Sis.DB.DBTypes, App.PDV.DBI, ShopApp.PDV.DBI, Sis.Types, ShopApp.PDV.Obj,
  Sis.Terminal, Vcl.Grids, App.AppObj, App.Est.Prod, Sis.UI.Select,
  App.UI.PDV.VendaBasFrame_u, System.Classes, Sis.DBI,
  ShopApp.UI.PDV.Venda.Frame.FitaDraw, App.Loja, App.PDV.Controlador,
  App.UI.PDV.PagFrame_u, Sis.UI.Impressao, App.PDV.Obj;

function ShopPDVVendaCreate( //
  pLoja: IAppLoja; //
  pTerminalId: TTerminalId; //
  pDtHDoc: TDateTime; //
  pEstMovCriadoEm: TDateTime; //
  pCaixaSessao: ICaixaSessao; //

  pVendaId: TId = 0; //
  pC: string = ''; //
  pCustoTotal: Currency = 0; //
  pDescontoTotal: Currency = 0; //
  pTotalLiquido: Currency = 0; //
  pEntregaTem: Boolean = False; //
  pEntregadorId: TId = 0; //
  pEntregaEm: TDateTime = DATA_ZERADA; //
  pVendaAlteradoEm: TDateTime = DATA_ZERADA; //

  pEstMovId: Int64 = 0; //
  pEstMovFinalizado: Boolean = False; //
  pEstMovCancelado: Boolean = False; //
  pEstMovAlteradoEm: TDateTime = DATA_ZERADA; //
  pEstMovFinalizadoEm: TDateTime = DATA_ZERADA; //
  pEstMovCanceladoEm: TDateTime = DATA_ZERADA //
  ): IShopPDVVenda;

function ShopPDVVendaItemCreate( //
  pEstMovOrdem: SmallInt; //
  pProd: IProd; //
  pEstMovQtd: Currency; //

  pBalancaExige: Boolean; //

  pCustoUnit: Currency; //
  pCusto: Currency; //
  pPrecoUnitOriginal: Currency; //
  pPrecoUnitPromo: Currency; //
  pPrecoUnit: Currency; //
  pPrecoBruto: Currency; //
  pDesconto: Currency; //
  pPreco: Currency; //

  pEstMovItemCancelado: Boolean; //
  pEstMovItemCriadoEm: TDateTime; //
  pEstMovItemAlteradoEm: TDateTime; //
  pEstMovItemCanceladoEm: TDateTime //
  ): IShopPDVVendaItem;

function VendaAppCastToShopApp(pPdvVenda: IPdvVenda): IShopPDVVenda;
function DBIAppCastToShopApp(pAppPDVDBI: IAppPDVDBI): IShopAppPDVDBI;

function ShopAppPDVDBICreate(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pPDVObj: IPDVObj; pTerminal: ITerminal; pShopPDVVenda: IShopPDVVenda)
  : IShopAppPDVDBI;

function ShopVendaPDVFrameCreate(AOwner: TComponent; pShopPDVObj: IShopPDVObj;
  pPdvVenda: IPdvVenda; pAppPDVDBI: IAppPDVDBI;
  pPDVControlador: IPDVControlador; pSelect: ISelect): TVendaBasPDVFrame;

function ShopPagPDVFrameCreate(AOwner: TComponent; pShopPDVObj: IShopPDVObj;
  pPdvVenda: IPdvVenda; pAppPDVDBI: IAppPDVDBI;
  pPDVControlador: IPDVControlador): TPagPDVFrame;

function FitaDrawCreate(pVenda: IShopPDVVenda; pStringGrid: TStringGrid)
  : IShopFitaDraw;

function ShopPdvObjCreate(pTerminal: ITerminal): IShopPDVObj;

function ShopProdSelectDBICreate(pDBConnection: IDBConnection; pAppObj: IAppObj): IDBI;

implementation

uses ShopApp.PDV.Venda_u, ShopApp.PDV.VendaItem_u, ShopApp.PDV.DBI_u,
  ShopApp.UI.PDV.VendaFrame_u, ShopApp.UI.PDV.Venda.Frame.FitaDraw_u,
  ShopApp.UI.PDV.PagFrame_u, ShopApp.PDV.Obj_u,
  AppShop.PDV.Prod.ProdSelect.DBI_u;

function ShopPDVVendaCreate( //
  pLoja: IAppLoja; //
  pTerminalId: TTerminalId; //
  pDtHDoc: TDateTime; //
  pEstMovCriadoEm: TDateTime; //
  pCaixaSessao: ICaixaSessao; //

  pVendaId: TId; //
  pC: string; //
  pCustoTotal: Currency; //
  pDescontoTotal: Currency; //
  pTotalLiquido: Currency; //
  pEntregaTem: Boolean; //
  pEntregadorId: TId; //
  pEntregaEm: TDateTime; //
  pVendaAlteradoEm: TDateTime; //

  pEstMovId: Int64; //
  pEstMovFinalizado: Boolean; //
  pEstMovCancelado: Boolean; //
  pEstMovAlteradoEm: TDateTime; //
  pEstMovFinalizadoEm: TDateTime; //
  pEstMovCanceladoEm: TDateTime //
  ): IShopPDVVenda;
begin
  Result := TShopPDVVenda.Create( //
    pLoja //
    , pTerminalId //
    , pDtHDoc //
    , pEstMovCriadoEm //
    , pCaixaSessao //

    , pVendaId //
    , pC //
    , pCustoTotal //
    , pDescontoTotal //
    , pTotalLiquido //
    , pEntregaTem //
    , pEntregadorId //
    , pEntregaEm //
    , pVendaAlteradoEm //

    , pEstMovId //
    , pEstMovFinalizado //
    , pEstMovCancelado //
    , pEstMovAlteradoEm //
    , pEstMovFinalizadoEm //
    , pEstMovCanceladoEm //
    );
end;

function ShopPDVVendaItemCreate( //
  pEstMovOrdem: SmallInt; //
  pProd: IProd; //
  pEstMovQtd: Currency; //

  pBalancaExige: Boolean; //

  pCustoUnit: Currency; //
  pCusto: Currency; //
  pPrecoUnitOriginal: Currency; //
  pPrecoUnitPromo: Currency; //
  pPrecoUnit: Currency; //
  pPrecoBruto: Currency; //
  pDesconto: Currency; //
  pPreco: Currency; //

  pEstMovItemCancelado: Boolean; //
  pEstMovItemCriadoEm: TDateTime; //
  pEstMovItemAlteradoEm: TDateTime; //
  pEstMovItemCanceladoEm: TDateTime //
  ): IShopPDVVendaItem;
begin
  Result := TShopPDVVendaItem.Create( //
    pEstMovOrdem //
    , pProd //
    , pEstMovQtd //

    , pBalancaExige

    , pCustoUnit //
    , pCusto //
    , pPrecoUnitOriginal //
    , pPrecoUnitPromo //
    , pPrecoUnit //
    , pPrecoBruto //
    , pDesconto //
    , pPreco //

    , pEstMovItemCancelado //
    , pEstMovItemCriadoEm //
    , pEstMovItemAlteradoEm //
    , pEstMovItemCanceladoEm //
    );
end;

function VendaAppCastToShopApp(pPdvVenda: IPdvVenda): IShopPDVVenda;
begin
  Result := TShopPDVVenda(pPdvVenda);
end;

function DBIAppCastToShopApp(pAppPDVDBI: IAppPDVDBI): IShopAppPDVDBI;
begin
  Result := TShopAppPDVDBI(pAppPDVDBI);
end;

function ShopAppPDVDBICreate(pDBConnection: IDBConnection; pAppObj: IAppObj;
  pPDVObj: IPDVObj; pTerminal: ITerminal; pShopPDVVenda: IShopPDVVenda)
  : IShopAppPDVDBI;
begin
  Result := TShopAppPDVDBI.Create(pDBConnection, pAppObj, pPDVObj, pTerminal,
    pShopPDVVenda);
end;

function ShopVendaPDVFrameCreate(AOwner: TComponent; pShopPDVObj: IShopPDVObj;
  pPdvVenda: IPdvVenda; pAppPDVDBI: IAppPDVDBI;
  pPDVControlador: IPDVControlador; pSelect: ISelect): TVendaBasPDVFrame;
begin
  Result := TShopVendaPDVFrame.Create(AOwner, pShopPDVObj, pPdvVenda,
    pAppPDVDBI, pPDVControlador, pSelect);
end;

function ShopPagPDVFrameCreate(AOwner: TComponent; pShopPDVObj: IShopPDVObj;
  pPdvVenda: IPdvVenda; pAppPDVDBI: IAppPDVDBI;
  pPDVControlador: IPDVControlador): TPagPDVFrame;
begin
  Result := TShopPagPDVFrame.Create(AOwner, pShopPDVObj, pPdvVenda, pAppPDVDBI,
    pPDVControlador);
end;

function FitaDrawCreate(pVenda: IShopPDVVenda; pStringGrid: TStringGrid)
  : IShopFitaDraw;
begin
  Result := TShopFitaDraw.Create(pVenda, pStringGrid);
end;

function ShopPdvObjCreate(pTerminal: ITerminal): IShopPDVObj;
begin
  Result := TShopPDVObj.Create(pTerminal);
end;

function ShopProdSelectDBICreate(pDBConnection: IDBConnection; pAppObj: IAppObj): IDBI;
begin
  Result := TShopProdSelectDBI.Create(pDBConnection, pAppObj);
end;

end.
