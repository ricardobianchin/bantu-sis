unit EnvParaTerm_u_ProdPreco;

interface

uses DBTermDM_u, ExecScript_u;

procedure EnvProdPreco(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u;

function GetSqlServLogs(pLogIdIni, pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //

    + 'PROD_ID'#13#10 // 0
    + ', Preco'#13#10 // 20

    + 'FROM LOG_HIST_PROD_PA.TEVE_PRECO('#13#10 //

    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //

    + ');' //
    ;
end;

procedure EnvProdPreco(pTermDM: TDBTermDM; oExecScript: TExecScript;
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
      sSql := DataSetToSqlGarantir(q, 'PROD', 'PROD_ID', [0, 1]);
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
