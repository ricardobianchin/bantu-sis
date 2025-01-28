unit App.SisConfig.Garantir_u;

interface

uses App.SisConfig.Garantir, Sis.Sis.Executavel_u, Sis.Config.SisConfig,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, App.AppObj, Sis.Usuario,
  Sis.Loja, Sis.TerminalList, Sis.Terminal.DBI;

type
  TAppSisConfigGarantirXML = class(TExecutavel, IAppSisConfigGarantirXML)
  private
    FAppObj: IAppObj;
    FSisConfig: ISisConfig;
    // FOutput: IOutput;
    // FProcessLog: IProcessLog;
    FNomeArqXML: string;

    FUsuarioAdmin: IUsuario;
    FLoja: ISisLoja;
    FTerminalList: ITerminalList;
    FTerminalDBI: ITerminalDBI;

    function ArqXmlExiste: boolean;
    procedure CopieInicial;
    procedure CopieAtu;
    function ConfigEdit: boolean;
    procedure PreenchaSisConfigVersao;
  public
    function Execute: boolean; override;
    constructor Create(pAppObj: IAppObj; pSisConfig: ISisConfig;
      pUsuarioAdmin: IUsuario; pLoja: ISisLoja; pOutput: IOutput;
      pProcessLog: IProcessLog; pTerminalList: ITerminalList;
      pTerminalDBI: ITerminalDBI);
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

  ConfigPergForm := TConfigPergForm.Create(nil, FSisConfig, FUsuarioAdmin,
    FLoja, FTerminalList, FAppObj, FTerminalDBI);
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
    sOrig := FAppObj.AppInfo.Pasta + 'Inst\inst-bin\';
    sDest := FAppObj.AppInfo.PastaBin;

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
    sOrig := FAppObj.AppInfo.Pasta + 'Inst\Inst-Delphi-redist\Redist\win64\';
    sDest := FAppObj.AppInfo.PastaBin;

    ProcessLog.RegistreLog('Sis.UI.IO.Files.Sync.AtualizarArquivos,sOrig=' +
      sOrig + ',sDest=' + sDest);

    Sis.UI.IO.Files.Sync.AtualizarArquivos(sOrig, sDest, Output);
  finally
    ProcessLog.RegistreLog('Fim');
    ProcessLog.RetorneLocal;
  end;
end;

constructor TAppSisConfigGarantirXML.Create(pAppObj: IAppObj;
  pSisConfig: ISisConfig; pUsuarioAdmin: IUsuario; pLoja: ISisLoja;
  pOutput: IOutput; pProcessLog: IProcessLog; pTerminalList: ITerminalList;
  pTerminalDBI: ITerminalDBI);
begin
  inherited Create(pOutput, pProcessLog);
  FAppObj := pAppObj;
  FSisConfig := pSisConfig;
  FLoja := pLoja;
  FUsuarioAdmin := pUsuarioAdmin;
  FTerminalList := pTerminalList;
  FTerminalDBI := pTerminalDBI;

  ProcessLog.PegueLocal('TAppSisConfigGarantirXML.Create');
  FNomeArqXML := FAppObj.AppInfo.PastaConfigs +
    Sis.Sis.Constants.CONFIG_ARQ_NOME + CONFIG_ARQ_EXT;
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
