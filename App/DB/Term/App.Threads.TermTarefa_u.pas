unit App.Threads.TermTarefa_u;

interface

uses App.Threads.AppTarefa_u, Sis.UI.Frame.Status.Thread_u, App.AppObj,
  Sis.Entities.Terminal;

type
  TAppTermTarefa = class(TAppTarefa)
  private
    FTerminal: ITerminal;
  protected
    property Terminal: ITerminal read FTerminal;
  public
    constructor Create(pTerminal: ITerminal; pAppObj: IAppObj;
      pFrame: TThreadStatusFrame);
  end;

implementation

{ TAppTermTarefa }

constructor TAppTermTarefa.Create(pTerminal: ITerminal;
  pAppObj: IAppObj; pFrame: TThreadStatusFrame);
begin
  inherited Create(pAppObj, pFrame);
  FTerminal := pTerminal;
end;

end.
