unit ShopApp.Threads.ShopAppSyncTermThread.Factory_u;

interface

uses App.Threads.SyncTermThread_ProcLog, Sis.DB.DBTypes, App.AppObj,
  Sis.Entities.Terminal, System.Classes, Sis.Threads.SafeBool,
  Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog;

function ProcLogProdShop(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;

function ProcLogProdCustoShop(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;

function ProcLogProdPrecoShop(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;

implementation

uses
  ShopApp.Threads.ShopAppSyncTermThread_ProcLog.Prod_u //
    , ShopApp.Threads.ShopAppSyncTermThread_ProcLog.Prod.Custo_u //
    , ShopApp.Threads.ShopAppSyncTermThread_ProcLog.Prod.Preco_u //
    ; //

function ProcLogProdShop(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;
begin
  Result := TSyncTermProcLogProdShop.Create(pAppObj, pTerminal, pServCon,
    pTermCon, pDBExecScript);
end;

function ProcLogProdCustoShop(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;
begin
  Result := TSyncTermProcLogProdCustoShop.Create(pAppObj, pTerminal, pServCon,
    pTermCon, pDBExecScript);
end;

function ProcLogProdPrecoShop(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;
begin
  Result := TSyncTermProcLogProdPrecoShop.Create(pAppObj, pTerminal, pServCon,
    pTermCon, pDBExecScript);
end;

end.
