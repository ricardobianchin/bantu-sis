unit App.DB.Garantir;

interface

uses Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  App.AppObj, Sis.Usuario, Sis.Loja,
  Sis.Entities.TerminalList;

function GarantirDB(pAppObj: IAppObj;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ILoja;
  pUsuarioGerente: IUsuario; pVariaveis: string): boolean;

implementation

uses Sis.DB.Factory, Sis.DB.Updater, Sis.DB.Updater.Factory, App.DB.Utils,
  Sis.Sis.Constants, Sis.Entities.Terminal, Sis.Entities.Types,
  Sis.Lists.IntegerList, Sis.Types.Integers;

var
  DBMSConfig: IDBMSConfig;
  DBMS: IDBMS;

function GarantirDBServ(pAppObj: IAppObj;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ILoja;
  pUsuarioGerente: IUsuario; pVariaveis: string): boolean;
var
  oUpdater: IDBUpdater;
  rDBConnectionParams: TDBConnectionParams;
begin
  pProcessLog.PegueLocal('App.DB.Garantir,GarantirDBServ');

  try
    rDBConnectionParams := TerminalIdToDBConnectionParams
      (TERMINAL_ID_RETAGUARDA, pAppObj);

    oUpdater := DBUpdaterFirebirdCreate(TERMINAL_ID_RETAGUARDA,
      rDBConnectionParams, pAppObj.AppInfo.Pasta, DBMS, pAppObj.SisConfig, pProcessLog,
      pOutput, pLoja, pUsuarioGerente, pAppObj.TerminalList, pVariaveis);

    Result := oUpdater.Execute;
  finally
    pProcessLog.RegistreLog('fim');
    pProcessLog.RetorneLocal
  end;
end;

function GarantirDBTerms(pAppObj: iAppObj;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ILoja;
  pUsuarioGerente: IUsuario; pVariaveis: string): boolean;
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

  if pAppObj.TerminalList.Count = 0 then
  begin
    rDBConnectionParams := TerminalIdToDBConnectionParams
      (TERMINAL_ID_RETAGUARDA, pAppObj);

    oDBConnection := DBConnectionCreate('App.DB.Garantir.GarantirDBTerms.conn',
      pAppObj.SisConfig, rDBConnectionParams, pProcessLog, pOutput);

    PreencherTerminalList(oDBConnection, pAppObj, pAppObj.TerminalList,
      pAppObj.SisConfig.LocalMachineId.Name);
  end;

  try
    for iIndex := 0 to pAppObj.TerminalList.count - 1 do
    begin
      oTerminal := pAppObj.TerminalList[iIndex];

      rDBConnectionParams.Server := oTerminal.NomeNaRede;
      rDBConnectionParams.Arq := oTerminal.LocalArqDados;
      rDBConnectionParams.Database := oTerminal.Database;

      oUpdater := DBUpdaterFirebirdCreate(oTerminal.TerminalId,
        rDBConnectionParams, pAppObj.AppInfo.Pasta, DBMS, pAppObj.SisConfig, pProcessLog,
        pOutput, pLoja, pUsuarioGerente, pAppObj.TerminalList, pVariaveis);

      Result := oUpdater.Execute;
    end;
  finally
    pProcessLog.RegistreLog('fim');
    pProcessLog.RetorneLocal
  end;
end;

function GarantirDB(pAppObj: IAppObj;
  pProcessLog: IProcessLog; pOutput: IOutput; pLoja: ILoja;
  pUsuarioGerente: IUsuario; pVariaveis: string): boolean;
var
  sLog: string;
begin
  Result := False;
  pProcessLog.PegueLocal('App.DB.Garantir.GarantirDB');
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
      Result := GarantirDBServ(pAppObj, pProcessLog, pOutput,
        pLoja, pUsuarioGerente, pVariaveis);
      if not Result then
      begin
        pProcessLog.RegistreLog('retornou false');
        exit;
      end;
    end;

    GarantirDBTerms(pAppObj, pProcessLog, pOutput, pLoja, pUsuarioGerente, pVariaveis);
  finally
    pProcessLog.RegistreLog('fim');
    pProcessLog.RetorneLocal
  end;
end;

end.
