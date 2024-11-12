unit ShopApp.Threads.ShopAppSyncTermThread.Factory_u;

interface

uses App.Threads.SyncTermThread_AddComandos, Sis.DB.DBTypes, App.AppObj,
  Sis.Entities.Terminal, System.Classes;

function AddComandosProdShop(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;

function AddComandosProdCustoShop(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;

function AddComandosProdPrecoShop(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;

implementation

uses
  ShopApp.Threads.ShopAppSyncTermThread_AddComandos.Prod_u //
  , ShopApp.Threads.ShopAppSyncTermThread_AddComandos.Prod.Custo_u //
  , ShopApp.Threads.ShopAppSyncTermThread_AddComandos.Prod.Preco_u //
  ; //

function AddComandosProdShop(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;
begin
  Result := TSyncTermAddComandosProdShop.Create(pAppObj, pTerminal, pServCon,
    pTermCon, pDBExecScript);
end;

function AddComandosProdCustoShop(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;
begin
  Result := TSyncTermAddComandosProdCustoShop.Create(pAppObj, pTerminal, pServCon,
    pTermCon, pDBExecScript);
end;

function AddComandosProdPrecoShop(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;
begin
  Result := TSyncTermAddComandosProdPrecoShop.Create(pAppObj, pTerminal, pServCon,
    pTermCon, pDBExecScript);
end;

end.
