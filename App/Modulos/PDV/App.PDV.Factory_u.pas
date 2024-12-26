unit App.PDV.Factory_u;

interface

uses Sis.Entities.Types, App.PDV.AppPDVObj, System.Classes,
  App.UI.PDV.Frame_u, Vcl.ComCtrls, Vcl.Controls, Vcl.ActnList, Vcl.Forms;

function AppPDVObjCreate: IAppPDVObj;
function PDVFrameAvisoCreate(pParent: TWinControl; pCaption: TCaption;
  pAction: TAction): TPdvFrame;

implementation

uses App.PDV.AppPDVObj_u, App.UI.PDV.Aviso.Frame_u, System.SysUtils;

function AppPDVObjCreate: IAppPDVObj;
begin
  Result := TAppPDVObj.Create;
end;

function PDVFrameAvisoCreate(pParent: TWinControl; pCaption: TCaption;
  pAction: TAction): TPdvFrame;
begin
  Result := TAvisoPDVFrame.Create(pParent, pCaption, pAction);
end;

end.
