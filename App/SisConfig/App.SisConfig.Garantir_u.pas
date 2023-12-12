unit App.SisConfig.Garantir_u;

interface

uses App.SisConfig.Garantir, Sis.Sis.Executavel_u, Sis.Config.SisConfig,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppInfo, Sis.Usuario,
  Sis.Loja;

type
  TAppSisConfigGarantir = class(TExecutavel, IAppSisConfigGarantir)
  private
    FAppInfo: IAppInfo;
    FSisConfig: ISisConfig;
//    FOutput: IOutput;
//    FProcessLog: IProcessLog;
    FNomeArqXML: string;

    FUsuarioGerente: IUsuario;
    FLoja: ILoja;

    function ArqXmlExiste: boolean;
    procedure CopieInicial;
    procedure CopieAtu;
    function ConfigEdit: boolean;
    procedure PreenchaSisConfigVersao;
  public
    function Execute: boolean; override;
    constructor Create(pAppInfo: IAppInfo; pSisConfig: ISisConfig;
      pUsuarioGerente: IUsuario; pLoja: ILoja; pOutput: IOutput;
      pProcessLog: IProcessLog);
  end;

implementation

uses Sis.Sis.Constants, System.SysUtils, Sis.Config.ConfigXMLI, Sis.Win.Utils_u,
  Sis.Config.Factory, Sis.UI.IO.Files.Sync, Vcl.Controls,
  App.UI.Config.ConfigForm;

{ TAppSisConfigGarantir }

function TAppSisConfigGarantir.ArqXmlExiste: boolean;
begin
  Result := FileExists(FNomeArqXML);
end;

function TAppSisConfigGarantir.ConfigEdit: boolean;
var
  r: tmodalresult;
begin
  StarterFormConfig := TStarterFormConfig.Create(nil, FSisConfig,
    FUsuarioGerente, FLoja);
  try
    r := StarterFormConfig.ShowModal;
    Result := IsPositiveResult(r);
  finally
    StarterFormConfig.Free;
  end;
end;

procedure TAppSisConfigGarantir.CopieAtu;
var
  sOrig: string;
  sDest: string;
begin
  ProcessLog.PegueLocal('TAppSisConfigGarantir.CopieAtu');
  try
    sOrig := FAppInfo.Pasta + 'Inst\inst-bin\';
    sDest := FAppInfo.PastaBin;

    ProcessLog.RegistreLog('Sis.UI.IO.Files.Sync.AtualizarArquivos,sOrig=' +
      sOrig + ',sDest=' + sDest);

    Sis.UI.IO.Files.Sync.AtualizarArquivos(sOrig, sDest, Output);
  finally
    ProcessLog.RegistreLog('Fim');
    ProcessLog.RetorneLocal;
  end;
end;

procedure TAppSisConfigGarantir.CopieInicial;
var
  sOrig: string;
  sDest: string;
begin
  ProcessLog.PegueLocal('TAppSisConfigGarantir.CopieInicial');
  try
    sOrig := FAppInfo.Pasta + 'Inst\Inst-Delphi-redist\Redist\win64\';
    sDest := FAppInfo.PastaBin;

    ProcessLog.RegistreLog('Sis.UI.IO.Files.Sync.AtualizarArquivos,sOrig=' +
      sOrig + ',sDest=' + sDest);

    Sis.UI.IO.Files.Sync.AtualizarArquivos(sOrig, sDest, Output);
  finally
    ProcessLog.RegistreLog('Fim');
    ProcessLog.RetorneLocal;
  end;
end;

constructor TAppSisConfigGarantir.Create(pAppInfo: IAppInfo; pSisConfig: ISisConfig;
      pUsuarioGerente: IUsuario; pLoja: ILoja; pOutput: IOutput;
      pProcessLog: IProcessLog);
begin
  inherited Create(pOutput, pProcessLog);
  FAppInfo := pAppInfo;
  FSisConfig := pSisConfig;
  FLoja := pLoja;
  FUsuarioGerente := pUsuarioGerente;

  ProcessLog.PegueLocal('TAppSisConfigGarantir.Create');
  FNomeArqXML := FAppInfo.PastaBin + Sis.Sis.Constants.CONFIG_NOME_ARQ;
  ProcessLog.RegistreLog('NomeArqXML=' + FNomeArqXML);
  ProcessLog.RetorneLocal;
end;

function TAppSisConfigGarantir.Execute: boolean;
var
  oConfigXMLI: IConfigXMLI;
begin
  Result := True;
  ProcessLog.PegueLocal('TAppSisConfigGarantir.Execute');
  try
    oConfigXMLI := ConfigXMLICreate(FSisConfig);

    ProcessLog.RegistreLog('vai testar ArqXmlExiste');
    Result := ArqXmlExiste;
    if Result then
    begin
      ProcessLog.RegistreLog('existia, vai ler e terminar');
      oConfigXMLI.Ler;
      exit;
    end;
    ProcessLog.RegistreLog('não existia, vai CopieInicial');
    CopieInicial;

    PreenchaSisConfigVersao;

    Result := ConfigEdit;

    if not Result then
    begin
      ProcessLog.RegistreLog('ConfigEdit, usuario cancelou');
      exit;
    end;

    oConfigXMLI.Gravar;

  finally
    ProcessLog.RegistreLog('vai CopieAtu');
    CopieAtu;
    ProcessLog.RetorneLocal;
  end;
end;

procedure TAppSisConfigGarantir.PreenchaSisConfigVersao;
var
  iMajor: integer;
  iMinor: integer;
  sCSDVersion: string;
begin
  if not GetWindowsVersion(iMajor, iMinor, sCSDVersion) then
    raise Exception.Create(Sis.Sis.Constants.MSG_ERRO_WINVERSION);

  if Sis.Win.Utils_u.IsWow64Process then
    FSisConfig.WinVersionInfo.winplatform := wplatWin64
  else
    FSisConfig.WinVersionInfo.winplatform := wplatWin32;

  FSisConfig.WinVersionInfo.PegarVersion(iMajor, iMinor);
  FSisConfig.WinVersionInfo.CSDVersion := sCSDVersion;
end;

end.
