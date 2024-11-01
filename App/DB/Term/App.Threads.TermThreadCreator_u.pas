unit App.Threads.TermThreadCreator_u;

interface

uses App.Threads.AppThreadCreator_u, Sis.Threads.ThreadBas_u,
  Sis.Threads.ThreadCreator, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.SafeBool,
  Sis.Entities.Terminal, App.AppObj;

type
  TTermThreadCreator = class(TAppThreadCreator)
  private
    FTerminal: ITerminal;
  protected
    property Terminal: ITerminal read FTerminal;
  public
    constructor Create(pTerminal: ITerminal; pAppObj: IAppObj;
      pExecutandoSafeBool: ISafeBool; pOnTerminate: TNotifyEvent; pTitOutput: IOutput = nil;
      pStatusOutput: IOutput = nil; pProcessLog: IProcessLog = nil;
      pThreadTitulo: string = '');
  end;

implementation

{ TTermThreadCreator }

constructor TTermThreadCreator.Create(pTerminal: ITerminal; pAppObj: IAppObj;
  pExecutandoSafeBool: ISafeBool; pOnTerminate: TNotifyEvent; pTitOutput: IOutput = nil;
  pStatusOutput: IOutput = nil; pProcessLog: IProcessLog = nil;
  pThreadTitulo: string = '');
begin
  inherited Create(pAppObj, pExecutandoSafeBool, pOnTerminate, pTitOutput, pStatusOutput,
    pProcessLog, pThreadTitulo);
  FTerminal := pTerminal;
end;

end.
