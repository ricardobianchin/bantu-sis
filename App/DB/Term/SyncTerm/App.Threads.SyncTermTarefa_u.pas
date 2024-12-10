unit App.Threads.SyncTermTarefa_u;

interface

uses App.Threads.TermTarefa_u, Sis.UI.Frame.Status.Thread_u, App.AppObj,
  Sis.Entities.Terminal, Sis.DB.DBTypes;

type
  TSyncTermTarefa = class(TAppTermTarefa)
  private
    FServDBConnectionParams: TDBConnectionParams;
    FTermDBConnectionParams: TDBConnectionParams;
  protected
    property ServDBConnectionParams: TDBConnectionParams
      read FServDBConnectionParams;
    property TermDBConnectionParams: TDBConnectionParams
      read FTermDBConnectionParams;
  public
    constructor Create(pServDBConnectionParams: TDBConnectionParams;
      pTermDBConnectionParams: TDBConnectionParams; pTerminal: ITerminal;
      pAppObj: IAppObj; pFrame: TThreadStatusFrame);
  end;

implementation

{ TSyncTermTarefa }

constructor TSyncTermTarefa.Create(pServDBConnectionParams, pTermDBConnectionParams
  : TDBConnectionParams; pTerminal: ITerminal; pAppObj: IAppObj;
  pFrame: TThreadStatusFrame);
begin
  inherited Create(pTerminal, pAppObj, pFrame);
  FServDBConnectionParams := pServDBConnectionParams;
  FTermDBConnectionParams := pTermDBConnectionParams;
end;

end.
