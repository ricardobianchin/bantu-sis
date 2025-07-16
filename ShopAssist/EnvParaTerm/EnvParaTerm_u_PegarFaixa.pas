unit EnvParaTerm_u_PegarFaixa;

interface

uses DBTermDM_u;

procedure PegarFaixa(pTermDM: TDBTermDM; out pLogIdIni: Int64;
  out pLogIdFin: Int64);

implementation

uses DBServDM_u, Sis.Types.Integers;

function GetLogIdIni(pTermDM: TDBTermDM): Int64;
var
  sSql: string;
begin
  sSql := 'SELECT LOG_ID_SERV_ULTIMO_TRAZIDO FROM SYNC_DO_SERVIDOR_SIS;';
  Result := VarToInteger64(pTermDM.Connection.ExecSQLScalar(sSql));

  if Result = 0 then
  begin
    sSql := 'EXECUTE PROCEDURE SYNC_DO_SERVIDOR_SIS_PA.GARANTIR;';
    pTermDM.Connection.ExecSQL(sSql)
  end;
end;

function GetLogIdFin: Int64;
var
  sSql: string;
begin
  sSql := 'SELECT LOG_HIST_PA.ULTIMO_LOG_ID_GET() AS ULTIMO_LOG_ID' +
    ' FROM RDB$DATABASE;';

  Result := VarToInteger64(DBServDM.Connection.ExecSQLScalar(sSql));
end;

procedure PegarFaixa(pTermDM: TDBTermDM; out pLogIdIni: Int64;
  out pLogIdFin: Int64);
begin
  pLogIdIni := GetLogIdIni(pTermDM);
  pLogIdFin := GetLogIdFin;
end;

end.
