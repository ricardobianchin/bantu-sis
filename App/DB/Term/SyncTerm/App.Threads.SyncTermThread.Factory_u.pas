unit App.Threads.SyncTermThread.Factory_u;

interface

uses App.Threads.SyncTermThread_AddComandos, Sis.DB.DBTypes, App.AppObj,
  Sis.Entities.Terminal, System.Classes;

function AddComandosLoja(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;

function AddComandosTerminal(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;

function AddComandosPagamentoForma(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;

function AddComandosFuncUsu(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;

function AddComandosUsuPode(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;

implementation

uses
  App.Threads.SyncTermThread_AddComandos.Loja_u //
    , App.Threads.SyncTermThread_AddComandos.Terminal_u //
    , App.Threads.SyncTermThread_AddComandos.PagamentoForma_u //
    , App.Threads.SyncTermThread_AddComandos.FuncionarioUsuario_u //
    , App.Threads.SyncTermThread_AddComandos.UsuarioPodeOpcaoSis_u //
    ;

function AddComandosLoja(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;
begin
  Result := TSyncTermAddComandosLoja.Create(pAppObj, pTerminal, pServCon,
    pTermCon, pDBExecScript);
end;

function AddComandosTerminal(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;
begin
  Result := TSyncTermAddComandosTerminal.Create(pAppObj, pTerminal, pServCon,
    pTermCon, pDBExecScript);
end;

function AddComandosPagamentoForma(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;
begin
  Result := TSyncTermAddComandosPagamentoForma.Create(pAppObj, pTerminal,
    pServCon, pTermCon, pDBExecScript);
end;

function AddComandosFuncUsu(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;
begin
  Result := TSyncTermAddComandosFuncionarioUsuario.Create(pAppObj, pTerminal,
    pServCon, pTermCon, pDBExecScript);
end;

function AddComandosUsuPode(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript)
  : ISyncTermAddComandos;
begin
  Result := TSyncTermAddComandosUsuarioPodeOpcaoSis.Create(pAppObj, pTerminal,
    pServCon, pTermCon, pDBExecScript);
end;

end.
