unit App.Threads.AppTarefa_u;

interface

uses Sis.Threads.Tarefa_u, Sis.UI.Frame.Status.Thread_u, App.AppObj;

type
  TAppTarefa = class(TTarefa)
  private
    FAppObj: IAppObj;
  protected
    property AppObj: IAppObj read FAppObj;
  public
    constructor Create(pAppObj: IAppObj; pFrame: TThreadStatusFrame);
  end;

implementation

{ TAppTarefa }

constructor TAppTarefa.Create(pAppObj: IAppObj; pFrame: TThreadStatusFrame);
begin
  inherited Create(pFrame);
  FAppObj := pAppObj;
end;

end.
