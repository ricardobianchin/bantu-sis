unit Sis.Threads.ThreadBas_u;

interface

uses Sis.UI.IO.Output, Sis.DB.Updater.Comando.FB.CreateOrAlterProcedure_u,
  Sis.UI.IO.Output.ProcessLog, System.Classes;

type
  TThreadBas = class(TThread)
  private
    FTitOutput: IOutput;
    FStatusOutput: IOutput;
    FProcessLog: IProcessLog;
  public
    constructor Create(pTitOutput: IOutput = nil; pStatusOutput: IOutput = nil;
      pProcessLog: IProcessLog = nil);
  end;

implementation

{ TThreadBas }

constructor TThreadBas.Create(pTitOutput, pStatusOutput: IOutput;
  pProcessLog: IProcessLog);
begin
  inherited Create(True);
  FTitOutput := pTitOutput;
  FStatusOutput := pStatusOutput;
  FProcessLog := pProcessLog;
end;

end.
