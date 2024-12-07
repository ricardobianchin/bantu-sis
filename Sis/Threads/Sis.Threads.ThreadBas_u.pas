unit Sis.Threads.ThreadBas_u;

interface

uses System.Classes, Sis.Threads.SafeBool, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog;

type
  TThreadBas = class(TThread)
  private
    FThreadTitulo: string;

    FExecutandoSafeBool: ISafeBool;

    FTitOutput: IOutput;
    FStatusOutput: IOutput;
    FProcessLog: IProcessLog;

    function GetExecutando: Boolean;
    procedure SetExecutando(const Value: Boolean);
  protected
    property ThreadTitulo: string read FThreadTitulo write FThreadTitulo;

    property TitOutput: IOutput read FTitOutput;
    property StatusOutput: IOutput read FStatusOutput;
    property ProcessLog: IProcessLog read FProcessLog;

    property Executando: Boolean read GetExecutando write SetExecutando;
  public
    constructor Create(pExecutando: ISafeBool; pTitOutput: IOutput;
      pStatusOutput: IOutput; pProcessLog: IProcessLog;
      pThreadTitulo: string = '');
  end;

implementation

{ TThreadBas }

uses Sis.Types.strings_u;

constructor TThreadBas.Create(pExecutando: ISafeBool; pTitOutput: IOutput;
  pStatusOutput: IOutput; pProcessLog: IProcessLog; pThreadTitulo: string);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FExecutandoSafeBool := pExecutando;
  Executando := False;

  if pThreadTitulo = '' then
    FThreadTitulo := ClassNameToNome(ClassName)
  else
    FThreadTitulo := pThreadTitulo;
end;

function TThreadBas.GetExecutando: Boolean;
begin
  Result := FExecutandoSafeBool.AsBoolean
end;

procedure TThreadBas.SetExecutando(const Value: Boolean);
begin
  FExecutandoSafeBool.AsBoolean := Value;
end;

end.
