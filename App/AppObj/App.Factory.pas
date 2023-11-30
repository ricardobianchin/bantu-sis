unit App.Factory;

interface

uses App.AppObj, App.AppInfo, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  App.AtualizaVersao;

function AppInfoCreate(pExeName: string; pAtualizExeSubPasta: string;
  pAtualizExeURL: string): IAppInfo;

function AppObjCreate(pAppInfo: IAppInfo; pStatusOutput: IOutput;
  pProcessOutput: IOutput; pProcessLog: IProcessLog): IAppObj;

function AppAtualizaVersaoCreate(pAppInfo: IAppInfo; pOutput: IOutput;
  pProcessLog: IProcessLog): IAtualizaVersao;

implementation

uses App.AppObj_u, App.AppInfo_u, App.AtualizaVersao_u;

function AppInfoCreate(pExeName: string; pAtualizExeSubPasta: string;
  pAtualizExeURL: string): IAppInfo;
begin
  Result := TAppInfo.Create(pExeName, pAtualizExeSubPasta, pAtualizExeURL);
end;

function AppObjCreate(pAppInfo: IAppInfo; pStatusOutput: IOutput;
  pProcessOutput: IOutput; pProcessLog: IProcessLog): IAppObj;
begin
  Result := TAppObj.Create(pAppInfo, pStatusOutput, pProcessOutput,
    pProcessLog);
end;

function AppAtualizaVersaoCreate(pAppInfo: IAppInfo; pOutput: IOutput;
  pProcessLog: IProcessLog): IAtualizaVersao;
begin
  Result := TAtualizaVersao.Create(pAppInfo, pOutput, pProcessLog);
end;

end.
