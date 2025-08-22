unit TrazerDoTerm_u_TrazCxOper;

interface

uses DBTermDM_u, ExecScript_u;

procedure TrazCxOper(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u, Sis.Log;

function GetSqlServLogs(pLogIdIni: Int64; pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //

    + 'LOJA_ID'#13#10 // 0
    + ', TERMINAL_ID'#13#10 // 1
    + ', LOG_ID'#13#10 // 2

    + ', DTH'#13#10 // 3
    + ', PESSOA_TERMINAL_ID'#13#10 // 4
    + ', PESSOA_ID'#13#10 // 5
    + ', MODULO_SIS_ID'#13#10 // 6
    + ', ACAO_SIS_ID'#13#10 // 7
    + ', FEATURE_SIS_ID'#13#10 // 8
    + ', MACHINE_ID'#13#10 // 9

    + ', ORDEM'#13#10 // 10
    + ', LOJA_ID_ENVOLVIDO'#13#10 // 11
    + ', TERMINAL_ID_ENVOLVIDO'#13#10 // 12
    + ', ID_ENVOLVIDO'#13#10 // 13
    + ', ORDEM_ENVOLVIDO'#13#10 // 14
    + ', ID_ENVOLVIDO2'#13#10 // 15

    + ', SESS_ID'#13#10 // 16
    + ', OPER_ORDEM'#13#10 // 17
    + ', OPER_LOG_ID'#13#10 // 18
    + ', OPER_TIPO_ID'#13#10 // 19
    + ', OPER_TIPO_ORDEM'#13#10 // 20
    + ', VALOR'#13#10 // 21
    + ', OBS'#13#10 // 22

    + 'FROM TERM_LOG_HIST_PA.TEVE_CAIXA_SESSAO_OPERACAO('#13#10 //
    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //
    + ');'#13#10 //
    ;
//   {$IFDEF DEBUG}
//   CopyTextToClipboard(Result);
//   {$ENDIF}
end;

procedure TrazCxOper(pTermDM: TDBTermDM; oExecScript: TExecScript;
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
      Log.Escreva('TrazCxOper ' + e.Message+ #13#10+sSql);
      //EscrevaLog('TrazCxOper ' + e.Message+ #13#10+sSql);
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
      sSql := DataSetToSqlGarantir(q, 'LOG', 'LOJA_ID, TERMINAL_ID, LOG_ID',
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
      oExecScript.PegueComando(sSql);

      sSql := DataSetToSqlGarantir(q, 'LOG_ENVOLVE_ID',
        'LOJA_ID, TERMINAL_ID, LOG_ID, ORDEM',
        [0, 1, 2, 10, 11, 12, 13, 14, 15]);
      oExecScript.PegueComando(sSql);

      sSql := DataSetToSqlGarantir(q, 'CAIXA_SESSAO_OPERACAO',
        'LOJA_ID, TERMINAL_ID, SESS_ID, OPER_ORDEM, OPER_LOG_ID', [0, 1, 16, 17, 18, 19, 20, 21, 22]);
      oExecScript.PegueComando(sSql);

      q.next;
    end;
  finally
    q.Free
  end;
end;

end.
