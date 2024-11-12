unit App.Threads.SyncTermThread_u_PegarFaixa;

interface

uses App.Constants, Sis.DB.Factory, Sis.DB.DBTypes, App.DB.Utils,
  Sis.Sis.Constants, App.AppObj, Sis.Entities.Terminal;

procedure PegarFaixa(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; out pLogIdIni: Int64;
  out pLogIdFin: Int64);

implementation

uses System.Math, Sis.Win.Utils_u;

function GetLogIdIni(pTerminal: ITerminal; FTermCon: IDBConnection): Int64;
var
  sSql: string;
begin
  pTerminal.CriticalSections.DB.Acquire;
  try
    sSql := 'SELECT LOG_ID_SERV_ULTIMO_TRAZIDO FROM SYNC_DO_SERVIDOR_SIS;';
    Result := FTermCon.GetValueInteger64(sSql);

    if Result = 0 then
    begin
      sSql := 'EXECUTE PROCEDURE SYNC_DO_SERVIDOR_SIS_PA.GARANTIR;';
      FTermCon.ExecuteSQL(sSql)
    end;
  finally
    pTerminal.CriticalSections.DB.Release;
  end;
end;

function GetLogIdFin(pAppObj: IAppObj; pServCon: IDBConnection): Int64;
var
  sSql: string;
begin
  pAppObj.CriticalSections.DB.Acquire;
  try
    sSql := 'SELECT LOG_HIST_PA.ULTIMO_LOG_ID_GET() AS ULTIMO_LOG_ID'
      + ' FROM RDB$DATABASE;';

    Result := pServCon.GetValueInteger64(sSql);
  finally
    pAppObj.CriticalSections.DB.Release;
  end;
end;

procedure PegarFaixa(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, pTermCon: IDBConnection; out pLogIdIni: Int64;
  out pLogIdFin: Int64);
var
  sSql: string;
begin
  pLogIdIni := GetLogIdIni(pTerminal, pTermCon);
  pLogIdFin := GetLogIdFin(pAppObj, pServCon);
end;

end.
