unit Sis.Threads.Tarefa_u;

interface

uses Sis.Threads.Tarefa, Sis.UI.Frame.Status.Thread_u,
  Sis.Threads.ThreadCreator, Sis.Threads.SafeBool;

type
  TTarefa = class(TInterfacedObject, ITarefa)
  private
    FFrame: TThreadStatusFrame;
    FCreator: IThreadCreator;
    FExecutando: ISafeBool;
    procedure OnThreadTerminate(Sender: TObject);
  public
    constructor Create(pFrame: TThreadStatusFrame; pCreator: IThreadCreator);
  end;

implementation

uses Sis.Threads.Factory_u;

{ TTarefa }

constructor TTarefa.Create(pFrame: TThreadStatusFrame;
  pCreator: IThreadCreator);
begin
  FExecutando := SafeBoolCreate(False);
  FFrame := pFrame;
  FCreator := pCreator;
end;

procedure TTarefa.OnThreadTerminate(Sender: TObject);
begin
  FFrame.StatusLabel.Caption := 'Terminado';
end;

end.
