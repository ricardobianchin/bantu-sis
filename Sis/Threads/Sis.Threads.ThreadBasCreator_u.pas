unit Sis.Threads.ThreadBasCreator_u;

interface

uses Sis.Threads.ThreadBas_u, Sis.Threads.ThreadCreator, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, System.Classes, Sis.Threads.SafeBool;

type
  TThreadCreator = class(TInterfacedObject, IThreadCreator)
  private
//    FExecutando: ISafeBool;
    FThreadTitulo: string;
    FOnTerminate: TNotifyEvent;
  protected
//    property Executando: ISafeBool read FExecutando;
    property ThreadTitulo: string read FThreadTitulo;

  public
    property OnTerminate: TNotifyEvent read FOnTerminate;
    function ThreadBasCreate: TThreadBas; virtual;
    constructor Create({pExecutando: ISafeBool; }pOnTerminate: TNotifyEvent;
      pThreadTitulo: string = '');
  end;

implementation

{ TThreadCreator }

constructor TThreadCreator.Create({pExecutando: ISafeBool; }pOnTerminate: TNotifyEvent;

  pThreadTitulo: string);
begin
//  FExecutando := pExecutando;
  FOnTerminate := pOnTerminate;
  FThreadTitulo := pThreadTitulo;

//  FTitOutput.Exibir(FThreadTitulo);
//  FStatusOutput.Exibir('Parado');

end;

function TThreadCreator.ThreadBasCreate: TThreadBas;
begin
  Result := TThreadBas.Create({FExecutando,} FThreadTitulo);
  Result.OnTerminate := OnTerminate;
end;

end.
