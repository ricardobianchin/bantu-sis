unit App.Threads.AppThread_u;

interface

uses Sis.UI.IO.Output, Sis.DB.Updater.Comando.FB.CreateOrAlterProcedure_u,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.ThreadBas_u,
  App.AppObj, Sis.Threads.SafeBool;

type
  TAppThread = class(TThreadBas)
  private
    FAppObj: IAppObj;
  protected
    property AppObj: IAppObj read FAppObj;
  public
    constructor Create(pAppObj: IAppObj; pExecutando: ISafeBool;
      pTitOutput: IOutput; pStatusOutput: IOutput; pProcessLog: IProcessLog;
      pOnTerminate: TNotifyEvent; pThreadTitulo: string);
  end;

implementation

{ TAppThread }

constructor TAppThread.Create(pAppObj: IAppObj; pExecutando: ISafeBool;
  pTitOutput: IOutput; pStatusOutput: IOutput; pProcessLog: IProcessLog;
  pOnTerminate: TNotifyEvent; pThreadTitulo: string);
begin
  inherited Create(pExecutando, pTitOutput, pStatusOutput, pProcessLog,
    pOnTerminate, pThreadTitulo);
  FAppObj := pAppObj
end;

end.
