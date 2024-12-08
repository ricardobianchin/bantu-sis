unit ShopApp.Threads.ShopAppSyncTermThread_ProcLog.Prod.Custo_u;

interface

uses App.Threads.SyncTermThread_ProcLog_u, Sis.Entities.Types;

type
  TSyncTermProcLogProdCustoShop = class(TSyncTermProcLog)
  private
    function GetSqlServLogs(pLogIdIni: Int64; pLogIdFin: Int64): string;
  public
    procedure Execute(pLogIdIni: Int64; pLogIdFin: Int64); override;
  end;

implementation

uses System.SysUtils, Data.DB, Sis.DB.SqlUtils_u, Sis.Win.Utils_u,
  Sis.Types.strings_u;

{ TSyncTermProcLogProdCustoShop }

procedure TSyncTermProcLogProdCustoShop.Execute(pLogIdIni,
  pLogIdFin: Int64);
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
    while not q.Eof do
    begin
      sSql := DataSetToSqlGarantir(q, 'PROD', 'PROD_ID', [0, 1]);
//      {$IFDEF DEBUG}
//      CopyTextToClipboard(sSql);
//      {$ENDIF}
      DBExecScript.PegueComando(sSql);

      q.Next;
    end;
  finally
    q.Free
  end;
end;

function TSyncTermProcLogProdCustoShop.GetSqlServLogs(pLogIdIni,
  pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //

    + 'PROD_ID'#13#10 // 0
    + ', CUSTO'#13#10 // 20

    + 'FROM LOG_HIST_PROD_PA.TEVE_CUSTO('#13#10 //

    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //

    + ');' //
    ;
end;

end.
