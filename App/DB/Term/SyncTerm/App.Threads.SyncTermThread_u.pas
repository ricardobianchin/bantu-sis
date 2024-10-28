unit App.Threads.SyncTermThread_u;

interface

uses App.Threads.TermThread_u, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  System.Classes, Sis.Threads.ThreadBas_u, App.AppObj, Sis.Entities.Terminal,
  App.Threads.Thread_u;

type
  TSyncTermThread = class(TTermThread)
  private
  protected
      procedure Execute; override;

  public
    constructor Create(pTerminal: ITerminal; pAppObj: IAppObj;
      pTitOutput: IOutput = nil; pStatusOutput: IOutput = nil;
      pProcessLog: IProcessLog = nil);
  end;

implementation

uses System.SysUtils;

{ TSyncTermThread }

constructor TSyncTermThread.Create(pTerminal: ITerminal; pAppObj: IAppObj;
  pTitOutput, pStatusOutput: IOutput; pProcessLog: IProcessLog);
var
  sThreadTitulo: string;
begin
  sThreadTitulo := 'Sincronização ' + pTerminal.AsText;
  inherited Create(pTerminal, pAppObj, pTitOutput, pStatusOutput, pProcessLog, sThreadTitulo)
end;

procedure TSyncTermThread.Execute;
var
  i: integer;
begin
  inherited;
  for I := 1 to 10 do
  begin
    TitOutput.Exibir(I.ToString);
    Sleep(1000);
  end;
end;

end.
