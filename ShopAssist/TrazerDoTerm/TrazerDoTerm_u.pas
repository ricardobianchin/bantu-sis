unit TrazerDoTerm_u;

interface

uses DBTermDM_u;

procedure TrazerDoTerm(pTermDM: TDBTermDM; var pPrecisaTerminar: Boolean);

implementation

uses Sis_u, DBServDM_u, System.Math, ExecScript_u, System.SysUtils,
  TrazerDoTerm_u_PegarFaixa, TrazerDoTerm_u_TrazCxSess,
  TrazerDoTerm_u_TrazCxOper, TrazerDoTerm_u_TrazCxOperDesp,
  TrazerDoTerm_u_TrazCxOperValor, TrazerDoTerm_u_TrazLogMovs,
  TrazerDoTerm_u_TrazEstMovVenda, TrazerDoTerm_u_TrazEstMovItemVendaItem, TrazerDoTerm_u_TrazVendaPag,
  Sis.Log;

procedure TrazerDoTerm(pTermDM: TDBTermDM; var pPrecisaTerminar: Boolean);
var
  FLogIdIni, FLogIdFin: Int64;
  iAtualIni, iAtualFIn: Int64;
  oExecScript: TExecScript;
  sComando: string;
  sLog: string;
  bDeuErro: Boolean;
begin
  Log.Escreva('TrazerDoTerm;' + pTermDM.Terminal.TerminalId.ToString);
  //EscrevaLog('TrazerDoTerm;' + pTermDM.Terminal.TerminalId.ToString);
  if pPrecisaTerminar then
    exit;

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
    oExecScript := TExecScript.Create(DBServDM.Connection);
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
          iAtualFIn.ToString + ';TrazCxSess';
        TrazCxSess(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';TrazCxOper';
        TrazCxOper(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';TrazCxOperDesp';
        TrazCxOperDesp(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';TrazCxOperValor';
        TrazCxOperValor(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';TrazLogMovs';
        TrazLogMovs(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';TrazEstMovVenda';
        TrazEstMovVenda(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';TrazEstMovItemVendaItem';
        TrazEstMovItemVendaItem(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sLog := sLog + ';TrazVendaPag';
        TrazVendaPag(pTermDM, oExecScript, iAtualIni, iAtualFIn);

        sComando := 'EXECUTE PROCEDURE SYNC_DO_TERMINAL_SIS_PA.ATUALIZE(' +
          pTermDM.Terminal.TerminalId.ToString + ', ' +
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
      Log.Escreva('EnvParaTerm;Fim');
      //EscrevaLog('EnvParaTerm;Fim');
    end;
  except
    on E: exception do
    begin
      Log.Escreva('EnvParaTerm_u.EnvParaTerm;' + E.ClassName + ' ' + E.Message);
      //EscrevaLog('EnvParaTerm_u.EnvParaTerm;' + E.ClassName + ' ' + E.Message);
    end;
  end;
  pPrecisaTerminar := GetPrecisaTerminar;
end;

end.
