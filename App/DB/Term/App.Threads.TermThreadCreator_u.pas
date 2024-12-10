unit App.Threads.TermThreadCreator_u;

interface

uses App.Threads.AppThreadCreator_u, Sis.Threads.ThreadBas_u,
  Sis.Threads.ThreadCreator, Sis.UI.IO.Output, Sis.UI.Frame.Bas.Status_u,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.SafeBool,
  Sis.Entities.Terminal, App.AppObj, Sis.UI.Frame.Status.Thread_u;

type
  TTermThreadCreator = class(TAppThreadCreator)
  private
    FTerminal: ITerminal;
  protected
    property Terminal: ITerminal read FTerminal;
  public
    constructor Create(pTerminal: ITerminal; pAppObj: IAppObj;
      pTitOutput: IOutput; pStatusOutput: IOutput; pProcessLog: IProcessLog;
      pOnTerminate: TNotifyEvent; pThreadTitulo: string);
  end;

implementation

{ TTermThreadCreator }

constructor TTermThreadCreator.Create(pTerminal: ITerminal; pAppObj: IAppObj;
  pTitOutput: IOutput; pStatusOutput: IOutput; pProcessLog: IProcessLog;
  pOnTerminate: TNotifyEvent; pThreadTitulo: string);
begin
  inherited Create(pAppObj, pTitOutput, pStatusOutput, pProcessLog,
    pOnTerminate, pThreadTitulo);
  FTerminal := pTerminal;
end;

end.
