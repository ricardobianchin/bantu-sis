unit ShopApp.PDV.Factory_u;

interface

uses App.Est.Venda.Caixa.CaixaSessao, App.PDV.Venda, ShopApp.PDV.Venda,
  ShopApp.PDV.VendaItem, Sis.Entities.Types, App.Est.Types_u, Sis.Sis.Constants,
  Sis.Types;

function ShopPDVVendaCreate( //
  pLojaId: TLojaId; //
  pTerminalId: TTerminalId; //
  pEstMovTipo: TEstMovTipo; //
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

function ShopPDVVendaItemCreate(pEstMovOrdem: SmallInt; //
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
  ): IShopPDVVendaItem;

function VendaAppCastToShopApp(pPdvVenda: IPdvVenda): IShopPDVVenda;

implementation

uses ShopApp.PDV.Venda_u, ShopApp.PDV.VendaItem_u;

function ShopPDVVendaCreate( //
  pLojaId: TLojaId; //
  pTerminalId: TTerminalId; //
  pEstMovTipo: TEstMovTipo; //
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
begin
  Result := TShopPDVVenda.Create( //
    pLojaId //
    , pTerminalId //
    , pEstMovTipo //
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

function ShopPDVVendaItemCreate(pEstMovOrdem: SmallInt; //
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
  ): IShopPDVVendaItem;
begin
  Result := TShopPDVVendaItem.Create(pEstMovOrdem //
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

function VendaAppCastToShopApp(pPdvVenda: IPdvVenda): IShopPDVVenda;
begin
  Result := TShopPDVVenda(pPdvVenda);
end;

end.
