unit App.PDV.Factory_u;

interface

uses Sis.Entities.Types, System.Classes, Sis.Types, App.PDV.UI.Gaveta,
  App.UI.PDV.Frame_u, Vcl.ComCtrls, Vcl.Controls, Vcl.ActnList, Vcl.Forms,
  App.PDV.VendaPag.List, App.PDV.VendaPag, Sis.Terminal, App.PDV.Obj,
  App.PDV.CupomEspelho, App.AppObj, Sis.UI.Impressao, App.PDV.Venda,
  App.PDV.ImpressaoTextoVenda_u, App.PDV.UI.Balanca;

function PDVFrameAvisoCreate(pParent: TWinControl; pPDVObj: IPDVObj;
  pCaption: TCaption; pAction: TAction): TPdvFrame;

function VendaPagListCreate: IVendaPagList;

function VendaPagCreate(AOrdem: SmallInt; APagamentoFormaId: TId;
  APagamentoFormaTipoId: string; APagamentoFormaTipoDescrRed: string;
  APagamentoFormaDescr: string; AValorDevido, AValorEntregue, ATroco: Currency;
  ACancelado: Boolean): IVendaPag;

function GavetaNaoTemCreate: IGaveta;
function GavetaWinCreate(pTerminal: ITerminal): IGaveta;
function GavetaCreate(pTerminal: ITerminal): IGaveta;

function BalancaTesteCreate: IBalanca;

//function CupomEspelhoCreate(pAppObj: IAppObj; pTipoCupom: string): ICupomEspelho;
function CupomEspelhoVendaCreate(pAppObj: IAppObj): ICupomEspelho;
function ImpressaoTextoVendaCreate(pImpressoraNome, pDocTitulo: string;
  pAppObj: IAppObj; pTerminal: ITerminal; pPDVVenda: IPDVVenda): IImpressao;


implementation

uses System.SysUtils, App.PDV.VendaPag.List_u //

    , App.UI.PDV.Aviso.Frame_u //
    , App.PDV.VendaPag_u //

    , App.PDV.UI.Gaveta.NaoTem_u //
    , App.PDV.UI.Gaveta.Win_u //

    , App.PDV.UI.Balanca.Teste_u //

    , App.Pdv.CupomEspelho_u //

    ;

function PDVFrameAvisoCreate(pParent: TWinControl; pPDVObj: IPDVObj;
  pCaption: TCaption; pAction: TAction): TPdvFrame;
begin
  Result := TAvisoPDVFrame.Create(pParent, pPDVObj, pCaption, pAction);
end;

function VendaPagListCreate: IVendaPagList;
begin
  Result := TVendaPagList.Create;
end;

function VendaPagCreate(AOrdem: SmallInt; APagamentoFormaId: TId;
  APagamentoFormaTipoId: string; APagamentoFormaTipoDescrRed: string;
  APagamentoFormaDescr: string; AValorDevido, AValorEntregue, ATroco: Currency;
  ACancelado: Boolean): IVendaPag;
begin
  Result := TVendaPag.Create(AOrdem, APagamentoFormaId, APagamentoFormaTipoId,
    APagamentoFormaTipoDescrRed, APagamentoFormaDescr, AValorDevido,
    AValorEntregue, ATroco, ACancelado);
end;

function GavetaNaoTemCreate: IGaveta;
begin
  Result := TGavetaNaoTem.Create;
end;

function GavetaWinCreate(pTerminal: ITerminal): IGaveta;
begin
  Result := TGavetaWin.Create(pTerminal);
end;

function GavetaCreate(pTerminal: ITerminal): IGaveta;
begin
  if pTerminal.GavetaTem then
  begin
    Result := GavetaWinCreate(pTerminal)
  end
  else
  begin
    Result := GavetaNaoTemCreate;
  end;
end;

function CupomEspelhoCreate(pAppObj: IAppObj; pTipoCupom: string): ICupomEspelho;
begin
  Result := TCupomEspelho.Create(pAppObj, pTipoCupom);
end;

function CupomEspelhoVendaCreate(pAppObj: IAppObj): ICupomEspelho;
begin
  Result := TCupomEspelho.Create(pAppObj, 'Venda');
end;

function ImpressaoTextoVendaCreate(pImpressoraNome, pDocTitulo: string;
  pAppObj: IAppObj; pTerminal: ITerminal; pPDVVenda: IPDVVenda): IImpressao;
begin
  Result := TImpressaoTextoPDVVenda.Create(pImpressoraNome, pDocTitulo,
    pAppObj, pTerminal, pPDVVenda);
end;

function BalancaTesteCreate: IBalanca;
begin
  Result := TBalancaTeste.Create;
end;

end.
