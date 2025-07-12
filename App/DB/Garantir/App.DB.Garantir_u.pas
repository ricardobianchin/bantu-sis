unit App.DB.Garantir_u;

interface

uses Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  App.AppObj, Sis.Usuario, Sis.Loja, Sis.TerminalList, Sis.Terminal.DBI;

function GarantirDB(pAppObj: IAppObj; pProcessLog: IProcessLog;
  pOutput: IOutput; pLoja: ISisLoja; pUsuarioAdmin: IUsuario;
  pVariaveis: string; pCriouTerminais: Boolean): Boolean;

implementation

uses Sis.DB.Factory, Sis.DB.Updater, Sis.DB.Updater.Factory, App.DB.Utils,
  Sis.Sis.Constants, Sis.Terminal, Sis.Entities.Types, Sis.Lists.IntegerList,
  Sis.Types.Integers, App.AppInfo.Types, Sis.Terminal.Factory_u,
  App.SisConfig.DBI, App.SisConfig.Factory, Sis.Terminal.Utils_u,
  System.SysUtils, System.Classes, App.DB.Garantir_u.GravarInicialTerm,
  App.DB.Garantir_u.GravarInicialServ;

var
  DBMSConfig: IDBMSConfig;
  DBMS: IDBMS;

procedure CarregarMachineId(pAppObj: IAppObj; pProcessLog: IProcessLog;
  pOutput: IOutput);
var
  oSisConfigDBI: ISisConfigDBI;
  sNomeArq: string;
  bLeuArq: Boolean;
  SL: TStringList;
  i: integer;
  sNomeServ: string;
  sNomeLocal: string;
  sLinha: string;
begin
  {
    primeiro tenta ler do txt local
    se leu, aborta
    se nao der certo,
    tenta ler do db servidor
    grava txt local
  }
  SL := TStringList.Create;
  try
    sNomeArq := pAppObj.AppInfo.PastaConfigs + 'Sis.Config.MachineId.ini';
    try
      bLeuArq := FileExists(sNomeArq);
      if not bLeuArq then
        exit;

      SL.LoadFromFile(sNomeArq);

      // ler serv
      sNomeServ := pAppObj.SisConfig.ServerMachineId.Name;
      i := StrToIntDef(SL.Values[sNomeServ], 0);
      bLeuArq := i > 0;
      if not bLeuArq then
        exit;
      pAppObj.SisConfig.ServerMachineId.IdentId := i;

      // ler term
      sNomeLocal := pAppObj.SisConfig.LocalMachineId.Name;
      i := StrToIntDef(SL.Values[sNomeLocal], 0);
      bLeuArq := i > 0;
      if not bLeuArq then
        exit;
      pAppObj.SisConfig.LocalMachineId.IdentId := i;

    finally
      if not bLeuArq then
      begin
        oSisConfigDBI := SisConfigDBICreate(pAppObj, DBMS, pProcessLog,
          pOutput);
        oSisConfigDBI.LerMachineIdent;

        SL.Clear;

        sLinha := pAppObj.SisConfig.ServerMachineId.Name + '=' +
          inttostr(pAppObj.SisConfig.ServerMachineId.IdentId);
        SL.Add(sLinha);

        sLinha := pAppObj.SisConfig.LocalMachineId.Name + '=' +
          inttostr(pAppObj.SisConfig.LocalMachineId.IdentId);
        SL.Add(sLinha);
        SL.SaveToFile(sNomeArq);
      end;
    end;
  finally
    SL.Free;
  end;
end;

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
  pVariaveis: string; pCriouTerminais: Boolean): Boolean;
var
  oUpdater: IDBUpdater;
  rDBConnectionParamsServ: TDBConnectionParams;
  oDBConnectionServ: IDBConnection;
  rDBConnectionParamsTerm: TDBConnectionParams;
  oDBConnectionTerm: IDBConnection;
  oTerminal: ITerminal;
  iIndex: integer;
  sAtivDescr: string;
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

    oTerminalDBI.DBToList(pAppObj.TerminalList, pAppObj.AppInfo.PastaDados,
    sAtivDescr, pAppObj.SisConfig.LocalMachineId.Name);
    end;
  }
  try
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

      Result := oUpdater.Execute;

      if pCriouTerminais then
      begin
        GravarInicialTerm(oTerminal, rDBConnectionParamsTerm, pAppObj,
          pProcessLog, pOutput, pLoja, pUsuarioAdmin);

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
  sLog: string;
begin
  Result := False;
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

    CarregarMachineId(pAppObj, pProcessLog, pOutput);

    Result := GarantirDBTerms(pAppObj, pProcessLog, pOutput, pLoja, pUsuarioAdmin,
      pVariaveis, pCriouTerminais);
  finally
    pProcessLog.RegistreLog('fim');
    pProcessLog.RetorneLocal
  end;
end;

end.
