unit EnvParaTerm_u_DespesaTipo;

interface

uses DBTermDM_u, ExecScript_u;

procedure EnvDespesaTipo(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u;

function GetSqlServLogs(pLogIdIni, pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //
    +'DESPESA_TIPO_ID'#13#10 //
    +', DESCR'#13#10 //

    + 'FROM LOG_HIST_PA.TEVE_DESPESA_TIPO('#13#10 //

    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //

    + ');' //
    ;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

procedure EnvDespesaTipo(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);
var
  sSql: string;
  q: TDataSet;
begin
  sSql := GetSqlServLogs(pLogIdIni, pLogIdFin);
  //{$IFDEF DEBUG}
  //CopyTextToClipboard(sSql);
  //{$ENDIF}

  DBServDM.Connection.ExecSQL(sSql, q);

  if not Assigned(q) then
    exit;

  try
    while not q.Eof do
    begin
      sSql := DataSetToSqlGarantir(q, 'DESPESA_TIPO', 'DESPESA_TIPO_ID');
      //{$IFDEF DEBUG}
      //CopyTextToClipboard(sSql);
      //{$ENDIF}

      oExecScript.PegueComando(sSql);
      q.Next;
    end;
  finally
    q.Free
  end;
end;

end.
