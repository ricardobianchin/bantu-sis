unit EnvParaTerm_u_Prod;

interface

uses DBTermDM_u, ExecScript_u;

procedure EnvProd(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u,
  Sis.Types.strings_u, Sis_u;

var
  FLog: TextFile;

procedure InicieLog(pTerminalId: SmallInt);
var
  sNomeArq: string;
begin
  sNomeArq  := sPastaLog + 'env_prod' + pTerminalId.ToString + '.txt';
  AssignFile(FLog, sNomeArq);
  Rewrite(FLog);
  CloseFile(FLog);
end;

procedure EscrLog(pFrase: string);
begin
  Append(FLog);
  WriteLn(FLog, pFrase);
  CloseFile(FLog);
end;

function GetSqlServLogs(pLogIdIni, pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //

    + 'PROD_ID -- 0'#13#10 //
    + ', DESCR -- 1'#13#10 //
    + ', DESCR_RED -- 2'#13#10 //
    + ', FABR_ID -- 3'#13#10 //
    + ', PROD_TIPO_ID -- 4'#13#10 //
    + ', UNID_ID -- 5'#13#10 //
    + ', ICMS_ID -- 6'#13#10 //
    + ', CAPAC_EMB -- 7'#13#10 //
    + ', NCM -- 8'#13#10 //
    + ', DE_SISTEMA -- 9'#13#10 //
    + ', FABR_NOME -- 10'#13#10 //
    + ', PROD_TIPO_DESCR -- 11'#13#10 //
    + ', UNID_DESCR -- 12'#13#10 //
    + ', UNID_SIGLA -- 13'#13#10 //
    + ', ICMS_SIGLA -- 14'#13#10 //
    + ', ICMS_DESCR -- 15'#13#10 //
    + ', ICMS_PERC -- 16'#13#10 //
    + ', PROD_NATU_ID -- 17'#13#10 //
    + ', ATIVO -- 18'#13#10 //
    + ', LOCALIZ -- 19'#13#10 //
    + ', BALANCA_EXIGE -- 20'#13#10 //
    + ', CUSTO -- 21'#13#10 //
    + ', PRECO -- 22'#13#10 //
    + ', CRIADO_EM -- 23'#13#10 //
    + ', ALTERADO_EM -- 24'#13#10 //
    + ', BARRAS -- 25'#13#10 //

    + 'FROM LOG_HIST_PROD_PA.TEVE_PROD('#13#10 //

    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //

    + ');' //
    ;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

procedure EnvProd(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);
var
  sSql: string;
  s: string;
  q: TDataSet;
  sBarras: string;
  aBarras: TArray<string>;
begin
  InicieLog(pTermDM.Terminal.TerminalId);
  try
    s := 'Servidor log_id inicial;' + pLogIdIni.ToString;
    EscrLog(s);

    s := 'Servidor log_id Final;' + pLogIdFin.ToString;
    EscrLog(s);

    EscrLog('----');
    s := 'SQL busca prods da faixa de logs';
    EscrLog(s);
    sSql := GetSqlServLogs(pLogIdIni, pLogIdFin);
    EscrLog('----');
    EscrLog(sSql);
    EscrLog('----');

    DBServDM.Connection.ExecSQL(sSql, q);

    if not Assigned(q) then
    begin
      EscrLog('not Assigned(q)');
      exit;
    end;
    EscrLog('q.FieldCount = '+q.FieldCount.ToString);
    EscrLog('----');
    EscrLog('Inicia loop');
    EscrLog('----');

    try
      while not q.Eof do
      begin
        sSql := DataSetToSqlGarantir(q, 'PROD', 'PROD_ID',
          [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
          20, 21, 22, 23, 24]);
        oExecScript.PegueComando(sSql);
        EscrLog('p;'+q.fields[0].AsString+';'+sSql);

        sBarras := q.Fields[25].AsString.Trim;
        if sBarras <> '' then
        begin
          StrDeleteTrailingChars(sBarras, [',', ';', #32, #13, #10]);

          aBarras := sBarras.Split([',', ';']);
          if Length(aBarras) = 0 then
            EscrLog('b;--sem barras');

          for var cod in aBarras do
          begin
            sSql := 'UPDATE OR INSERT INTO PROD_BARRAS (COD_BARRAS,PROD_ID)' +
              ' VALUES  (' + cod.QuotedString + ',' + q.Fields[0]
              .AsInteger.ToString + ') MATCHING (COD_BARRAS)';

            oExecScript.PegueComando(sSql);
            EscrLog('b;'+q.fields[0].AsString+';'+sSql);
          end;
        end;

        q.Next;
      end;
    finally
      EscrLog('----');
      EscrLog('Fim');
      q.Free
    end;
  except
    on E: Exception do
      EscrLog(#13#10+E.message);
  end;
end;

end.
