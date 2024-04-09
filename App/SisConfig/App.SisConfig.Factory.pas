unit App.SisConfig.Factory;

interface

uses App.SisConfig.DBI, Sis.Config.SisConfig, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, App.AppInfo, Sis.DB.DBTypes;

function SisConfigDBICreate(pSisConfig: ISisConfig; pAppInfo: IAppInfo;
  pDBMS: IDBMS; pProcessLog: IProcessLog; pOutput: IOutput): ISisConfigDBI;

implementation

uses App.SisConfig.DBI_u;

function SisConfigDBICreate(pSisConfig: ISisConfig; pAppInfo: IAppInfo;
  pDBMS: IDBMS; pProcessLog: IProcessLog; pOutput: IOutput): ISisConfigDBI;
begin
  Result := TSisConfigDBI.Create(pSisConfig, pAppInfo, pDBMS,
    pProcessLog, pOutput);
end;

end.
