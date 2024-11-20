unit App.PDV.Factory_u;

interface

uses Sis.Entities.Types, App.PDV.CaixaSessao, App.PDV.AppPDVObj, System.Classes,
  App.UI.PDV.Frame_u, Vcl.ComCtrls;

// function CaixaSessaoCreate(pLojaId: TLojaId; pTerminalId: TTerminalId; pId: integer):ICaixaSessao;
function AppPDVObjCreate(pLojaId: TLojaId; pTerminalId: TTerminalId;
  pId: integer): IAppPDVObj;

function PDVFrameCreate(pFrameName: string; AOwner: TComponent;
  pToolBar: TToolBar): TPDVFrame;

implementation

uses App.PDV.CaixaSessao_u, App.PDV.AppPDVObj_u, App.UI.PDV.SessaoAbrir.Frame_u, System.SysUtils;

function CaixaSessaoCreate(pLojaId: TLojaId; pTerminalId: TTerminalId;
  pId: integer): ICaixaSessao;
begin
  Result := TCaixaSessao.Create(pLojaId, pTerminalId, pId);
end;

function AppPDVObjCreate(pLojaId: TLojaId; pTerminalId: TTerminalId;
  pId: integer): IAppPDVObj;
var
  oCaixaSessao: ICaixaSessao;
begin
  oCaixaSessao := CaixaSessaoCreate(pLojaId, pTerminalId, pId);
  Result := TAppPDVObj.Create(oCaixaSessao);
end;

function PDVFrameCreate(pFrameName: string; AOwner: TComponent;
  pToolBar: TToolBar): TPDVFrame;
begin
  Result := Nil;
  pFrameName := UpperCase(pFrameName);
  if pFrameName = 'SESSAOABRIR' then
    Result := TSessaoAbrirPDVFrame.Create(AOwner, pToolBar);
  Result.AjusteControles;
end;

end.
