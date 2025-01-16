unit EnvParaTerm_u_Terminal;

interface

uses DBTermDM_u, ExecScript_u;

procedure EnvTerminal(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u, Sis.Entities.Types;

function GetSqlServLogs(pTerminalId: TTerminalId;
  pLogIdIni, pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //

    + 'TERMINAL_ID'#13#10 // 0

    + ', APELIDO'#13#10 //
    + ', NOME_NA_REDE'#13#10 //
    + ', IP'#13#10 //
    + ', LETRA_DO_DRIVE'#13#10 //

    + ', NF_SERIE'#13#10 //

    + ', GAVETA_TEM'#13#10 //
    + ', GAVETA_COMANDO'#13#10 //

    + ', BALANCA_MODO_ID'#13#10 //
    + ', BALANCA_ID'#13#10 //

    + ', BARRAS_COD_INI'#13#10 //
    + ', BARRAS_COD_TAM'#13#10 //

    + ', IMPRESSORA_MODO_ID'#13#10 //
    + ', CUPOM_NLINS_FINAL'#13#10 //

    + ', SEMPRE_OFFLINE'#13#10 //
    + ', ATIVO'#13#10 //

    + 'FROM LOG_HIST_PA.TEVE_TERMINAL('#13#10 //

    + pTerminalId.ToString //
    + ', ' + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //

    + ');' //
    ;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

procedure EnvTerminal(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);
var
  sSql: string;
  q: TDataSet;
begin
  sSql := GetSqlServLogs(pTermDM.Terminal.TerminalId, pLogIdIni, pLogIdFin);
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

  DBServDM.Connection.ExecSQL(sSql, q);

  if not Assigned(q) then
    exit;

  try
    if q.IsEmpty then
      exit;

    sSql := DataSetToSqlUpdate(q, 'TERMINAL', [0]);
    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}

    oExecScript.PegueComando(sSql);
  finally
    q.Free
  end;
end;

end.
