unit App.PDV.Factory_u;

interface

uses Sis.Entities.Types, App.PDV.AppPDVObj, System.Classes,
  App.UI.PDV.Frame_u, Vcl.ComCtrls, App.Est.Venda.CaixaSessaoDM_u, Vcl.Controls,
  Vcl.ActnList, Vcl.Forms, Sis.Types, Sis.Sis.Constants, App.Est.Types_u,
  App.Est.Venda.Caixa.CaixaSessao, App.PDV.Venda, App.PDV.VendaItem;

function AppPDVObjCreate: IAppPDVObj;
function PDVFrameAvisoCreate(pParent: TWinControl; pCaption: TCaption;
  pAction: TAction): TFrame;

function PDVVendaCreate( //
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
  ): IPDVVenda;

function PDVVendaItemCreate(pEstMovOrdem: SmallInt; //
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
  ): IPDVVendaItem;

implementation

uses App.PDV.AppPDVObj_u, App.UI.PDV.Aviso.Frame_u, System.SysUtils,
  App.PDV.Venda_u, App.PDV.VendaItem_u;

function AppPDVObjCreate: IAppPDVObj;
begin
  Result := TAppPDVObj.Create;
end;

function PDVFrameAvisoCreate(pParent: TWinControl; pCaption: TCaption;
  pAction: TAction): TFrame;
begin
  Result := TAvisoPDVFrame.Create(pParent, pCaption, pAction);
end;

function PDVVendaCreate( //
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
  ): IPDVVenda;
begin
  Result := TPDVVenda.Create( //
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

function PDVVendaItemCreate(pEstMovOrdem: SmallInt; //
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
  ): IPDVVendaItem;
begin
  Result := TPDVVendaItem.Create(pEstMovOrdem //
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
