unit App.AppObj_u;

interface

uses App.AppObj, App.AppInfo, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.Config.SisConfig, Sis.DB.DBTypes, Sis.Loja_u, Sis.Loja, App.Testes.Config;

type
  TAppObj = class(TInterfacedObject, IAppObj)
  private
    FAppInfo: IAppInfo;
    FLoja: ILoja;
    FAppTestesConfig: IAppTestesConfig;

    FStatusOutput: IOutput;
    FProcessOutput: IOutput;
    FProcessLog: IProcessLog;
    FSisConfig: ISisConfig;
    FDBMS: IDBMS;

    function GetAppTestesConfig: IAppTestesConfig;

    function GetSisConfig: ISisConfig;
    function GetAppInfo: IAppInfo;
    function GetDBMS: IDBMS;
    procedure SetDBMS(Value: IDBMS);

    function GetStatusOutput: IOutput;
    function GetProcessOutput: IOutput;
    function GetProcessLog: IProcessLog;
    function GetLoja: ILoja;


  public
    property AppTestesConfig: IAppTestesConfig read GetAppTestesConfig;
    property StatusOutput: IOutput read FStatusOutput;
    property ProcessOutput: IOutput read FProcessOutput;
    property ProcessLog: IProcessLog read FProcessLog;
    property SisConfig: ISisConfig read GetSisConfig;
    property AppInfo: IAppInfo read GetAppInfo;
    property Loja: ILoja read GetLoja;


    function Inicialize: boolean;
    constructor Create(pAppInfo: IAppInfo; pLoja: ILoja; pDBMS: IDBMS; pStatusOutput: IOutput;
      pProcessOutput: IOutput; pProcessLog: IProcessLog);
  end;

implementation

uses App.AppObj_u_VaParaPasta, App.AppObj_u_ExecEventos, Sis.Config.Factory,
  App.Factory, App.DonoConfig.Utils;

{ TAppObj }

constructor TAppObj.Create(pAppInfo: IAppInfo; pLoja: ILoja; pDBMS: IDBMS;
  pStatusOutput: IOutput; pProcessOutput: IOutput; pProcessLog: IProcessLog);
begin
  FAppTestesConfig := App.Factory.AppTestesConfigCreate(pProcessLog,
    pStatusOutput);

  FAppInfo := pAppInfo;
  FLoja := pLoja;
  FDBMS := pDBMS;
  FStatusOutput := pStatusOutput;
  FProcessOutput := pProcessOutput;
  FProcessLog := pProcessLog;

  ProcessLog.PegueLocal('TAppObj.Create');
  try
    ProcessLog.RegistreLog('Create, vai criar FSisConfig');
    FSisConfig := SisConfigCreate;
    {$IFDEF DEBUG}
      FAppTestesConfig.Ler;
      FAppTestesConfig.Gravar;
    {$ENDIF}
  finally
    ProcessLog.RetorneLocal;
  end;
end;

function TAppObj.GetAppInfo: IAppInfo;
begin
  Result := FAppInfo;
end;

function TAppObj.GetAppTestesConfig: IAppTestesConfig;
begin
  Result := FAppTestesConfig;
end;

function TAppObj.GetDBMS: IDBMS;
begin
  Result := FDBMS;
end;

function TAppObj.GetLoja: ILoja;
begin
  Result := FLoja;
end;

function TAppObj.GetProcessLog: IProcessLog;
begin
  Result := FProcessLog;
end;

function TAppObj.GetProcessOutput: IOutput;
begin
  Result := FProcessOutput;
end;

function TAppObj.GetSisConfig: ISisConfig;
begin
  Result := FSisConfig;
end;

function TAppObj.GetStatusOutput: IOutput;
begin
  Result := FStatusOutput;
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

procedure TAppObj.SetDBMS(Value: IDBMS);
begin
  FDBMS := Value;
end;

end.
