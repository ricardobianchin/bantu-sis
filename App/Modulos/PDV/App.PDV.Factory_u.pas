unit App.PDV.Factory_u;

interface

uses Sis.Entities.Types, System.Classes, Sis.Types,
  App.UI.PDV.Frame_u, Vcl.ComCtrls, Vcl.Controls, Vcl.ActnList, Vcl.Forms,
  App.PDV.VendaPag.List, App.PDV.VendaPag;

function PDVFrameAvisoCreate(pParent: TWinControl; pCaption: TCaption;
  pAction: TAction): TPdvFrame;

function VendaPagListCreate: IVendaPagList;

function VendaPagCreate(AOrdem: SmallInt; APagamentoFormaId: TId;
  APagamentoFormaTipoId: string; APagamentoFormaTipoDescrRed: string;
  APagamentoFormaDescr: string; AValorDevido, AValorEntregue, ATroco: Currency;
  ACancelado: Boolean): IVendaPag;

implementation

uses App.UI.PDV.Aviso.Frame_u, System.SysUtils,
  App.PDV.VendaPag.List_u, App.PDV.VendaPag_u;

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

end.
