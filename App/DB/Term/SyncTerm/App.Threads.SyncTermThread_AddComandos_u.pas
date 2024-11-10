unit App.Threads.SyncTermThread_AddComandos_u;

interface

uses App.Threads.SyncTermThread_AddComandos, Sis.DB.DBTypes, App.AppObj,
  Sis.Entities.Terminal, System.Classes;

type
  TSyncTermAddComandos = class(TInterfacedObject, ISyncTermAddComandos)
  private
    FAppObj: IAppObj;
    FTerminal: ITerminal;
    FServCon: IDBConnection;
    FTermCon: IDBConnection;
    FDBExecScript: IDBExecScript;

  protected
    property AppObj: IAppObj read FAppObj;
    property Terminal: ITerminal read FTerminal;
    property ServCon: IDBConnection read FServCon;
    property TermCon: IDBConnection read FTermCon;
    property DBExecScript: IDBExecScript read FDBExecScript;
  public
    procedure Execute(pLogIdIni: Int64; pLogIdFin: Int64); virtual; abstract;
    constructor Create(pAppObj: IAppObj; pTerminal: ITerminal;
      pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript);
  end;

implementation

uses Sis.Win.Utils_u;

{ TSyncTermAddComandos }

constructor TSyncTermAddComandos.Create(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pDBExecScript: IDBExecScript);
begin
  FAppObj := pAppObj;
  FTerminal := pTerminal;
  FServCon := pServCon;
  FTermCon := pTermCon;
  FDBExecScript := pDBExecScript;
end;

end.
