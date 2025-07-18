unit TrazerDoTerm_u_TrazVendaPag;

interface

uses DBTermDM_u, ExecScript_u;

procedure TrazVendaPag(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u, Log_u;

function GetSqlServLogs(pLogIdIni: Int64; pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //

    + 'LOJA_ID'#13#10 // 0
    + ', TERMINAL_ID'#13#10 // 1
    + ', EST_MOV_ID'#13#10 // 2
    + ', ORDEM'#13#10 // 3
    + ', PAGAMENTO_FORMA_ID'#13#10 // 4
    + ', VALOR_DEVIDO'#13#10 // 5
    + ', VALOR_ENTREGUE'#13#10 // 6
    + ', TROCO'#13#10 // 7
    + ', CANCELADO'#13#10 // 8
    + ', CRIADO_EM'#13#10 // 9
    + ', CANCELADO_EM'#13#10 // 10

    + 'FROM TERM_LOG_HIST_PA.TEVE_VENDA_PAG('#13#10 //
    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //
    + ');'#13#10 //
    ;

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

procedure TrazVendaPag(pTermDM: TDBTermDM; oExecScript: TExecScript;
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
      EscrevaLog('TrazEstMovVenda ' + e.Message);
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
      sSql := DataSetToSqlGarantir(q, 'VENDA_PAG',
        'LOJA_ID, TERMINAL_ID, EST_MOV_ID, ORDEM', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
      oExecScript.PegueComando(sSql);

      q.next;
    end;
  finally
    q.Free
  end;
end;

end.
