unit App.Factory;

interface

uses App.AppObj, App.AppInfo, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  App.AtualizaVersao, Sis.Config.SisConfig, App.SisConfig.Garantir, Sis.Loja,
  Sis.Usuario, Sis.DB.DBTypes, App.DB.Log;

function AppInfoCreate(pExeName: string; pAtualizExeSubPasta: string;
  pAtualizExeURL: string): IAppInfo;

function AppObjCreate(pAppInfo: IAppInfo; pLoja: ILoja; pDBMS: IDBMS; pStatusOutput: IOutput;
  pProcessOutput: IOutput; pProcessLog: IProcessLog): IAppObj;

function AppAtualizaVersaoCreate(pAppInfo: IAppInfo; pOutput: IOutput;
  pProcessLog: IProcessLog): IAtualizaVersao;

function SisConfigGarantirCreate(pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pUsuarioGerente: IUsuario; pLoja: ILoja; pOutput: IOutput;
  pProcessLog: IProcessLog): IAppSisConfigGarantirXML;

implementation

uses App.AppObj_u, App.AppInfo_u, App.AtualizaVersao_u, Sis.Config.SisConfig_u,
  App.SisConfig.Garantir_u, App.DB.Log_u;

function AppInfoCreate(pExeName: string; pAtualizExeSubPasta: string;
  pAtualizExeURL: string): IAppInfo;
begin
  Result := TAppInfo.Create(pExeName, pAtualizExeSubPasta, pAtualizExeURL);
end;

function AppObjCreate(pAppInfo: IAppInfo; pLoja: ILoja; pDBMS: IDBMS; pStatusOutput: IOutput;
  pProcessOutput: IOutput; pProcessLog: IProcessLog): IAppObj;
begin
  Result := TAppObj.Create(pAppInfo, pLoja, pDBMS, pStatusOutput, pProcessOutput,
    pProcessLog);
end;

function AppAtualizaVersaoCreate(pAppInfo: IAppInfo; pOutput: IOutput;
  pProcessLog: IProcessLog): IAtualizaVersao;
begin
  Result := TAtualizaVersao.Create(pAppInfo, pOutput, pProcessLog);
end;

function SisConfigGarantirCreate(pAppInfo: IAppInfo; pSisConfig: ISisConfig;
  pUsuarioGerente: IUsuario; pLoja: ILoja; pOutput: IOutput;
  pProcessLog: IProcessLog): IAppSisConfigGarantirXML;
begin
  Result := TAppSisConfigGarantirXML.Create(pAppInfo, pSisConfig, pUsuarioGerente,
    pLoja, pOutput, pProcessLog);
end;

end.
