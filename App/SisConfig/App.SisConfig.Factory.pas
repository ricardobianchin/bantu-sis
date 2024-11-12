unit App.SisConfig.Factory;

interface

uses App.SisConfig.DBI, Sis.Config.SisConfig, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, App.AppObj, Sis.DB.DBTypes;

function SisConfigDBICreate(pAppObj: IAppObj;
  pDBMS: IDBMS; pProcessLog: IProcessLog; pOutput: IOutput): ISisConfigDBI;

implementation

uses App.SisConfig.DBI_u;

function SisConfigDBICreate(pAppObj: IAppObj;
  pDBMS: IDBMS; pProcessLog: IProcessLog; pOutput: IOutput): ISisConfigDBI;
begin
  Result := TSisConfigDBI.Create(pAppObj, pDBMS,
    pProcessLog, pOutput);
end;

end.
