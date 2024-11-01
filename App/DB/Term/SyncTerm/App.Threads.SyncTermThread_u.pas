unit App.Threads.SyncTermThread_u;

interface

uses App.Threads.TermThread_u, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  System.Classes, Sis.Threads.ThreadBas_u, App.AppObj, Sis.Entities.Terminal,
  Sis.Threads.SafeBool;

type
  TAppSyncTermThread = class(TTermThread)
  private
  protected
    procedure Execute; override;

  public
    constructor Create(pTerminal: ITerminal; pAppObj: IAppObj;
      pExecutandoSafeBool: ISafeBool; pTitOutput: IOutput = nil;
      pStatusOutput: IOutput = nil; pProcessLog: IProcessLog = nil);
  end;

implementation

uses System.SysUtils;

{ TAppSyncTermThread }

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
  m := 5+random(10);
  for i := 1 to m do
  begin
    OutputSafe(StatusOutput, i.ToString+'/'+m.ToString);
    if Terminated then
      break;
    Sleep(1000);
  end;
end;

end.
