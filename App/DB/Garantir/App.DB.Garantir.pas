unit App.DB.Garantir;

interface

uses Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.Config.SisConfig, App.AppInfo, Sis.Usuario, Sis.Loja,
  Sis.Entities.TerminalList;

function GarantirDB(pSisConfig: ISisConfig; pAppInfo: IAppInfo;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ILoja;
  pUsuarioGerente: IUsuario; pTerminalList: ITerminalList): boolean;

implementation

uses Sis.DB.Factory, Sis.DB.Updater, Sis.DB.Updater.Factory, App.DB.Utils,
  Sis.Sis.Constants, Sis.Entities.Terminal, Sis.Entities.Types,
  Sis.Lists.IntegerList, Sis.Types.Integers;

var
  DBMSConfig: IDBMSConfig;
  DBMS: IDBMS;

function GarantirDBServ(pSisConfig: ISisConfig; pAppInfo: IAppInfo;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ILoja;
  pUsuarioGerente: IUsuario; pTerminalList: ITerminalList): boolean;
var
  oUpdater: IDBUpdater;
  rDBConnectionParams: TDBConnectionParams;
begin
  pProcessLog.PegueLocal('App.DB.Garantir,GarantirDBServ');

  try
    rDBConnectionParams := TerminalIdToDBConnectionParams
      (TERMINAL_ID_RETAGUARDA, pAppInfo, pSisConfig);

    oUpdater := DBUpdaterFirebirdCreate(TERMINAL_ID_RETAGUARDA,
      rDBConnectionParams, pAppInfo.Pasta, DBMS, pSisConfig, pProcessLog,
      pOutput, pLoja, pUsuarioGerente, pTerminalList);

    Result := oUpdater.Execute;
  finally
    pProcessLog.RegistreLog('fim');
    pProcessLog.RetorneLocal
  end;
end;

function GarantirDBTerms(pSisConfig: ISisConfig; pAppInfo: IAppInfo;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ILoja;
  pUsuarioGerente: IUsuario; pTerminalList: ITerminalList): boolean;
var
  oUpdater: IDBUpdater;
  rDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
  oTerminal: ITerminal;
  iIndex: integer;
begin
  pProcessLog.PegueLocal('App.DB.Garantir,GarantirDBTerms');
  {
    MONTAR ENDERECO DO TERM COM A LETRA DO DRIVE
    pProcessLog.PegueLocal('App.DB.Garantir,GarantirDBServ');
  }

  if pTerminalList.Count = 0 then
  begin
    rDBConnectionParams := TerminalIdToDBConnectionParams
      (TERMINAL_ID_RETAGUARDA, pAppInfo, pSisConfig);

    oDBConnection := DBConnectionCreate('App.DB.Garantir.GarantirDBTerms.conn',
      pSisConfig, rDBConnectionParams, pProcessLog, pOutput);

    PreencherTerminalList(oDBConnection, pAppInfo, pTerminalList,
      pSisConfig.LocalMachineId.Name);
  end;

  try
    for iIndex := 0 to pTerminalList.count - 1 do
    begin
      oTerminal := pTerminalList[iIndex];

      rDBConnectionParams.Server := oTerminal.NomeNaRede;
      rDBConnectionParams.Arq := oTerminal.LocalArqDados;
      rDBConnectionParams.Database := oTerminal.Database;

      oUpdater := DBUpdaterFirebirdCreate(oTerminal.TerminalId,
        rDBConnectionParams, pAppInfo.Pasta, DBMS, pSisConfig, pProcessLog,
        pOutput, pLoja, pUsuarioGerente, pTerminalList);

      Result := oUpdater.Execute;
    end;
  finally
    pProcessLog.RegistreLog('fim');
    pProcessLog.RetorneLocal
  end;
end;

function GarantirDB(pSisConfig: ISisConfig; pAppInfo: IAppInfo;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ILoja;
  pUsuarioGerente: IUsuario; pTerminalList: ITerminalList): boolean;
var
  sLog: string;
begin
  Result := False;
  pProcessLog.PegueLocal('App.DB.Garantir.GarantirDB');
  try
    DBMSConfig := DBMSConfigCreate(pSisConfig, pProcessLog, pOutput);
    DBMS := DBMSCreate(pSisConfig, DBMSConfig, pProcessLog, pOutput);

    pProcessLog.RegistreLog('vai DBMS.GarantirDBMSInstalado');
    Result := DBMS.GarantirDBMSInstalado(pProcessLog, pOutput);
    if not Result then
    begin
      pProcessLog.RegistreLog('retornou false');
      exit;
    end;

    if pSisConfig.LocalMachineIsServer then
    begin
      sLog := 'pSisConfig.LocalMachineIsServer=true, vai GarantirDBServ';
      pProcessLog.RegistreLog(sLog);
      Result := GarantirDBServ(pSisConfig, pAppInfo, pProcessLog, pOutput,
        pLoja, pUsuarioGerente, pTerminalList);
      if not Result then
      begin
        pProcessLog.RegistreLog('retornou false');
        exit;
      end;
    end;

    GarantirDBTerms(pSisConfig, pAppInfo, pProcessLog, pOutput, pLoja,
      pUsuarioGerente, pTerminalList)

  finally
    pProcessLog.RegistreLog('fim');
    pProcessLog.RetorneLocal
  end;
end;

end.
