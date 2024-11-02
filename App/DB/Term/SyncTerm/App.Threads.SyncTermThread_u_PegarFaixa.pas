unit App.Threads.SyncTermThread_u_PegarFaixa;

interface

uses App.Constants, Sis.DB.Factory, Sis.DB.DBTypes, App.DB.Utils,
  Sis.Sis.Constants, App.AppObj, Sis.Entities.Terminal;

procedure PegarFaixa(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, FTermCon: IDBConnection; out pLogIdIni: Int64;
  out pLogIdFin: Int64);

implementation

uses System.Math;

procedure PegarFaixa(pAppObj: IAppObj; pTerminal: ITerminal;
  pServCon, FTermCon: IDBConnection; out pLogIdIni: Int64;
  out pLogIdFin: Int64);
var
  sSql: string;
  iMaximoAceito: Int64;
  iUltimoLogIdCriado: Int64;
begin
  pTerminal.CriticalSections.DB.Acquire;
  try
    sSql := 'SELECT LOG_ID_SERV_ULTIMO_TRAZIDO FROM SYNC_DO_SERVIDOR_SIS;';
    pLogIdIni := FTermCon.GetValueInteger64(sSql);

    if pLogIdIni = 0 then
    begin
      sSql := 'EXECUTE PROCEDURE SYNC_DO_SERVIDOR_SIS_PA.GARANTIR;';
      FTermCon.ExecuteSQL(sSql)
    end;
  finally
    pTerminal.CriticalSections.DB.Release;
  end;

  pAppObj.CriticalSections.DB.Acquire;
  try
    sSql := //
      'SELECT max(LOG_ID)'#13#10 //
      + 'FROM LOG'#13#10 //
      + 'JOIN AMBIENTE_SIS ON'#13#10 //
      + 'AMBIENTE_SIS.LOJA_ID = LOG.LOJA_ID'#13#10 //
      + 'WHERE LOG.TERMINAL_ID = 0'#13#10 //
      ; //
    iUltimoLogIdCriado := pServCon.GetValueInteger64(sSql);
  finally
    pAppObj.CriticalSections.DB.Release;
  end;

  iMaximoAceito := pLogIdIni + App.Constants.TERMINAL_SYNC_PASSO;

  pLogIdFin := Min(iUltimoLogIdCriado, iMaximoAceito);
end;

end.
