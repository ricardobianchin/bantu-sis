unit TrazerDoTerm_u_TrazSess;

interface

uses DBTermDM_u, ExecScript_u;

procedure TrazSess(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u;

function GetSqlServLogs(pLogIdIni: Int64; pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //

    + 'LOG_LOJA_ID'#13#10 // 0
    + ', LOG_TERMINAL_ID'#13#10 // 1
    + ', LOG_ID'#13#10 // 2
    + ', LOG_DTH'#13#10 // 3
    + ', LOG_PESSOA_TERMINAL_ID'#13#10 // 4
    + ', LOG_PESSOA_ID'#13#10 // 5
    + ', LOG_MODULO_SIS_ID'#13#10 // 6
    + ', LOG_ACAO_SIS_ID'#13#10 // 7
    + ', LOG_FEATURE_SIS_ID'#13#10 // 8
    + ', LOG_MACHINE_ID'#13#10 // 9
    + ', LOGENVOLVE_ORDEM'#13#10 // 10
    + ', LOGENVOLVE_LOJA_ID_ENVOLVIDO'#13#10 // 11
    + ', LOGENVOLVE_TERMINAL_ID_ENVOLVIDO'#13#10 // 12
    + ', LOGENVOLVE_ID_ENVOLVIDO'#13#10 // 13
    + ', LOGENVOLVE_ORDEM_ENVOLVIDO'#13#10 // 14
    + ', LOGENVOLVE_ID_ENVOLVIDO2'#13#10 // 15
    + ', SESSAO_SESS_ID'#13#10 // 16
    + ', SESSAO_ABERTO'#13#10 // 17
    + ', SESSAO_CONFERIDO'#13#10 // 18

    + 'FROM TERM_LOG_HIST_PA.TEVE_SESSAO('#13#10 //
    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //
    + ');'#13#10 //
    ;
   {$IFDEF DEBUG}
   CopyTextToClipboard(Result);
   {$ENDIF}
end;


procedure TrazSess(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);
var
  sSql: string;
begin
  sSql := GetSqlServLogs(pLogIdIni, pLogIdFin);
end;

end.
