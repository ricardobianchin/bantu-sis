unit EnvParaTerm_u;

interface

uses DBTermDM_u;

procedure EnvParaTerm(pTermDM: TDBTermDM; var pPrecisaTerminar: Boolean);

implementation

uses Sis_u, EnvParaTerm_u_AtualizeMachine, EnvParaTerm_u_PegarFaixa, DBServDM_u,
  System.Math, ExecScript_u, System.SysUtils, EnvParaTerm_u_Loja,
  EnvParaTerm_u_Terminal, EnvParaTerm_u_PagamentoForma,
  EnvParaTerm_u_FuncionarioUsuario, EnvParaTerm_u_UsuarioPodeOpcaoSis,
  EnvParaTerm_u_Prod, EnvParaTerm_u_ProdCusto, Log_u, EnvParaTerm_u_ProdPreco,
  EnvParaTerm_u_DespesaTipo, Sis.Log;

procedure EnvParaTerm(pTermDM: TDBTermDM; var pPrecisaTerminar: Boolean);
var
  FLogIdIni, FLogIdFin: Int64;
  iAtualIni, iAtualFIn: Int64;
  oExecScript: TExecScript;
  sComando: string;
  sLog: string;
  bDeuErro: Boolean;
begin
  Log.Escreva('EnvParaTerm;' + pTermDM.Terminal.TerminalId.ToString);
  //EscrevaLog('EnvParaTerm;' + pTermDM.Terminal.TerminalId.ToString);
  if pPrecisaTerminar then
    exit;

  pPrecisaTerminar := GetPrecisaTerminar;
  if pPrecisaTerminar then
    exit;

  // machine
  Log.Escreva('AtualizeMachine');
  //EscrevaLog('AtualizeMachine');
  AtualizeMachine(pTermDM, pPrecisaTerminar);
  pPrecisaTerminar := GetPrecisaTerminar;
  if pPrecisaTerminar then
    exit;

  try
    Log.Escreva('abrir conexoes');
    //EscrevaLog('abrir conexoes');
    DBServDM.Connection.Open;
    pTermDM.Connection.Open;
    bDeuErro := False;
  except
    on E: exception do
    begin
      bDeuErro := True;
      Log.Escreva('Erro ' + E.ClassName + ' ' + E.Message);
      //EscrevaLog('Erro ' + E.ClassName + ' ' + E.Message);
    end;
  end;

  if bDeuErro then
    exit;

  try
    oExecScript := TExecScript.Create(pTermDM.Connection);
    try
      PegarFaixa(pTermDM, FLogIdIni, FLogIdFin);
      Log.Escreva('PegarFaixa;FLogIdIni=' + FLogIdIni.ToString + ';FLogIdFin=' +
        FLogIdFin.ToString);
      //EscrevaLog('PegarFaixa;FLogIdIni=' + FLogIdIni.ToString + ';FLogIdFin=' +
        //FLogIdFin.ToString);

      if FLogIdIni = FLogIdFin then
        exit;

      iAtualIni := FLogIdIni;

      while iAtualIni <= FLogIdFin do
      begin
        iAtualFIn := Min(FLogIdFin, iAtualIni + SYNC_QTD_REGS - 1);

        sLog := 'iAtualIni=' + iAtualIni.ToString + ';iAtualFIn=' +
          iAtualFIn.ToString + ';EnvLoja';
        EnvLoja(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';EnvTerminal';
        EnvTerminal(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';EnvPagamentoForma';
        EnvPagamentoForma(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';EnvDespesaTipo';
        EnvDespesaTipo(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';EnvFuncionarioUsuario';
        EnvFuncionarioUsuario(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';EnvUsuarioPodeOpcaoSis';
        EnvUsuarioPodeOpcaoSis(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';EnvProd';
        EnvProd(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';EnvProdCusto';
        EnvProdCusto(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';EnvProdPreco';
        EnvProdPreco(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sComando := 'EXECUTE PROCEDURE SYNC_DO_SERVIDOR_SIS_PA.ATUALIZAR(' +
          FLogIdFin.ToString + ');';

        oExecScript.PegueComando(sComando);

        sLog := sLog + ';Vai Executar';
        oExecScript.Execute;
        Log.Escreva(sLog);
        //EscrevaLog(sLog);
        Inc(iAtualIni, SYNC_QTD_REGS);
      end;
    finally
      FreeAndNil(oExecScript);
      Log.Escreva('fechar conexoes');
      //EscrevaLog('fechar conexoes');
      DBServDM.Connection.Close;
      pTermDM.Connection.Close;
      Log.Escreva('fechar conexoes');
      //EscrevaLog('fechar conexoes');
    end;
  except
    on E: exception do
    begin
      Log.Escreva('EnvParaTerm_u.EnvParaTerm;'+ e.ClassName + ' ' + e.Message);
      //EscrevaLog('EnvParaTerm_u.EnvParaTerm;'+ e.ClassName + ' ' + e.Message);
    end;
  end;
  pPrecisaTerminar := GetPrecisaTerminar;
end;

end.
