unit App.Threads.SyncTermThread_u;

interface

uses App.Threads.TermThread_u, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  System.Classes, Sis.Threads.ThreadBas_u, App.AppObj, Sis.Entities.Terminal,
  Sis.Threads.SafeBool, Sis.DB.Factory, Sis.DB.DBTypes, App.DB.Utils,
  Sis.Sis.Constants;

type
  TAppSyncTermThread = class(TTermThread)
  private
    FServCon, FTermCon: IDBConnection;
    function Conectou: boolean;
    procedure FecharConexoes;
  protected
    procedure Execute; override;
    procedure SyncLoja; virtual;

  public
    constructor Create(pTerminal: ITerminal; pAppObj: IAppObj;
      pExecutandoSafeBool: ISafeBool; pTitOutput: IOutput = nil;
      pStatusOutput: IOutput = nil; pProcessLog: IProcessLog = nil);
  end;

implementation

uses System.SysUtils, Sis.Config.SisConfig;

{ TAppSyncTermThread }

function TAppSyncTermThread.Conectou: boolean;
var
  s: ISisConfig;
  rDBConnectionParams: TDBConnectionParams;

begin
  s := AppObj.SisConfig;

  rDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, AppObj);

  FServCon := DBConnectionCreate('TAppSyncTermThread.serv.con', s,
    rDBConnectionParams, ProcessLog, StatusOutput);

  rDBConnectionParams.Server := Terminal.NomeNaRede;
  rDBConnectionParams.Arq := Terminal.LocalArqDados;
  rDBConnectionParams.Database := Terminal.Database;

  FTermCon:= DBConnectionCreate('TAppSyncTermThread.term.con', s,
    rDBConnectionParams, ProcessLog, StatusOutput);

  Result := FServCon.Abrir;
  if not Result then
    exit;

  Result := FTermCon.Abrir;
  if not Result then
  begin
    FServCon.Fechar;
    exit;
  end;
end;

constructor TAppSyncTermThread.Create(pTerminal: ITerminal; pAppObj: IAppObj;
  pExecutandoSafeBool: ISafeBool; pTitOutput: IOutput; pStatusOutput: IOutput;
  pProcessLog: IProcessLog);
var
  sThreadTitulo: string;
begin
  sThreadTitulo := 'Sincronização ' + pTerminal.AsText;
  inherited Create(pTerminal, pAppObj, pExecutandoSafeBool, pTitOutput,
    pStatusOutput, pProcessLog, sThreadTitulo)
end;

procedure TAppSyncTermThread.Execute;
var
  i, m: integer;
begin
  inherited;
  if Terminated then
    exit;
  if not Conectou then
    exit;
  try
    if Terminated then
      exit;
    StatusOutput.Exibir('Iniciou')
  finally
    FecharConexoes;
  end;
  {
  m := 5 + random(10);
  for i := 1 to m do
  begin
    OutputSafe(StatusOutput, i.ToString + '/' + m.ToString);
    if Terminated then
      break;
    Sleep(1000);
  end;
  }
end;

procedure TAppSyncTermThread.FecharConexoes;
begin
  FServCon.Fechar;
  FServCon.Fechar;
end;

procedure TAppSyncTermThread.SyncLoja;
begin
Terminal.Database
  SyncLoja(FServCon, FTermCon, appobj.CriticalSections.ServerDB,, pTermCrit: TFixecCriticalSection);

end;

end.
