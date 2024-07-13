unit App.AppObj;

interface

uses Sis.Config.SisConfig, App.AppInfo, Sis.UI.IO.Output, Sis.DB.DBTypes,
  Sis.UI.IO.Output.ProcessLog, Sis.Loja, App.Testes.Config;

type
  IAppObj = interface(IInterface)
    ['{DC6EC674-3089-4213-8542-65232780AE51}']

    function GetAppTestesConfig: IAppTestesConfig;
    property AppTestesConfig: IAppTestesConfig read GetAppTestesConfig;

    function GetSisConfig: ISisConfig;
    property SisConfig: ISisConfig read GetSisConfig;

    function Inicialize: boolean;

    function GetAppInfo: IAppInfo;
    property AppInfo: IAppInfo read GetAppInfo;

    function GetDBMS: IDBMS;
    procedure SetDBMS(Value: IDBMS);
    property DBMS: IDBMS read GetDBMS write SetDBMS;

    function GetStatusOutput: IOutput;
    function GetProcessOutput: IOutput;
    function GetProcessLog: IProcessLog;

    property StatusOutput: IOutput read GetStatusOutput;
    property ProcessOutput: IOutput read GetProcessOutput;
    property ProcessLog: IProcessLog read GetProcessLog;

    function GetLoja: ILoja;
    property Loja: ILoja read GetLoja;
  end;

implementation

end.
