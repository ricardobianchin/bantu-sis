unit App.Threads.SyncTermThread_ProcLog.PagamentoForma_u;

interface

uses App.Threads.SyncTermThread_ProcLog_u, Sis.Entities.Types;

type
  TSyncTermProcLogPagamentoForma = class(TSyncTermProcLog)
  private
    function GetSqlServLogs(pLogIdIni: Int64; pLogIdFin: Int64): string;
  public
    procedure Execute(pLogIdIni: Int64; pLogIdFin: Int64); override;
  end;

implementation

uses System.SysUtils, Data.DB, Sis.DB.SqlUtils_u, Sis.Win.Utils_u;

{ TSyncTermProcLogPagamentoForma }

procedure TSyncTermProcLogPagamentoForma.Execute(pLogIdIni,
  pLogIdFin: Int64);
var
  sSql: string;
  q: TDataSet;
begin
  AppObj.CriticalSections.DB.Acquire;
  try
    sSql := GetSqlServLogs(pLogIdIni, pLogIdFin);
    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}

    ServCon.QueryDataSet(sSql, q);
  finally
    AppObj.CriticalSections.DB.Release;
  end;

  if not Assigned(q) then
    exit;

  try
    while not q.Eof do
    begin
      sSql := DataSetToSqlUpdate(q, 'PAGAMENTO_FORMA', [0]);
      // {$IFDEF DEBUG}
      // CopyTextToClipboard(sSql);
      // {$ENDIF}

      DBExecScript.PegueComando(sSql);
      q.Next;
    end;
  finally
    q.Free
  end;
end;

function TSyncTermProcLogPagamentoForma.GetSqlServLogs(pLogIdIni,
  pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //

    + 'PAGAMENTO_FORMA_ID'#13#10 //
    + ', PAGAMENTO_FORMA_TIPO_ID'#13#10 //
    + ', DESCR'#13#10 //
    + ', DESCR_RED'#13#10 //
    + ', ATIVO'#13#10 //
    + ', PARA_VENDA'#13#10 //
    + ', DE_SISTEMA'#13#10 //
    + ', PROMOCAO_PERMITE'#13#10 //
    + ', COMISSAO_PERMITE'#13#10 //
    + ', TAXA_ADM_PERC'#13#10 //
    + ', VALOR_MINIMO'#13#10 //
    + ', COMISSAO_ABATER_PERC'#13#10 //
    + ', REEMBOLSO_DIAS'#13#10 //
    + ', TEF_USA'#13#10 //
    + ', AUTORIZACAO_EXIGE'#13#10 //
    + ', PESSOA_EXIGE'#13#10 //
    + ', A_VISTA'#13#10 //

    + 'FROM LOG_HIST_PA.TEVE_PAGAMENTO_FORMA('#13#10 //

    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //

    + ');' //
    ;
//{$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//{$ENDIF}
end;

end.
