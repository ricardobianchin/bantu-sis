unit App.DB.Garantir_u;

interface

uses Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  App.AppObj, Sis.Usuario, Sis.Loja, Sis.TerminalList, Sis.Terminal.DBI,
  Sis.Config.SisConfig;

function GarantirDB(pAppObj: IAppObj; pProcessLog: IProcessLog;
  pOutput: IOutput; pLoja: ISisLoja; pUsuarioAdmin: IUsuario;
  pVariaveis: string; pCriouTerminais: Boolean): Boolean;

implementation

uses Sis.DB.Factory, Sis.DB.Updater, Sis.DB.Updater.Factory, App.DB.Utils,
  Sis.Sis.Constants, Sis.Terminal, Sis.Entities.Types, Sis.Lists.IntegerList,
  Sis.Types.Integers, App.AppInfo.Types, Sis.Terminal.Factory_u,
  App.SisConfig.DBI, App.SisConfig.Factory, Sis.Terminal.Utils_u,
  System.SysUtils, System.Classes, App.DB.Garantir_u.GravarInicialTerm,
  App.DB.Garantir_u.GravarInicialServ, App.Loja.DBI, App.Pess.Factory_u,
  App.AppObj_u_Ini, Sis.Config.SisConfig.XMLI, Sis.Config.Factory;

var
  DBMSConfig: IDBMSConfig;
  DBMS: IDBMS;

function GarantirDBServ(pAppObj: IAppObj; pProcessLog: IProcessLog;
  pOutput: IOutput; pLoja: ISisLoja; pUsuarioAdmin: IUsuario;
  pVariaveis: string): Boolean;
var
  oUpdater: IDBUpdater;
  rDBConnectionParams: TDBConnectionParams;
begin
  pProcessLog.PegueLocal('App.DB.Garantir_u,GarantirDBServ');

  try
    rDBConnectionParams := TerminalIdToDBConnectionParams
      (TERMINAL_ID_RETAGUARDA, pAppObj);

    oUpdater := DBUpdaterFirebirdCreate(TERMINAL_ID_RETAGUARDA,
      rDBConnectionParams, pAppObj.AppInfo.Pasta, DBMS, pAppObj.SisConfig,
      pProcessLog, pOutput, pLoja, pUsuarioAdmin, pVariaveis);

    Result := oUpdater.Execute;
  finally
    pProcessLog.RegistreLog('fim');
    pProcessLog.RetorneLocal
  end;
end;

function GarantirDBTerms(pAppObj: IAppObj; pProcessLog: IProcessLog;
  pOutput: IOutput; pLoja: ISisLoja; pUsuarioAdmin: IUsuario;
  pVariaveis: string; pCriouTerminais: Boolean; pAtivDescr: string): Boolean;
var
  oUpdater: IDBUpdater;
  rDBConnectionParamsServ: TDBConnectionParams;
  oDBConnectionServ: IDBConnection;
  rDBConnectionParamsTerm: TDBConnectionParams;
  oDBConnectionTerm: IDBConnection;
  oTerminal: ITerminal;
  iIndex: integer;

  oTerminalDBI: ITerminalDBI;
  sPastaDados: string;
  sAtiv: string;
begin
  pProcessLog.PegueLocal('App.DB.Garantir_u,GarantirDBTerms');
  {
    MONTAR ENDERECO DO TERM COM A LETRA DO DRIVE
    pProcessLog.PegueLocal('App.DB.Garantir_u,GarantirDBServ');
  }

  { if pAppObj.TerminalList.Count = 0 then
    begin
    sAtivDescr := AtividadeEconomicaSisDescr
    [pAppObj.AppInfo.AtividadeEconomicaSis];
    rDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, pAppObj);

    oDBConnection := DBConnectionCreate('App.DB.Garantir_u.GarantirDBTerms.conn',
    pAppObj.SisConfig, rDBConnectionParams, pProcessLog, pOutput);

    oTerminalDBI := TerminalDBICreate(oDBConnection);

    o T ermina l D BI.D BT oL ist(pAppObj.TerminalList, pAppObj.AppInfo.PastaDados,
    sAtivDescr, pAppObj.SisConfig.LocalMachineId.Name);
    end;
  }
  try
    Result := pAppObj.TerminalList.Count = 0;
    if Result then
    begin
      pProcessLog.RegistreLog
        ('pAppObj.TerminalList.Count = 0, vai abortar, Result = True');
      exit;
    end;

    sPastaDados := pAppObj.AppInfo.PastaDados;
    sAtiv := AtividadeEconomicaSisDescr[pAppObj.AppInfo.AtividadeEconomicaSis];

    rDBConnectionParamsServ := TerminalIdToDBConnectionParams
      (TERMINAL_ID_RETAGUARDA, pAppObj);

    for iIndex := 0 to pAppObj.TerminalList.Count - 1 do
    begin
      oTerminal := pAppObj.TerminalList[iIndex];

      oTerminal.LocalArqDados := Sis.Terminal.Utils_u.GetTermLocalArqDados
        (sPastaDados, oTerminal.TerminalId, sAtiv);

      oTerminal.Database := oTerminal.IdentStr + ':' + oTerminal.LocalArqDados;

      rDBConnectionParamsTerm.Server := oTerminal.IdentStr;
      rDBConnectionParamsTerm.Arq := oTerminal.LocalArqDados;
      rDBConnectionParamsTerm.Database := oTerminal.Database;

      oUpdater := DBUpdaterFirebirdCreate(oTerminal.TerminalId,
        rDBConnectionParamsTerm, pAppObj.AppInfo.Pasta, DBMS, pAppObj.SisConfig,
        pProcessLog, pOutput, pLoja, pUsuarioAdmin, pVariaveis);

      pProcessLog.RegistreLog
        ('vai chamar oUpdater.Execute, rDBConnectionParamsTerm.Database=' +
        rDBConnectionParamsTerm.Database);
      Result := oUpdater.Execute;

      if pCriouTerminais then
      begin
        pProcessLog.RegistreLog('criou terminais = True');

        pProcessLog.RegistreLog('vai chamar GravarInicialTerm');
        GravarInicialTerm(oTerminal, rDBConnectionParamsTerm, pAppObj,
          pProcessLog, pOutput, pLoja, pUsuarioAdmin);

        pProcessLog.RegistreLog('vai chamar GravarInicialServ');
        GravarInicialServ(oTerminal, rDBConnectionParamsServ, pAppObj,
          pProcessLog, pOutput, pLoja, pUsuarioAdmin);
      end;
    end;
  finally
    pProcessLog.RegistreLog('fim');
    pProcessLog.RetorneLocal
  end;
