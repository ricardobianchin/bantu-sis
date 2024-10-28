unit App.Threads.Thread_u;

interface

uses Sis.UI.IO.Output, Sis.DB.Updater.Comando.FB.CreateOrAlterProcedure_u,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.ThreadBas_u,
  App.AppObj;

type
  TAppThread = class(TThreadBas)
  private
    FAppObj: IAppObj;
  protected
    property AppObj: IAppObj read FAppObj;
  public
    constructor Create(pAppObj: IAppObj; pTitOutput: IOutput = nil;
      pStatusOutput: IOutput = nil; pProcessLog: IProcessLog = nil);
  end;

implementation

{ TAppThread }

constructor TAppThread.Create(pAppObj: IAppObj; pTitOutput,
  pStatusOutput: IOutput; pProcessLog: IProcessLog);
begin
  inherited Create(pTitOutput, pStatusOutput, pProcessLog);
  FAppObj := pAppObj
end;

end.
