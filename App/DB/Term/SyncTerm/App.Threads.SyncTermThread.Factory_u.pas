unit App.Threads.SyncTermThread.Factory_u;

interface

uses App.Threads.SyncTermThread_ProcLog, Sis.DB.DBTypes, App.AppObj,
  Sis.Entities.Terminal, System.Classes;

function ProcLogLoja(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;

function ProcLogTerminal(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;

function ProcLogPagamentoForma(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;

function ProcLogFuncUsu(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;

function ProcLogUsuPode(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;

implementation

uses
  App.Threads.SyncTermThread_ProcLog.Loja_u //
    , App.Threads.SyncTermThread_ProcLog.Terminal_u //
    , App.Threads.SyncTermThread_ProcLog.PagamentoForma_u //
    , App.Threads.SyncTermThread_ProcLog.FuncionarioUsuario_u //
    , App.Threads.SyncTermThread_ProcLog.UsuarioPodeOpcaoSis_u //
    ;

function ProcLogLoja(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;
begin
  Result := TSyncTermProcLogLoja.Create(pAppObj, pTerminal, pServCon,
    pTermCon, pDBExecScript);
end;

function ProcLogTerminal(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;
begin
  Result := TSyncTermProcLogTerminal.Create(pAppObj, pTerminal, pServCon,
    pTermCon, pDBExecScript);
end;

function ProcLogPagamentoForma(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;
begin
  Result := TSyncTermProcLogPagamentoForma.Create(pAppObj, pTerminal,
    pServCon, pTermCon, pDBExecScript);
end;

function ProcLogFuncUsu(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;
begin
  Result := TSyncTermProcLogFuncionarioUsuario.Create(pAppObj, pTerminal,
    pServCon, pTermCon, pDBExecScript);
end;

function ProcLogUsuPode(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermProcLog;
begin
  Result := TSyncTermProcLogUsuarioPodeOpcaoSis.Create(pAppObj, pTerminal,
    pServCon, pTermCon, pDBExecScript);
end;

end.
