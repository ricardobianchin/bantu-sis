unit EstSaldo_u;

interface

uses Configs_u, DBServDM_u, Data.DB;

procedure AtualizeEstSaldo(pPrecisaTerminar: Boolean);

implementation

uses Sis_u, System.Math, ExecScript_u, System.SysUtils, Log_u, EstSaldo_u_dbi,
  Sis.Sis.Constants, Sis.Types.Dates, EstSaldo_u_AtualGravarZerado, DateUtils,
  EstSaldo_u_HistReconstrua, EstSaldo_u_ProdSaldoRecord,
  EstSaldo_u_ProdSaldoArrayType, EstSaldo_u_ProdSaldoArrayUtils;

var
  MaxDt: TDateTime;
  Agora: TDateTime;
  Hoje: TDateTime;

procedure AtualizeEstSaldo(pPrecisaTerminar: Boolean);
var
//  oExecScript: TExecScript;
  sComando: string;
  sLog: string;
  bDeuErro: Boolean;
  aProdSaldos: TProdSaldoArray;
  iQtdProdsSaldo: integer;
  DtHistMaisRecente: TDateTime;
  DtMovMaisAntiga: TDateTime;
begin
  EscrevaLog('AtualizeEstSaldo;');
  if pPrecisaTerminar then
    exit;

  pPrecisaTerminar := GetPrecisaTerminar;
  if pPrecisaTerminar then
    exit;

  try
    EscrevaLog('abrir conexao servidor');
    DBServDM.Connection.Open;
    bDeuErro := False;
  except
    on E: exception do
    begin
      bDeuErro := True;
      EscrevaLog('Erro ' + E.ClassName + ' ' + E.Message);
    end;
  end;

  if bDeuErro then
    exit;

  try
    try
      InicializeProdSaldoArray(aProdSaldos, iQtdProdsSaldo);

      if iQtdProdsSaldo = 0 then
        exit;

      Agora := Now;
      Hoje := Trunc(Agora);

      // pega data mais recende de EST_SALDO_DT que é tb EST_SALDO_HIST
      DtHistMaisRecente := EstSaldo_u_dbi.GetSaldoDtHistUltima;
      if DtHistMaisRecente = 0 then
        exit;

      if DtHistMaisRecente = DATA_ZERADA then
      begin
        DtMovMaisAntiga := EstSaldo_u_dbi.GetEstMovDtHMaisAntigo;
        if DtMovMaisAntiga = DATA_ZERADA then
        begin
          EstSaldoAtualGravarZerado;
          exit;
        end;

        DtHistMaisRecente := DateOf(DtMovMaisAntiga);
      end;

      if DtHistMaisRecente < Hoje then
        EstSaldoHistReconstrua(aProdSaldos, DtHistMaisRecente, Hoje);

      LeMov(pProdSaldoArray, DtFaixaIni, DtFaixaFin);
    finally
//      FreeAndNil(oExecScript);
      EscrevaLog('fechar conexoes');
      DBServDM.Connection.Close;
      EscrevaLog('EnvParaTerm;Fim');
    end;
  except
    on E: exception do
    begin
      EscrevaLog('EnvParaTerm_u.EnvParaTerm;' + E.ClassName + ' ' + E.Message);
    end;
  end;
  pPrecisaTerminar := GetPrecisaTerminar;
  // if Config.EstSaldo.Processa <> 'S' then
  // exit;
end;

end.
