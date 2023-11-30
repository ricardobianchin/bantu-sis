unit ShopApp.Factory;

interface

uses ShopApp.ShopAppObj, App.AppObj, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog;

function ShopAppCreate(pAppObj: IAppObj; pStatusOutput: IOutput;
  pProcessOutput: IOutput; pProcessLog: IProcessLog): IShopAppObj;

implementation

uses ShopApp.ShopAppObj_u;

function ShopAppCreate(pAppObj: IAppObj; pStatusOutput: IOutput;
  pProcessOutput: IOutput; pProcessLog: IProcessLog): IShopAppObj;
begin
  Result := TShopAppObj.Create(pAppObj, pStatusOutput, pProcessOutput,
    pProcessLog);
end;

end.
