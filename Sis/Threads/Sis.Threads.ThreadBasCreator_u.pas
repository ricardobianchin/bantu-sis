unit Sis.Threads.ThreadBasCreator_u;

interface

uses Sis.Threads.ThreadBas_u, Sis.Threads.ThreadCreator, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.SafeBool;

type
  TThreadCreator = class(TInterfacedObject, IThreadCreator)
  private
    FExecutando: ISafeBool;
    FTitOutput: IOutput;
    FStatusOutput: IOutput;
    FProcessLog: IProcessLog;
    FThreadTitulo: string;
    FOnTerminate: TNotifyEvent;
  protected
    property Executando: ISafeBool read FExecutando;
    property TitOutput: IOutput read FTitOutput;
    property StatusOutput: IOutput read FStatusOutput;
    property ProcessLog: IProcessLog read FProcessLog;
    property ThreadTitulo: string read FThreadTitulo;

  public
    property OnTerminate: TNotifyEvent read FOnTerminate;
    function TThreadBasCreate: TThreadBas; virtual;
    constructor Create(pExecutando: ISafeBool; pOnTerminate: TNotifyEvent; pTitOutput: IOutput = nil;
      pStatusOutput: IOutput = nil; pProcessLog: IProcessLog = nil;
      pThreadTitulo: string = '');
  end;

implementation

{ TThreadCreator }

constructor TThreadCreator.Create(pExecutando: ISafeBool; pOnTerminate: TNotifyEvent;
  pTitOutput, pStatusOutput: IOutput; pProcessLog: IProcessLog;
  pThreadTitulo: string);
begin
  FExecutando := pExecutando;
  FOnTerminate := pOnTerminate;
  FTitOutput := pTitOutput;
  FStatusOutput := pStatusOutput;
  FProcessLog := pProcessLog;
  FThreadTitulo := pThreadTitulo;

  FTitOutput.Exibir(FThreadTitulo);
  FStatusOutput.Exibir('Parado');

end;

function TThreadCreator.TThreadBasCreate: TThreadBas;
begin
  Result := TThreadBas.Create(FExecutando, FTitOutput, FStatusOutput,
    FProcessLog, FThreadTitulo);
  Result.OnTerminate := OnTerminate;
end;

end.
