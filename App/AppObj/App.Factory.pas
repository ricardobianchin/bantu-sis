unit App.Factory;

interface

uses App.AppObj, App.AppInfo, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  App.AtualizaVersao, Sis.Config.SisConfig, App.SisConfig.Garantir, App.Loja,
  Sis.Usuario, Sis.DB.DBTypes, App.DB.Log, App.Testes.Config, Sis.TerminalList,
  Sis.Terminal.DBI;

function AppInfoCreate(pExeName: string; pAtualizExeSubPasta: string;
  pAtualizExeURL: string): IAppInfo;

function AppObjCreate(pAppInfo: IAppInfo; pLoja: IAppLoja; pDBMS: IDBMS;
  pStatusOutput: IOutput; pProcessOutput: IOutput; pProcessLog: IProcessLog;
  pTerminalList: ITerminalList): IAppObj;

function AppAtualizaVersaoCreate(pAppInfo: IAppInfo; pOutput: IOutput;
  pProcessLog: IProcessLog): IAtualizaVersao;

function SisConfigGarantirCreate(pAppObj: IAppObj; pSisConfig: ISisConfig;
  pUsuarioAdmin: IUsuario; pLoja: IAppLoja; pOutput: IOutput;
  pProcessLog: IProcessLog; pTerminalList: ITerminalList;
  pTerminalDBI: ITerminalDBI): IAppSisConfigGarantirXML;

function AppTestesConfigCreate(pProcessLog: IProcessLog = nil;
  pOutput: IOutput = nil): IAppTestesConfig;

implementation

uses App.AppObj_u, App.AppInfo_u, App.AtualizaVersao_u, Sis.Config.SisConfig_u,
  App.SisConfig.Garantir_u, App.DB.Log_u, App.Testes.Config_u;

function AppInfoCreate(pExeName: string; pAtualizExeSubPasta: string;
  pAtualizExeURL: string): IAppInfo;
begin
  Result := TAppInfo.Create(pExeName, pAtualizExeSubPasta, pAtualizExeURL);
end;

function AppObjCreate(pAppInfo: IAppInfo; pLoja: IAppLoja; pDBMS: IDBMS;
  pStatusOutput: IOutput; pProcessOutput: IOutput; pProcessLog: IProcessLog;
  pTerminalList: ITerminalList): IAppObj;
begin
  Result := TAppObj.Create(pAppInfo, pLoja, pDBMS, pStatusOutput,
    pProcessOutput, pProcessLog, pTerminalList);
end;

function AppAtualizaVersaoCreate(pAppInfo: IAppInfo; pOutput: IOutput;
  pProcessLog: IProcessLog): IAtualizaVersao;
begin
  Result := TAtualizaVersao.Create(pAppInfo, pOutput, pProcessLog);
end;

function SisConfigGarantirCreate(pAppObj: IAppObj; pSisConfig: ISisConfig;
  pUsuarioAdmin: IUsuario; pLoja: IAppLoja; pOutput: IOutput;
  pProcessLog: IProcessLog; pTerminalList: ITerminalList;
  pTerminalDBI: ITerminalDBI): IAppSisConfigGarantirXML;
begin
  Result := TAppSisConfigGarantirXML.Create(pAppObj, pSisConfig, pUsuarioAdmin,
    pLoja, pOutput, pProcessLog, pTerminalList, pTerminalDBI);
end;

function AppTestesConfigCreate(pProcessLog: IProcessLog = nil;
  pOutput: IOutput = nil): IAppTestesConfig;
begin
  Result := TAppTestesConfig.Create(pProcessLog, pOutput);

end;

end.
