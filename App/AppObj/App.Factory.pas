unit App.Factory;

interface

uses App.AppObj, App.AppInfo, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

function AppInfoCreate(pExeName: string): IAppInfo;
function AppObjCreate(pAppInfo: IAppInfo; pStatusOutput: IOutput;
  pProcessOutput: IOutput; pProcessLog: IProcessLog): IAppObj;

implementation

uses App.AppObj_u, App.AppInfo_u;

function AppInfoCreate(pExeName: string): IAppInfo;
begin
  Result := TAppInfo.Create(pExeName);
end;

function AppObjCreate(pAppInfo: IAppInfo; pStatusOutput: IOutput;
  pProcessOutput: IOutput; pProcessLog: IProcessLog): IAppObj;
begin
  Result := TAppObj.Create(pAppInfo, pStatusOutput, pProcessOutput,
    pProcessLog);
end;

end.
