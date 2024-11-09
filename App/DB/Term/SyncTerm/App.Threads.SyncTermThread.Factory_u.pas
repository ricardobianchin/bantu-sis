unit App.Threads.SyncTermThread.Factory_u;

interface

uses App.Threads.SyncTermThread_AddComandos, Sis.DB.DBTypes, App.AppObj,
  Sis.Entities.Terminal, System.Classes;

function AddComandosLoja(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pSql: TStrings): ISyncTermAddComandos;

function AddComandosTerminal(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pSql: TStrings): ISyncTermAddComandos;

implementation

uses
  App.Threads.SyncTermThread_AddComandos.Loja_u //
  , App.Threads.SyncTermThread_AddComandos.Terminal_u //
  ;

function AddComandosLoja(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pSql: TStrings): ISyncTermAddComandos;
begin
  Result := TSyncTermAddComandosLoja.Create(pAppObj, pTerminal, pServCon,
    pTermCon, pSql);
end;

function AddComandosTerminal(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pSql: TStrings): ISyncTermAddComandos;
begin
  Result := TSyncTermAddComandosTerminal.Create(pAppObj, pTerminal, pServCon,
    pTermCon, pSql);
end;

end.