end;

function GarantirDB(pAppObj: IAppObj; pProcessLog: IProcessLog;
  pOutput: IOutput; pLoja: ISisLoja; pUsuarioAdmin: IUsuario;
  pVariaveis: string; pCriouTerminais: Boolean): Boolean;
var
  DBConnectionServ: IDBConnection;
  oDBConnectionParamsServ: TDBConnectionParams;

  sLog: string;
  oAppLojaDBI: IAppLojaDBI;
  sMens: string;

  oSisConfig: ISisConfig;
  // variavel oSisConfig usada apenas para o debug trace into ir direto a chamada do metodo

  oTerminalDBI: ITerminalDBI;
  sPastaDados: string;
  sAtividadeEcon: string;
  bLeuTermListDoServ: Boolean;

  oSisConfigXMLI: ISisConfigXMLI;
begin
  Result := False;

  oSisConfig := pAppObj.SisConfig;

  pProcessLog.PegueLocal('App.DB.Garantir.GarantirDB_u');
  try
    DBMSConfig := DBMSConfigCreate(pAppObj.SisConfig, pProcessLog, pOutput);
    DBMS := DBMSCreate(pAppObj.SisConfig, DBMSConfig, pProcessLog, pOutput);

    pProcessLog.RegistreLog('vai DBMS.GarantirDBMSInstalado');
    Result := DBMS.GarantirDBMSInstalado(pProcessLog, pOutput);

    if not Result then
    begin
      pProcessLog.RegistreLog('retornou false');
      exit;
    end;

    if pAppObj.SisConfig.LocalMachineIsServer then
    begin
      sLog := 'pSisConfig.LocalMachineIsServer=true, vai GarantirDBServ';
      pProcessLog.RegistreLog(sLog);
      Result := GarantirDBServ(pAppObj, pProcessLog, pOutput, pLoja,
        pUsuarioAdmin, pVariaveis);
      if not Result then
      begin
        pProcessLog.RegistreLog('retornou false');
        exit;
      end;
    end;

    oDBConnectionParamsServ := TerminalIdToDBConnectionParams
      (TERMINAL_ID_RETAGUARDA, pAppObj);

    DBConnectionServ := DBConnectionCreate('GarantirDB.CarregLoja.Conn',
      pAppObj.SisConfig, oDBConnectionParamsServ, nil, nil);

    oAppLojaDBI := AppLojaDBICreate(pAppObj.Loja, DBConnectionServ);
    Result := oAppLojaDBI.LerLojaEMachineId(pAppObj, sMens);

    if Result then
    begin
      App.AppObj_u_Ini.AppObjIniGravar(pAppObj);
    end
    else
    begin
      App.AppObj_u_Ini.AppObjIniLer(pAppObj);
    end;

    oTerminalDBI := TerminalDBICreate(DBConnectionServ);

    sPastaDados := pAppObj.AppInfo.PastaDados;
    sAtividadeEcon := AtividadeEconomicaSisDescr
      [pAppObj.AppInfo.AtividadeEconomicaSis];

    // neste ponto,TerminalList tem o que tinha no xml
    // se servidor disponivel, substitui pelo dados servidor
    // senao, ret false
    bLeuTermListDoServ := oTerminalDBI.DBToList(pAppObj.TerminalList,
      sPastaDados, sAtividadeEcon, pAppObj.SisConfig.LocalMachineId.GetIdent);

    if bLeuTermListDoServ then
    begin
      // garantir que xml bate com serv
      oSisConfigXMLI := SisConfigXMLICreate(oSisConfig, pAppObj.TerminalList);
      oSisConfigXMLI.Gravar;
    end;

//    oTerminalDBI.TermDBsParaList(pAppObj.TerminalList, pAppObj.SisConfig,
//      sPastaDados);

    Result := GarantirDBTerms(pAppObj, pProcessLog, pOutput, pLoja,
      pUsuarioAdmin, pVariaveis, pCriouTerminais, sAtividadeEcon);
  finally
    pProcessLog.RegistreLog('fim');
    pProcessLog.RetorneLocal
  end;
end;

end.
