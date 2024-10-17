unit App.AppObj;

interface

uses Sis.UI.IO.Output, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog //

  , App.Testes.Config //

  , Sis.Config.SisConfig //

  , App.AppInfo //

  , Sis.Loja, Sis.Entities.TerminalList //

  ; //

{
  AppTestesConfig = da camada App, configuracoes dos testes
  pode ter, por exemplo, uma flag Loja.AutoExec que se for true, assim que entra
  no modulo, abre a janela de Lojas

  os objetos imitam a estrutur do arquivo
    C:\Pr\app\bantu\bantu-sis\Exe\Configs\app.testes.config.xml
    .\Exe\Configs\app.testes.config.xml
}
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

    procedure SetProcessOutput(Value: IOutput);

    property StatusOutput: IOutput read GetStatusOutput;
    property ProcessOutput: IOutput read GetProcessOutput write SetProcessOutput;
    property ProcessLog: IProcessLog read GetProcessLog;

    function GetLoja: ILoja;
    property Loja: ILoja read GetLoja;

    function GetTerminalList: ITerminalList;
    property TerminalList: ITerminalList read GetTerminalList;

  end;

implementation

end.
