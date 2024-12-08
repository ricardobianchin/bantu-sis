unit App.Threads.TermThread_u;

interface

uses Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, System.Classes,
  Sis.Threads.ThreadBas_u, App.AppObj, Sis.Entities.Terminal,
  App.Threads.AppThread_u, Sis.Threads.SafeBool;

type
  TTermThread = class(TAppThread)
  private
    FTerminal: ITerminal;
  protected
    property Terminal: ITerminal read FTerminal;
  public
    constructor Create(pTerminal: ITerminal; pAppObj: IAppObj; pExecutando: ISafeBool;
      pTitOutput: IOutput; pStatusOutput: IOutput; pProcessLog: IProcessLog;
      pThreadTitulo: string = '');
  end;

implementation

{ TTermThread }

constructor TTermThread.Create(pTerminal: ITerminal; pAppObj: IAppObj; pExecutando: ISafeBool;
      pTitOutput: IOutput; pStatusOutput: IOutput; pProcessLog: IProcessLog;
      pThreadTitulo: string);
begin
  inherited Create(pAppObj, pExecutando, pTitOutput, pStatusOutput, pProcessLog,
    pThreadTitulo);
  FTerminal := pTerminal;
end;

end.
