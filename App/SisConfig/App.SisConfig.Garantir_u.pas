unit App.SisConfig.Garantir_u;

interface

uses App.SisConfig.Garantir, Sis.Sis.Executavel_u, Sis.Config.SisConfig,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppInfo;

type
  TAppSisConfigGarantir = class(TExecutavel, IAppSisConfigGarantir)
  private
    FAppInfo: IAppInfo;
    FSisConfig: ISisConfig;
    FOutput: IOutput;
    FProcessLog: IProcessLog;
    FNomeArqXML: string;

    function ArqXmlExiste: boolean;
    procedure CopieInicial;
    procedure CopieAtu;
    function ConfigEdit: boolean;
  public
    function Execute: boolean; override;
    constructor Create(pAppInfo: IAppInfo; pSisConfig: ISisConfig;
      pOutput: IOutput; pProcessLog: IProcessLog);
  end;

implementation

uses Sis.Sis.Constants, System.SysUtils, Sis.Config.ConfigXMLI,
  Sis.Config.Factory, Sis.UI.IO.Files.Sync;

{ TAppSisConfigGarantir }

function TAppSisConfigGarantir.ArqXmlExiste: boolean;
begin
  Result := FileExists(FNomeArqXML);
end;

function TAppSisConfigGarantir.ConfigEdit: boolean;
begin
***
end;

procedure TAppSisConfigGarantir.CopieAtu;
var
  sOrig: string;
  sDest: string;
begin
  FProcessLog.PegueLocal('TAppSisConfigGarantir.CopieAtu');
  try
    sOrig := FAppInfo.Pasta + 'Inst\inst-bin\';
    sDest := FAppInfo.PastaBin;

    FProcessLog.RegistreLog('Sis.UI.IO.Files.Sync.AtualizarArquivos,sOrig=' + sOrig + ',sDest=' + sDest);

    Sis.UI.IO.Files.Sync.AtualizarArquivos(sOrig, sDest, FOutput);
  finally
    FProcessLog.RegistreLog('Fim');
    FProcessLog.RetorneLocal;
  end;
end;

procedure TAppSisConfigGarantir.CopieInicial;
var
  sOrig: string;
  sDest: string;
begin
  FProcessLog.PegueLocal('TAppSisConfigGarantir.CopieInicial');
  try
    sOrig := FAppInfo.Pasta + 'Inst\Inst-Delphi-redist\Redist\win64\';
    sDest := FAppInfo.PastaBin;

    FProcessLog.RegistreLog('Sis.UI.IO.Files.Sync.AtualizarArquivos,sOrig=' + sOrig + ',sDest=' + sDest);

    Sis.UI.IO.Files.Sync.AtualizarArquivos(sOrig, sDest, FOutput);
  finally
    FProcessLog.RegistreLog('Fim');
    FProcessLog.RetorneLocal;
  end;
end;

constructor TAppSisConfigGarantir.Create(pAppInfo: IAppInfo;
  pSisConfig: ISisConfig; pOutput: IOutput; pProcessLog: IProcessLog);
begin
  FAppInfo := pAppInfo;
  FSisConfig := pSisConfig;
  FOutput := pOutput;
  FProcessLog := pProcessLog;

  FProcessLog.PegueLocal('TAppSisConfigGarantir.Create');
  FNomeArqXML := FAppInfo.PastaBin + Sis.Sis.Constants.CONFIG_NOME_ARQ;
  FProcessLog.RegistreLog('NomeArqXML=' + FNomeArqXML);
  FProcessLog.RetorneLocal;
end;

function TAppSisConfigGarantir.Execute: boolean;
var
  oConfigXMLI: IConfigXMLI;
begin
  Result := True;
  FProcessLog.PegueLocal('TAppSisConfigGarantir.Execute');
  try
    oConfigXMLI := ConfigXMLICreate(FSisConfig);

    FProcessLog.RegistreLog('vai testar ArqXmlExiste');
    Result := ArqXmlExiste;
    if Result then
    begin
      FProcessLog.RegistreLog('existia, vai ler e terminar');
      oConfigXMLI.Ler;
      exit;
    end;
    FProcessLog.RegistreLog('não existia, vai CopieInicial');
    CopieInicial;

    Result := ConfigEdit;

    if not Result then
    begin
      FProcessLog.RegistreLog('ConfigEdit, usuario cancelou');
      exit;
    end;

    oConfigXMLI.Gravar;

  finally
    FProcessLog.RegistreLog('vai CopieAtu');
    CopieAtu;
    FProcessLog.RetorneLocal;
  end;

end;

end.
