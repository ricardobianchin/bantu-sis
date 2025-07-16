unit TrazerDoTerm_u;

interface

uses DBTermDM_u;

procedure TrazerDoTerm(pTermDM: TDBTermDM; var pPrecisaTerminar: Boolean);

implementation

uses Sis_u, DBServDM_u, System.Math, ExecScript_u, System.SysUtils, Log_u,
  TrazerDoTerm_u_PegarFaixa, TrazerDoTerm_u_TrazSess;

procedure TrazerDoTerm(pTermDM: TDBTermDM; var pPrecisaTerminar: Boolean);
var
  FLogIdIni, FLogIdFin: Int64;
  iAtualIni, iAtualFIn: Int64;
  oExecScript: TExecScript;
  sComando: string;
  sLog: string;
  bDeuErro: Boolean;
begin
  EscrevaLog('TrazerDoTerm;' + pTermDM.Terminal.TerminalId.ToString);
  if pPrecisaTerminar then
    exit;

  pPrecisaTerminar := GetPrecisaTerminar;
  if pPrecisaTerminar then
    exit;

  try
    EscrevaLog('abrir conexoes');
    DBServDM.Connection.Open;
    pTermDM.Connection.Open;
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
    oExecScript := TExecScript.Create(pTermDM.Connection);
    try
      PegarFaixa(pTermDM, FLogIdIni, FLogIdFin);
      EscrevaLog('PegarFaixa;FLogIdIni=' + FLogIdIni.ToString + ';FLogIdFin=' +
        FLogIdFin.ToString);

      if FLogIdIni = FLogIdFin then
        exit;

      iAtualIni := FLogIdIni;

      while iAtualIni <= FLogIdFin do
      begin
        iAtualFIn := Min(FLogIdFin, iAtualIni + SYNC_QTD_REGS - 1);
        sLog := 'iAtualIni=' + iAtualIni.ToString + ';iAtualFIn=' +
          iAtualFIn.ToString + ';TrazSess';
        TrazSess(pTermDM, oExecScript, iAtualIni, iAtualFIn);
//
//        sLog := sLog + ';EnvTerminal';
//        EnvTerminal(pTermDM, oExecScript, iAtualIni, iAtualFIn);
//
//        sLog := sLog + ';EnvPagamentoForma';
//        EnvPagamentoForma(pTermDM, oExecScript, iAtualIni, iAtualFIn);
//
//        sLog := sLog + ';EnvDespesaTipo';
//        EnvDespesaTipo(pTermDM, oExecScript, iAtualIni, iAtualFIn);
//
//        sLog := sLog + ';EnvFuncionarioUsuario';
//        EnvFuncionarioUsuario(pTermDM, oExecScript, iAtualIni, iAtualFIn);
//
//        sLog := sLog + ';EnvUsuarioPodeOpcaoSis';
//        EnvUsuarioPodeOpcaoSis(pTermDM, oExecScript, iAtualIni, iAtualFIn);
//
//        sLog := sLog + ';EnvProd';
//        EnvProd(pTermDM, oExecScript, iAtualIni, iAtualFIn);
//
//        sLog := sLog + ';EnvProdCusto';
//        EnvProdCusto(pTermDM, oExecScript, iAtualIni, iAtualFIn);
//
//        sLog := sLog + ';EnvProdPreco';
//        EnvProdPreco(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sComando := 'EXECUTE PROCEDURE SYNC_DO_SERVIDOR_SIS_PA.ATUALIZAR(' +
          FLogIdFin.ToString + ');';

        oExecScript.PegueComando(sComando);

        sLog := sLog + ';Vai Executar';
        oExecScript.Execute;
        EscrevaLog(sLog);
        Inc(iAtualIni, SYNC_QTD_REGS);
      end;
    finally
      FreeAndNil(oExecScript);
      EscrevaLog('fechar conexoes');
      DBServDM.Connection.Close;
      pTermDM.Connection.Close;
      EscrevaLog('EnvParaTerm;Fim');
    end;
  except
    on E: exception do
    begin
      EscrevaLog('EnvParaTerm_u.EnvParaTerm;' + E.ClassName + ' ' + E.Message);
    end;
  end;
  pPrecisaTerminar := GetPrecisaTerminar;
end;

end.
