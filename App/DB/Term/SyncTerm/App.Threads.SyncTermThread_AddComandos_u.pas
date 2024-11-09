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
    FSql: TStrings;

  protected
    property AppObj: IAppObj read FAppObj;
    property Terminal: ITerminal read FTerminal;
    property ServCon: IDBConnection read FServCon;
    property TermCon: IDBConnection read FTermCon;
    property Sql: TStrings read FSql;
  public
    procedure Execute(pLogIdIni: Int64; pLogIdFin: Int64); virtual; abstract;
    constructor Create(pAppObj: IAppObj; pTerminal: ITerminal;
      pServCon, pTermCon: IDBConnection; pSql: TStrings);
  end;

implementation

uses Sis.Win.Utils_u;

{ TSyncTermAddComandos }

constructor TSyncTermAddComandos.Create(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; pSql: TStrings);
begin
  FAppObj := pAppObj;
  FTerminal := pTerminal;
  FServCon := pServCon;
  FTermCon := pTermCon;
  FSql := pSql;
end;

end.
