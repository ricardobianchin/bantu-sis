unit EnvParaTerm_u_Prod;

interface

uses DBTermDM_u, ExecScript_u;

procedure EnvProd(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u,
  Sis.Types.strings_u;

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
    + ', ATIVO'#13#10 // 17
    + ', LOCALIZ'#13#10 // 18
    + ', BAL_USO'#13#10 // 19
    + ', CUSTO'#13#10 // 20
    + ', PRECO'#13#10 // 21
    + ', CRIADO_EM'#13#10 // 22
    + ', ALTERADO_EM'#13#10 // 23
    + ', BARRAS'#13#10 // 24

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
  q: TDataSet;
  sBarras: string;
  aBarras: TArray<string>;
begin
  sSql := GetSqlServLogs(pLogIdIni, pLogIdFin);
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  DBServDM.Connection.ExecSQL(sSql, q);

  if not Assigned(q) then
    exit;

  try
    while not q.Eof do
    begin
      sSql := DataSetToSqlGarantir(q, 'PROD', 'PROD_ID',
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
        20, 21, 22, 23]);
      // {$IFDEF DEBUG}
      // CopyTextToClipboard(sSql);
      // {$ENDIF}
      oExecScript.PegueComando(sSql);

      sBarras := q.Fields[24].AsString.Trim;
      if sBarras <> '' then
      begin
        StrDeleteTrailingChars(sBarras, [',', ';', #32, #13, #10]);

        aBarras := sBarras.Split([',', ';']);

        for var cod in aBarras do
        begin
          sSql := 'UPDATE OR INSERT INTO PROD_BARRAS (COD_BARRAS,PROD_ID)' +
            ' VALUES  (' + cod.QuotedString + ',' + q.Fields[0]
            .AsInteger.ToString + ') MATCHING (COD_BARRAS)';

          // {$IFDEF DEBUG}
          // CopyTextToClipboard(sSql);
          // {$ENDIF}
          oExecScript.PegueComando(sSql);
        end;
      end;

      q.Next;
    end;
  finally
    q.Free
  end;
end;

end.
