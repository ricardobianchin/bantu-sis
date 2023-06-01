unit btu.sta.exec_u;

interface

uses btu.sta.Form.Config, btu.lib.config;

type
  TStarterExec = class
  private
    FSisConfig: ISisConfig;

    procedure CrieEEntreNaPastaBin;
    function ConfigArqExiste: boolean;
    procedure DescubraVersao;
    procedure InicializeSisConfig;
    procedure ConfigEdit;
    procedure ExecuteApp;
  public
    procedure Execute;
  end;

implementation

uses dialogs, sysutils, System.UITypes, btu.lib.config.factory, winplatform
  , btu.lib.files, btu.lib.sis.constants, btu.lib.win.VersionInfo
  , btu.lib.win.constants, winversion
  , btu.sta.constants;

{ TStarterExec }

procedure TStarterExec.ConfigEdit;
var
  r: tmodalresult;
begin
  StarterFormConfig := TStarterFormConfig.Create(nil, FSisConfig);
  try
    r := StarterFormConfig.ShowModal;
  finally
    StarterFormConfig.Free;
  end;
end;

function TStarterExec.ConfigArqExiste: boolean;
begin
  result := FileExists(CONFIG_NOME_ARQ);
end;

procedure TStarterExec.DescubraVersao;
var
  iMajor: integer;
  iMinor: integer;
  sCSDVersion: string;
begin
  if not GetWinVersion(iMajor, iMinor, sCSDVersion) then
    raise Exception.Create( btu.sta.constants.MSG_ERRO_WINVERSION);

  if winplatform.IsWow64Process then
    FSisConfig.WinVersionInfo.WinPlatform := wplatWin64
  else
    FSisConfig.WinVersionInfo.WinPlatform := wplatWin32;

  FSisConfig.WinVersionInfo.PegarVersion(iMajor, iMinor);
  FSisConfig.WinVersionInfo.CSDVersion := sCSDVersion;
end;

procedure TStarterExec.Execute;
begin
  CrieEEntreNaPastaBin;

  InicializeSisConfig;

  if not ConfigArqExiste then
  begin
    DescubraVersao;
    ConfigEdit;
  end
  else
  begin
    ExecuteApp;
  end;
end;

procedure TStarterExec.ExecuteApp;
begin

end;

procedure TStarterExec.InicializeSisConfig;
begin
  FSisConfig := SisConfigCreate;
end;

procedure TStarterExec.CrieEEntreNaPastaBin;
var
  Resultado: boolean;
const
  PASTA_BIN = '..\bin';
begin
  Resultado := PastaGarantirEntrar(PASTA_BIN);

  if not resultado then
    raise Exception.Create('Erro pasta do sistema não localizada');
end;

end.
