unit Sis.Threads.ThreadBasCreator_u;

interface

uses Sis.Threads.ThreadBas_u, Sis.Threads.ThreadCreator, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.SafeBool;

type
  TThreadCreator = class(TInterfacedObject, IThreadCreator)
  private
    FExecutando: ISafeBool;
    FThreadTitulo: string;

    FTitOutput: IOutput;
    FStatusOutput: IOutput;
    FProcessLog: IProcessLog;

    FOnTerminate: TNotifyEvent;
  protected
    property ThreadTitulo: string read FThreadTitulo;
    property Executando: ISafeBool read FExecutando;

    property TitOutput: IOutput read FTitOutput;
    property StatusOutput: IOutput read FStatusOutput;
    property ProcessLog: IProcessLog read FProcessLog;
  public
    function ThreadBasCreate: TThreadBas; virtual; abstract;

    constructor Create(pTitOutput: IOutput; pStatusOutput: IOutput;
      pProcessLog: IProcessLog; pOnTerminate: TNotifyEvent; pThreadTitulo: string);
  end;

implementation

uses Sis.Threads.Factory_u;

{ TThreadCreator }

constructor TThreadCreator.Create(pTitOutput: IOutput; pStatusOutput: IOutput;
  pProcessLog: IProcessLog; pOnTerminate: TNotifyEvent; pThreadTitulo: string);
begin
  FExecutando := SafeBoolCreate(False);
  FThreadTitulo := pThreadTitulo;

  FTitOutput := pTitOutput;
  FStatusOutput := pStatusOutput;
  FProcessLog := pProcessLog;

  FOnTerminate := pOnTerminate;
end;

end.
