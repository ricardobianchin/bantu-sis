unit Sis.Threads.ThreadBas_u;

interface

uses Sis.UI.IO.Output, Sis.DB.Updater.Comando.FB.CreateOrAlterProcedure_u,
  Sis.UI.IO.Output.ProcessLog, System.Classes;

type
  TThreadBas = class(TThread)
  private
    FThreadTitulo: string;
    FTitOutput: IOutput;
    FStatusOutput: IOutput;
    FProcessLog: IProcessLog;
  protected
    property TitOutput: IOutput read FTitOutput;
    property StatusOutput: IOutput read FStatusOutput;
    property ProcessLog: IProcessLog read FProcessLog;
    property ThreadTitulo: string read FThreadTitulo write FThreadTitulo;
  public
    constructor Create(pTitOutput: IOutput = nil; pStatusOutput: IOutput = nil;
      pProcessLog: IProcessLog = nil; pThreadTitulo: string = '');
  end;

implementation

{ TThreadBas }

uses Sis.Types.strings_u;

constructor TThreadBas.Create(pTitOutput: IOutput; pStatusOutput: IOutput;
  pProcessLog: IProcessLog; pThreadTitulo: string);
begin
  inherited Create(True);
  if pThreadTitulo = '' then
    FThreadTitulo := ClassNameToNome(ClassName)
  else
    FThreadTitulo := pThreadTitulo;

  FTitOutput := pTitOutput;
  FStatusOutput := pStatusOutput;
  FProcessLog := pProcessLog;
end;

end.
