unit App.PDV.Factory_u;

interface

uses Sis.Entities.Types, App.PDV.CaixaSessao, App.PDV.AppPDVObj, System.Classes,
  App.UI.PDV.Frame_u, Vcl.ComCtrls, App.Est.Venda.CaixaSessaoDM_u, Vcl.Controls,
  Vcl.ActnList, Vcl.Forms;

function AppPDVObjCreate: IAppPDVObj;
function PDVFrameAvisoCreate(pParent: TWinControl; pCaption: TCaption;
  pAction: TAction): TFrame;

implementation

uses App.PDV.CaixaSessao_u, App.PDV.AppPDVObj_u, App.UI.PDV.Aviso.Frame_u,
  System.SysUtils;

function CaixaSessaoCreate(pLojaId: TLojaId; pTerminalId: TTerminalId;
  pId: integer): ICaixaSessao;
begin
  Result := TCaixaSessao.Create(pLojaId, pTerminalId, pId);
end;

function AppPDVObjCreate: IAppPDVObj;
begin
  Result := TAppPDVObj.Create;
end;

function PDVFrameAvisoCreate(pParent: TWinControl; pCaption: TCaption;
  pAction: TAction): TFrame;
begin
  Result := TAvisoPDVFrame.Create(pParent, pCaption, pAction);
end;

end.
