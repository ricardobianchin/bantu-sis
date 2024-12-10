unit App.Threads.AppThreadCreator_u;

interface

uses Sis.Threads.ThreadBasCreator_u, Sis.Threads.ThreadBas_u,
  Sis.Threads.ThreadCreator, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.SafeBool, App.AppObj,
  Sis.UI.Frame.Bas.Status_u;

type
  TAppThreadCreator = class(TThreadCreator)
  private
    FAppObj: IAppObj;
  protected
    property AppObj: IAppObj read FAppObj;
  public
    constructor Create(pAppObj: IAppObj; pTitOutput: IOutput;
      pStatusOutput: IOutput; pProcessLog: IProcessLog;
      pOnTerminate: TNotifyEvent; pThreadTitulo: string);
  end;

implementation

{ TAppThreadCreator }

constructor TAppThreadCreator.Create(pAppObj: IAppObj; pTitOutput: IOutput;
  pStatusOutput: IOutput; pProcessLog: IProcessLog; pOnTerminate: TNotifyEvent;
  pThreadTitulo: string);
begin
  inherited Create(pTitOutput, pStatusOutput, pProcessLog, pOnTerminate,
    pThreadTitulo);
  FAppObj := pAppObj;
end;

end.
