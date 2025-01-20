unit App.PDV.Factory_u;

interface

uses Sis.Entities.Types, System.Classes, Sis.Types, App.PDV.UI.Gaveta,
  App.UI.PDV.Frame_u, Vcl.ComCtrls, Vcl.Controls, Vcl.ActnList, Vcl.Forms,
  App.PDV.VendaPag.List, App.PDV.VendaPag, Sis.Entities.Terminal;

function PDVFrameAvisoCreate(pParent: TWinControl; pCaption: TCaption;
  pAction: TAction): TPdvFrame;

function VendaPagListCreate: IVendaPagList;

function VendaPagCreate(AOrdem: SmallInt; APagamentoFormaId: TId;
  APagamentoFormaTipoId: string; APagamentoFormaTipoDescrRed: string;
  APagamentoFormaDescr: string; AValorDevido, AValorEntregue, ATroco: Currency;
  ACancelado: Boolean): IVendaPag;

function GavetaNaoTemCreate: IGaveta;
function GavetaWinCreate(pTerminal: ITerminal): IGaveta;
function GavetaCreate(pTerminal: ITerminal): IGaveta;

implementation

uses System.SysUtils, App.PDV.VendaPag.List_u//

  , App.UI.PDV.Aviso.Frame_u//
  , App.PDV.VendaPag_u//

  ,App.PDV.UI.Gaveta.NaoTem_u//
  , App.PDV.UI.Gaveta.Win_u//

  ;

function PDVFrameAvisoCreate(pParent: TWinControl; pCaption: TCaption;
  pAction: TAction): TPdvFrame;
begin
  Result := TAvisoPDVFrame.Create(pParent, pCaption, pAction);
end;

function VendaPagListCreate: IVendaPagList;
begin
  Result := TVendaPagList.Create;
end;

function VendaPagCreate(AOrdem: SmallInt; APagamentoFormaId: TId;
  APagamentoFormaTipoId: string; APagamentoFormaTipoDescrRed: string;
  APagamentoFormaDescr: string; AValorDevido, AValorEntregue, ATroco: Currency;
  ACancelado: Boolean)
  : IVendaPag;
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

end.
