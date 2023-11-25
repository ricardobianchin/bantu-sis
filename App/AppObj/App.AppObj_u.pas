unit App.AppObj_u;

interface

uses App.AppObj, App.AppInfo, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog;

type
  TAppObj = class(TInterfacedObject, IAppObj)
  private
    FAppInfo: IAppInfo;

    FStatusOutput: IOutput;
    FProcessOutput: IOutput;
    FProcessLog: IProcessLog;
  public
    property StatusOutput: IOutput read FStatusOutput;
    property ProcessOutput: IOutput read FProcessOutput;
    property ProcessLog: IProcessLog read FProcessLog;

    procedure Inicialize;
    constructor Create(pAppInfo: IAppInfo; pStatusOutput: IOutput;
      pProcessOutput: IOutput; pProcessLog: IProcessLog);
  end;

implementation

uses App.AppObj_u_VaParaPasta, App.AppObj_u_ExecEventos;

{ TAppObj }

constructor TAppObj.Create(pAppInfo: IAppInfo; pStatusOutput: IOutput;
  pProcessOutput: IOutput; pProcessLog: IProcessLog);
begin
  FAppInfo := pAppInfo;

  FStatusOutput := pStatusOutput;
  FProcessOutput := pProcessOutput;
  FProcessLog := pProcessLog;

  ProcessLog.PegueLocal('TAppObj.Create');
  ProcessLog.RegistreLog('Create');
  ProcessLog.RetorneLocal;
end;

procedure TAppObj.Inicialize;
begin
  ProcessLog.PegueLocal('TAppObj.Inicialize');
  try
    ProcessLog.RegistreLog('Inicio');
    FStatusOutput.Exibir('App inicializando...');
    FProcessOutput.Exibir('App inicializando...');


    ExecEvento(TSessaoMomento.ssmomInicio, FAppInfo, FStatusOutput, ProcessLog);

    App.AppObj_u_VaParaPasta.VaParaPastaExe(FAppInfo, ProcessLog);


  finally
    ExecEvento(TSessaoMomento.ssmomFim, FAppInfo, FStatusOutput, ProcessLog);
    ProcessLog.RegistreLog('Fim');
    ProcessLog.RetorneLocal;
  end;

end;

end.
