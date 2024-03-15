unit App.AppObj;

interface

uses Sis.Config.SisConfig, App.AppInfo, Sis.UI.IO.Output, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog;

type
  IAppObj = interface(IInterface)
    ['{DC6EC674-3089-4213-8542-65232780AE51}']

    function GetSisConfig: ISisConfig;
    property SisConfig: ISisConfig read GetSisConfig;

    function Inicialize: boolean;

    function GetAppInfo: IAppInfo;
    property AppInfo: IAppInfo read GetAppInfo;

    function GetDBMS: IDBMS;
    property DBMS: IDBMS read GetDBMS;

    function GetStatusOutput: IOutput;
    function GetProcessOutput: IOutput;
    function GetProcessLog: IProcessLog;

    property StatusOutput: IOutput read GetStatusOutput;
    property ProcessOutput: IOutput read GetProcessOutput;
    property ProcessLog: IProcessLog read GetProcessLog;
  end;

implementation

end.
