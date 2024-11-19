unit App.PDV.Factory_u;

interface

uses Sis.Entities.Types, App.PDV.CaixaSessao, App.PDV.AppPDVObj;

// function CaixaSessaoCreate(pLojaId: TLojaId; pTerminalId: TTerminalId; pId: integer):ICaixaSessao;
function AppPDVObjCreate(pLojaId: TLojaId; pTerminalId: TTerminalId;
  pId: integer): IAppPDVObj;

implementation

uses App.PDV.CaixaSessao_u, App.PDV.AppPDVObj_u;

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

end.
