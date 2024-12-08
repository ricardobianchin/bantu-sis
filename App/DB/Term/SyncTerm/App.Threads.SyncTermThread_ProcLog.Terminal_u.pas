unit App.Threads.SyncTermThread_ProcLog.Terminal_u;

interface

uses App.Threads.SyncTermThread_ProcLog_u, Sis.Entities.Types;

type
  TSyncTermProcLogTerminal = class(TSyncTermProcLog)
  private
    function GetSqlServLogs(pLogIdIni: Int64; pLogIdFin: Int64): string;
  public
    procedure Execute(pLogIdIni: Int64; pLogIdFin: Int64); override;
  end;

implementation

uses System.SysUtils, Data.DB, Sis.DB.SqlUtils_u, Sis.Win.Utils_u;

procedure TSyncTermProcLogTerminal.Execute(pLogIdIni, pLogIdFin: Int64);
var
  sSql: string;
  q: TDataSet;
begin
  AppObj.CriticalSections.DB.Acquire;
  try
    sSql := GetSqlServLogs(pLogIdIni, pLogIdFin);
//     {$IFDEF DEBUG}
//     CopyTextToClipboard(sSql);
//     {$ENDIF}

    ServCon.QueryDataSet(sSql, q);
  finally
    AppObj.CriticalSections.DB.Release;
  end;

  if not Assigned(q) then
    exit;

  try
    if q.IsEmpty then
      exit;

    sSql := DataSetToSqlUpdate(q, 'TERMINAL', [0]);
    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}

    DBExecScript.PegueComando(sSql);
  finally
    q.Free
  end;
end;

function TSyncTermProcLogTerminal.GetSqlServLogs(pLogIdIni,
  pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //

    +'TERMINAL_ID'#13#10 // 0
    +', APELIDO'#13#10 // 1
    +', NOME_NA_REDE'#13#10 // 2
    +', IP'#13#10 // 3
    +', NF_SERIE'#13#10 // 4
    +', LETRA_DO_DRIVE'#13#10 // 5
    +', GAVETA_TEM'#13#10 // 6
    +', BALANCA_MODO_ID'#13#10 // 7
    +', BALANCA_ID'#13#10 // 8
    +', BARRAS_COD_INI'#13#10 // 9
    +', BARRAS_COD_TAM'#13#10 // 10
    +', CUPOM_NLINS_FINAL'#13#10 // 11
    +', SEMPRE_OFFLINE'#13#10 // 12

    + 'FROM LOG_HIST_PA.TEVE_TERMINAL('#13#10 //

    + Terminal.TerminalId.ToString
    + ', '+pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //

    + ');' //
    ;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

end.
