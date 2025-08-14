unit TrazerDoTerm_u_TrazCxOperDesp;

interface

uses DBTermDM_u, ExecScript_u;

procedure TrazCxOperDesp(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u, Log_u, Sis.Log;

function GetSqlServLogs(pLogIdIni: Int64; pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //

    + 'LOJA_ID'#13#10 // 0
    + ', TERMINAL_ID'#13#10 // 1
    + ', SESS_ID'#13#10 // 2
    + ', OPER_ORDEM'#13#10 // 3
    + ', OPER_LOG_ID'#13#10 // 4
    + ', DESPESA_TIPO_ID'#13#10 // 5
    + ', FORNEC_NOME'#13#10 // 6
    + ', NUMDOC'#13#10 // 7

    + 'FROM TERM_LOG_HIST_PA.TEVE_CAIXA_SESSAO_OPERACAO_DESPESA('#13#10 //
    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //
    + ');'#13#10 //
    ;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

procedure TrazCxOperDesp(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);
var
  sSql: string;
  q: TDataSet;
  iLojaId: SmallInt;
  ErroDeu: Boolean;
begin
  sSql := GetSqlServLogs(pLogIdIni, pLogIdFin);
  try
    pTermDM.Connection.ExecSQL(sSql, q);
    ErroDeu := False;
  except
    on e: Exception do
    begin
      ErroDeu := True;
      Log.Escreva('TrazCxOperDesp ' + e.Message + #13#10 + sSql);
      //EscrevaLog('TrazCxOperDesp ' + e.Message + #13#10 + sSql);
    end;
  end;

  if ErroDeu then
    exit;

  if not Assigned(q) then
    exit;

  try
    // if q.IsEmpty then
    // exit;

    while not q.eof do
    begin
      sSql := DataSetToSqlGarantir(q, 'CAIXA_SESSAO_OPERACAO_DESPESA',
        'LOJA_ID, TERMINAL_ID, SESS_ID, OPER_ORDEM, OPER_LOG_ID',
        [0, 1, 2, 3, 4, 5, 6, 7]);
      oExecScript.PegueComando(sSql);
      q.next;
    end;
  finally
    q.Free
  end;
end;

end.
