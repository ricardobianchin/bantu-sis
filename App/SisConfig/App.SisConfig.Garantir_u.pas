unit App.SisConfig.Garantir_u;

interface

uses App.SisConfig.Garantir, Sis.Sis.Executavel_u, Sis.Config.SisConfig,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppInfo, Sis.Usuario,
  Sis.Loja, Sis.Entities.TerminalList;

type
  TAppSisConfigGarantirXML = class(TExecutavel, IAppSisConfigGarantirXML)
  private
    FAppInfo: IAppInfo;
    FSisConfig: ISisConfig;
    // FOutput: IOutput;
    // FProcessLog: IProcessLog;
    FNomeArqXML: string;

    FUsuarioGerente: IUsuario;
    FLoja: ILoja;
    FTerminalList: ITerminalList;

    function ArqXmlExiste: boolean;
    procedure CopieInicial;
    procedure CopieAtu;
    function ConfigEdit: boolean;
    procedure PreenchaSisConfigVersao;
  public
    function Execute: boolean; override;
    constructor Create(pAppInfo: IAppInfo; pSisConfig: ISisConfig;
      pUsuarioGerente: IUsuario; pLoja: ILoja; pOutput: IOutput;
      pProcessLog: IProcessLog; pTerminalList: ITerminalList);
  end;

implementation

uses Sis.Sis.Constants, System.SysUtils, Sis.Config.SisConfig.XMLI,
  Sis.Win.Utils_u,
  Sis.Config.Factory, Sis.UI.IO.Files.Sync, Vcl.Controls,
  App.UI.Config.ConfigPergForm_u;

{ TAppSisConfigGarantirXML }

function TAppSisConfigGarantirXML.ArqXmlExiste: boolean;
begin
  Result := FileExists(FNomeArqXML);
end;

function TAppSisConfigGarantirXML.ConfigEdit: boolean;
var
  r: tmodalresult;
begin
  ConfigPergForm := TConfigPergForm.Create(nil, FSisConfig, FUsuarioGerente,
    FLoja, FTerminalList);
  try
    r := ConfigPergForm.ShowModal;
    Result := IsPositiveResult(r);
  finally
    ConfigPergForm.Free;
  end;
end;

procedure TAppSisConfigGarantirXML.CopieAtu;
var
  sOrig: string;
  sDest: string;
begin
  ProcessLog.PegueLocal('TAppSisConfigGarantirXML.CopieAtu');
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

procedure TAppSisConfigGarantirXML.CopieInicial;
var
  sOrig: string;
  sDest: string;
begin
  ProcessLog.PegueLocal('TAppSisConfigGarantirXML.CopieInicial');
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

constructor TAppSisConfigGarantirXML.Create(pAppInfo: IAppInfo;
  pSisConfig: ISisConfig; pUsuarioGerente: IUsuario; pLoja: ILoja;
  pOutput: IOutput; pProcessLog: IProcessLog; pTerminalList: ITerminalList);
begin
  inherited Create(pOutput, pProcessLog);
  FAppInfo := pAppInfo;
  FSisConfig := pSisConfig;
  FLoja := pLoja;
  FUsuarioGerente := pUsuarioGerente;
  FTerminalList := pTerminalList;

  ProcessLog.PegueLocal('TAppSisConfigGarantirXML.Create');
  FNomeArqXML := FAppInfo.PastaConfigs + Sis.Sis.Constants.CONFIG_ARQ_NOME +
    CONFIG_ARQ_EXT;
  ProcessLog.RegistreLog('NomeArqXML=' + FNomeArqXML);
  ProcessLog.RetorneLocal;
end;

function TAppSisConfigGarantirXML.Execute: boolean;
var
  oSisConfigXMLI: ISisConfigXMLI;
begin
  Result := True;
  ProcessLog.PegueLocal('TAppSisConfigGarantirXML.Execute');
  try
    oSisConfigXMLI := SisConfigXMLICreate(FSisConfig);

    ProcessLog.RegistreLog('vai testar ArqXmlExiste');
    Result := ArqXmlExiste;
    if Result then
    begin
      ProcessLog.RegistreLog('existia, vai ler e terminar');
      oSisConfigXMLI.Ler;
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

    oSisConfigXMLI.Gravar;

  finally
    ProcessLog.RegistreLog('vai CopieAtu');
    CopieAtu;
    ProcessLog.RetorneLocal;
  end;
end;

procedure TAppSisConfigGarantirXML.PreenchaSisConfigVersao;
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
