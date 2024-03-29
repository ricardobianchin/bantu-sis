unit App.AppObj_u;

interface

uses App.AppObj, App.AppInfo, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.Config.SisConfig;

type
  TAppObj = class(TInterfacedObject, IAppObj)
  private
    FAppInfo: IAppInfo;

    FStatusOutput: IOutput;
    FProcessOutput: IOutput;
    FProcessLog: IProcessLog;

    FSisConfig: ISisConfig;

    function GetSisConfig: ISisConfig;

  public
    property StatusOutput: IOutput read FStatusOutput;
    property ProcessOutput: IOutput read FProcessOutput;
    property ProcessLog: IProcessLog read FProcessLog;
    property SisConfig: ISisConfig read GetSisConfig;

    function Inicialize: boolean;
    constructor Create(pAppInfo: IAppInfo; pStatusOutput: IOutput;
      pProcessOutput: IOutput; pProcessLog: IProcessLog);
  end;

implementation

uses App.AppObj_u_VaParaPasta, App.AppObj_u_ExecEventos, Sis.Config.Factory, App.Factory, App.DonoConfig.Utils;

{ TAppObj }

constructor TAppObj.Create(pAppInfo: IAppInfo; pStatusOutput: IOutput;
  pProcessOutput: IOutput; pProcessLog: IProcessLog);
begin
  FAppInfo := pAppInfo;

  FStatusOutput := pStatusOutput;
  FProcessOutput := pProcessOutput;
  FProcessLog := pProcessLog;

  ProcessLog.PegueLocal('TAppObj.Create');
  try
    ProcessLog.RegistreLog('Create, vai criar FSisConfig');
    FSisConfig := SisConfigCreate;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

function TAppObj.GetSisConfig: ISisConfig;
begin
  Result := FSisConfig;
end;

function TAppObj.Inicialize: boolean;
begin
  ProcessLog.PegueLocal('TAppObj.Inicialize');
  Result := True;
  try
    ProcessLog.RegistreLog('Inicio');
    FStatusOutput.Exibir('App inicializando...');
    FProcessOutput.Exibir('App inicializando...');

    ExecEvento(TSessaoMomento.ssmomInicio, FAppInfo, FStatusOutput, ProcessLog);

    App.AppObj_u_VaParaPasta.VaParaPastaExe(FAppInfo, ProcessLog);

    App.DonoConfig.Utils.DonoConfigLer(FAppInfo);

  finally
    ProcessLog.RegistreLog('Fim');
    ProcessLog.RetorneLocal;
  end;
end;

end.
