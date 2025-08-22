unit TrazerDoTerm_u_TrazEstMovItemVendaItem;

interface

uses DBTermDM_u, ExecScript_u;

procedure TrazEstMovItemVendaItem(pTermDM: TDBTermDM; oExecScript: TExecScript;
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
    + ', EST_MOV_ID'#13#10 // 2
    + ', ORDEM'#13#10 // 3

    + ', PROD_ID'#13#10 // 4
    + ', QTD'#13#10 // 5
    + ', CANCELADO'#13#10 // 6
    + ', CRIADO_EM'#13#10 // 7
    + ', ALTERADO_EM'#13#10 // 8
    + ', CANCELADO_EM'#13#10 // 9

    + ', CUSTO_UNIT'#13#10 // 10
    + ', CUSTO'#13#10 // 11
    + ', PRECO_UNIT_ORIGINAL'#13#10 // 12
    + ', PRECO_UNIT_PROMO'#13#10 // 13
    + ', PRECO_UNIT'#13#10 // 14
    + ', PRECO_BRUTO'#13#10 // 15
    + ', DESCONTO'#13#10 // 16
    + ', PRECO'#13#10 // 17

    + 'FROM TERM_LOG_HIST_PA.TEVE_EST_MOV_ITEM_VENDA_ITEM('#13#10 //
    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //
    + ');'#13#10 //
    ;

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

procedure TrazEstMovItemVendaItem(pTermDM: TDBTermDM; oExecScript: TExecScript;
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
      Log.Escreva('TrazEstMovVenda ' + e.Message);
      //EscrevaLog('TrazEstMovVenda ' + e.Message);
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
      sSql := DataSetToSqlGarantir(q, 'EST_MOV_ITEM',
        'LOJA_ID, TERMINAL_ID, EST_MOV_ID, ORDEM', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
      oExecScript.PegueComando(sSql);

      sSql := DataSetToSqlGarantir(q, 'VENDA_ITEM',
        'LOJA_ID, TERMINAL_ID, EST_MOV_ID, ORDEM',
        [0, 1, 2, 3, 10, 11, 12, 13, 14, 15, 16, 17]);
      oExecScript.PegueComando(sSql);

      q.next;
    end;
  finally
    q.Free
  end;
end;

end.
