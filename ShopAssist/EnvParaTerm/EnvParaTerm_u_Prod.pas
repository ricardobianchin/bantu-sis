unit EnvParaTerm_u_Prod;

interface

uses DBTermDM_u, ExecScript_u;

procedure EnvProd(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u,
  Sis.Types.strings_u, Log_u;

var
  FLog: TextFile;

procedure InicieLog(pTerminalId: SmallInt);
begin
  AssignFile(FLog, sPastaLog + 'env_prod' + pTerminalId.ToString + '.txt');
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

    + 'PROD_ID'#13#10 // 0
    + ', DESCR'#13#10 // 1
    + ', DESCR_RED'#13#10 // 2
    + ', FABR_ID'#13#10 // 3
    + ', PROD_TIPO_ID'#13#10 // 4
    + ', UNID_ID'#13#10 // 5
    + ', ICMS_ID'#13#10 // 6
    + ', CAPAC_EMB'#13#10 // 7
    + ', NCM'#13#10 // 8
    + ', DE_SISTEMA'#13#10 // 9
    + ', FABR_NOME'#13#10 // 10
    + ', PROD_TIPO_DESCR'#13#10 // 11
    + ', UNID_DESCR'#13#10 // 12
    + ', UNID_SIGLA'#13#10 // 13
    + ', ICMS_SIGLA'#13#10 // 14
    + ', ICMS_DESCR'#13#10 // 15
    + ', ICMS_PERC'#13#10 // 16

    + ', PROD_NATU_ID'#13#10 // 17
    + ', ATIVO'#13#10 // 18
    + ', LOCALIZ'#13#10 // 19
    + ', BALANCA_EXIGE'#13#10 // 20
    + ', CUSTO'#13#10 // 21
    + ', PRECO'#13#10 // 22
    + ', CRIADO_EM'#13#10 // 23
    + ', ALTERADO_EM'#13#10 // 24
    + ', BARRAS'#13#10 // 25

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

        sBarras := q.Fields[24].AsString.Trim;
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
