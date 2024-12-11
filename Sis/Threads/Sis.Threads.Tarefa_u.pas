unit Sis.Threads.Tarefa_u;

interface

uses Sis.Threads.Tarefa, Sis.UI.Frame.Status.Thread_u,
  Sis.Threads.SafeBool, Sis.Threads.ThreadBas_u;

type
  TTarefa = class(TInterfacedObject, ITarefa)
  private
    FFrame: TThreadStatusFrame;
    FExecutando: ISafeBool;
    FThread: TThreadBas;
    FThreadInicializada: Boolean;
  protected
    function GetThreadTitulo: string; virtual; abstract;
    property ThreadTitulo: string read GetThreadTitulo;
    property Frame: TThreadStatusFrame read FFrame;
    property Executando: ISafeBool read FExecutando;

    procedure DoThreadTerminate(Sender: TObject); virtual;
    function ThreadCreate: TThreadBas; virtual; abstract;
  public
    procedure Execute; virtual;
    procedure Terminate; virtual;
    procedure EspereTerminar; virtual;

    constructor Create(pFrame: TThreadStatusFrame);
  end;

implementation

uses Sis.Threads.Factory_u, System.SysUtils;

{ TTarefa }

constructor TTarefa.Create(pFrame: TThreadStatusFrame);
begin
  FExecutando := SafeBoolCreate(False);
  FFrame := pFrame;
  FThreadInicializada := False;
end;

procedure TTarefa.DoThreadTerminate(Sender: TObject);
begin
  FFrame.StatusLabel.Caption := 'Terminado';
  FThreadInicializada := False;
  // FThread
end;

procedure TTarefa.EspereTerminar;
begin
  repeat
    if not Executando.AsBoolean then
      Exit;

    if not FThreadInicializada then
      Exit;

    Sleep(500);
  until (True);
end;

procedure TTarefa.Execute;
begin
  if Executando.AsBoolean then
    Exit;

  if FThreadInicializada then
    Exit;

  FFrame.StatusLabel.Caption := 'Iniciando';
  FThread := ThreadCreate;
  FThreadInicializada := True;
  FThread.Resume;
end;

procedure TTarefa.Terminate;
begin
  if not FThreadInicializada then
    Exit;
  if not Executando.AsBoolean then
    Exit;

  FThread.Terminate;
end;

end.
