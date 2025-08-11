unit TrazerDoTerm_u_TrazEstMovVenda;

interface

uses DBTermDM_u, ExecScript_u;

procedure TrazEstMovVenda(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u, Log_u, System.Math;

function GetSqlServLogs(pLogIdIni: Int64; pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //

    + 'LOJA_ID'#13#10 // 0
    + ', TERMINAL_ID'#13#10 // 1
    + ', EST_MOV_ID'#13#10 // 2

    + ', EST_MOV_TIPO_ID'#13#10 // 3
    + ', DTH_DOC'#13#10 // 4
    + ', FINALIZADO'#13#10 // 5
    + ', CANCELADO'#13#10 // 6
    + ', CRIADO_EM'#13#10 // 7
    + ', ALTERADO_EM'#13#10 // 8
    + ', FINALIZADO_EM'#13#10 // 9
    + ', CANCELADO_EM'#13#10 // 10

    + ', VENDA_ID'#13#10 // 11
    + ', SESS_LOJA_ID'#13#10 // 12
    + ', SESS_TERMINAL_ID'#13#10 // 13
    + ', SESS_ID'#13#10 // 14
    + ', C'#13#10 // 15
    + ', CLIENTE_LOJA_ID'#13#10 // 16
    + ', CLIENTE_TERMINAL_ID'#13#10 // 17
    + ', CLIENTE_ID'#13#10 // 18
    + ', ENDERECO_LOJA_ID'#13#10 // 19
    + ', ENDERECO_TERMINAL_ID'#13#10 // 20
    + ', ENDERECO_ID'#13#10 // 21
    + ', DESCONTO_TOTAL'#13#10 // 22
    + ', CUSTO_TOTAL'#13#10 // 23
    + ', TOTAL_LIQUIDO'#13#10 // 24
    + ', ENTREGA_TEM'#13#10 // 25
    + ', ENTREGADOR_PESSOA_ID'#13#10 // 26
    + ', ENTREGA_EM'#13#10 // 27

    + 'FROM TERM_LOG_HIST_PA.TEVE_EST_MOV_VENDA('#13#10 //
    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //
    + ');'#13#10 //
    ;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

procedure TrazEstMovVenda(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);
var
  sSql: string;
  q: TDataSet;
  iLojaId: SmallInt;
  ErroDeu: Boolean;
  iMaiorVendaId: integer;
  iMaiorEstMovId: Int64;
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

    iMaiorVendaId := 0;
    iMaiorEstMovId := 0;
    while not q.eof do
    begin
      iMaiorVendaId := Max(iMaiorVendaId, q.Fields[11].AsInteger);
      iMaiorEstMovId := Max(iMaiorEstMovId, q.Fields[2].AsLargeInt);

      sSql := DataSetToSqlGarantir(q, 'EST_MOV',
        'LOJA_ID, TERMINAL_ID, EST_MOV_ID', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
      oExecScript.PegueComando(sSql);

      sSql := DataSetToSqlGarantir(q, 'VENDA',
        'LOJA_ID, TERMINAL_ID, EST_MOV_ID',
        [0, 1, 2, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27]);
      oExecScript.PegueComando(sSql);

      q.next;
    end;

    sSql := 'EXECUTE PROCEDURE SEQUENCES_ATUAIS_PA.VALUES_SET('
      + pTermDM.Terminal.TerminalId.ToString
      + ',NULL'
      + ','+iMaiorEstMovId.ToString
      + ',NULL'
      + ',NULL'
      + ','+iMaiorVendaId.ToString
      +');';

    oExecScript.PegueComando(sSql);
  finally
    q.Free
  end;
end;

end.
