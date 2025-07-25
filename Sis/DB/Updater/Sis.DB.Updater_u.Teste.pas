unit Sis.DB.Updater_u.Teste;

interface

uses Sis.DB.DBTypes, Sis.DB.Factory, Sis.Terminal, Sis.Entities.Types,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

const
  VERSAO_ULTIMA_A_PROCESSAR = -1; // -1 = RODA SEM INTERRUPCOES
  //VERSAO_ULTIMA_A_PROCESSAR = 110; // INTERROMPE APOS FINALIZAR ESTA VERSAO

  TESTE_GRAVA_INICIAIS = True;
  TESTE_ABORTA_NO_PRIMEIRO = FALSE;
//  TESTE_ABORTA_NO_PRIMEIRO = TRUE;
  DB_UPDATER_EM_TESTE: Boolean = (VERSAO_ULTIMA_A_PROCESSAR > -1);

  RESET_VERSAO = -1;

  RESET_EXECUTA = False;
  // RESET_EXECUTA = True;

procedure ResetBanco(pDBConnectionParams: TDBConnectionParams; pDBMS: IDBMS;
  pTerminal: ITerminal; pPastaComandos: string; pProcessLog: IProcessLog;
  pOutPut: IOutPut);

implementation

uses System.Classes, System.SysUtils;

procedure ResetBanco(pDBConnectionParams: TDBConnectionParams; pDBMS: IDBMS;
  pTerminal: ITerminal; pPastaComandos: string; pProcessLog: IProcessLog;
  pOutPut: IOutPut);
var
  sAssunto: string;
  oSqlSL: TStringList;
  sNomeBanco: string;
  sPastaComandos: string;

begin
  if not RESET_EXECUTA then
    exit;

  oSqlSL := TStringList.Create;
  pProcessLog.PegueLocal('Updater_u.Teste.ResetBanco');
  try
    if RESET_VERSAO >= 0 then
    begin
      oSqlSL.Add('DELETE FROM DBUPDATE_HIST WHERE NUM>=' +
        RESET_VERSAO.ToString + ';');
      oSqlSL.Add('COMMIT;');
    end;

    oSqlSL.Add('DROP PACKAGE SE_INICIAL_PA;');
    oSqlSL.Add('DROP PACKAGE SESSAO_MANUT_PA;');

    pOutPut.Exibir('Executando comandos...');
    pProcessLog.RegistreLog('Executando reset');

    sAssunto := 'DBUpdate teste reset';
    sNomeBanco := pDBConnectionParams.GetNomeBanco;

    pDBMS.ExecInterative(sAssunto, oSqlSL.Text, sNomeBanco, pPastaComandos,
      pProcessLog, pOutPut);
  finally
    pProcessLog.RetorneLocal;
    oSqlSL.Free;
  end;
end;

end.
