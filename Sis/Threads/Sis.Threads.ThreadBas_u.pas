unit Sis.Threads.ThreadBas_u;

interface

uses Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.SafeBool;

type
  TThreadBas = class(TThread)
  private
    FThreadTitulo: string;
    FTitOutput: IOutput;
    FStatusOutput: IOutput;
    FProcessLog: IProcessLog;
    FExecutandoSafeBool: ISafeBool;

    function GetExecutando: boolean;
  protected
    property TitOutput: IOutput read FTitOutput;
    property StatusOutput: IOutput read FStatusOutput;
    property ProcessLog: IProcessLog read FProcessLog;
    property ThreadTitulo: string read FThreadTitulo write FThreadTitulo;
    procedure SetExecutando(const Value: boolean);
  public
    constructor Create(pExecutandoSafeBool: ISafeBool;
      pTitOutput: IOutput = nil; pStatusOutput: IOutput = nil;
      pProcessLog: IProcessLog = nil; pThreadTitulo: string = '');
    property Executando: boolean read GetExecutando;//é read-only. só a thread pode alterá-la
  end;

implementation

{ TThreadBas }

uses Sis.Types.strings_u;

constructor TThreadBas.Create(pExecutandoSafeBool: ISafeBool;
  pTitOutput: IOutput; pStatusOutput: IOutput; pProcessLog: IProcessLog;
  pThreadTitulo: string);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FExecutandoSafeBool := pExecutandoSafeBool;
  SetExecutando(False);

  if pThreadTitulo = '' then
    FThreadTitulo := ClassNameToNome(ClassName)
  else
    FThreadTitulo := pThreadTitulo;

  FTitOutput := pTitOutput;
  FStatusOutput := pStatusOutput;
  FProcessLog := pProcessLog;
end;

function TThreadBas.GetExecutando: boolean;
begin
  Result := FExecutandoSafeBool.AsBoolean;
end;

procedure TThreadBas.SetExecutando(const Value: boolean);
begin
  FExecutandoSafeBool.AsBoolean := Value;
end;

end.
