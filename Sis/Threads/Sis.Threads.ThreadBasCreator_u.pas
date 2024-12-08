unit Sis.Threads.ThreadBasCreator_u;

interface

uses Sis.Threads.ThreadBas_u, Sis.Threads.ThreadCreator, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.SafeBool,
  Sis.Threads.Factory_u, Sis.UI.Frame.Status.Thread_u;

type
  TThreadCreator = class(TInterfacedObject, IThreadCreator)
  private
    FThreadStatusFrame: TThreadStatusFrame;
    FExecutando: ISafeBool;
    FThreadTitulo: string;
  protected
    property Executando: ISafeBool read FExecutando;
    property ThreadTitulo: string read FThreadTitulo;
    property ThreadStatusFrame: TThreadStatusFrame read FThreadStatusFrame;

  public
    function ThreadBasCreate: TThreadBas; virtual; abstract;
    constructor Create(pThreadStatusFrame: TThreadStatusFrame;
      pThreadTitulo: string = '');
  end;

implementation

{ TThreadCreator }

constructor TThreadCreator.Create(pThreadStatusFrame: TThreadStatusFrame;
  pThreadTitulo: string);
begin
  FExecutando := SafeBoolCreate(False);
  FThreadStatusFrame := pThreadStatusFrame;
  FThreadTitulo := pThreadTitulo;
end;

end.
