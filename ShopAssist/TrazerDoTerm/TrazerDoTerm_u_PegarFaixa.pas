unit TrazerDoTerm_u_PegarFaixa;

interface

uses DBTermDM_u;

procedure PegarFaixa(pTermDM: TDBTermDM; out pLogIdIni: Int64;
  out pLogIdFin: Int64);

implementation

uses DBServDM_u, Sis.Types.Integers, System.SysUtils;

function GetLogIdIni(pTerminalId: SmallInt): Int64;
var
  sSql: string;
begin
//    + pTermDM.Terminal.TerminalId.ToString

  sSql := 'SELECT LOG_ID_ULTIMO_TRAZIDO_RET FROM SYNC_DO_TERMINAL_SIS_PA.ULTIMO_GET('
    + pTerminalId.ToString
    +');';

  Result := VarToInteger64(DBServDM.Connection.ExecSQLScalar(sSql));
end;

function GetLogIdFin(pTermDM: TDBTermDM): Int64;
var
  sSql: string;
begin
  sSql := 'SELECT LOG_ID_RET FROM TERM_LOG_HIST_PA.ULTIMO_LOG_ID_GET;';

  Result := VarToInteger64(pTermDM.Connection.ExecSQLScalar(sSql));
end;

procedure PegarFaixa(pTermDM: TDBTermDM; out pLogIdIni: Int64;
  out pLogIdFin: Int64);
begin
  pLogIdIni := GetLogIdIni(pTermDM.Terminal.TerminalId);
  pLogIdFin := GetLogIdFin(pTermDM);
end;

end.
