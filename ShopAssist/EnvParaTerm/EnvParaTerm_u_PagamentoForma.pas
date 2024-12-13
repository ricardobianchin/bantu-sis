unit EnvParaTerm_u_PagamentoForma;

interface

uses DBTermDM_u, ExecScript_u;

procedure EnvPagamentoForma(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u;

function GetSqlServLogs(pLogIdIni, pLogIdFin: Int64): string;
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
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

procedure EnvPagamentoForma(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);
var
  sSql: string;
  q: TDataSet;
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
      sSql := DataSetToSqlUpdate(q, 'PAGAMENTO_FORMA', [0]);
      // {$IFDEF DEBUG}
      // CopyTextToClipboard(sSql);
      // {$ENDIF}

      oExecScript.PegueComando(sSql);
      q.Next;
    end;
  finally
    q.Free
  end;
end;

end.
