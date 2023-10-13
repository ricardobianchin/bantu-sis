unit btu.sta.exec_u;

interface

uses btu.sta.ui.ConfigForm, btu.lib.config, btu.lib.usu.UsuLogin, btu.lib.entit.loja, btu.sis.ui.io.log,
  btu.sis.ui.io.output
  , windows, btu.lib.db.dbms, btu.lib.db.factory, btu.lib.db.dbms.config,
  btu.lib.db.types
  ;

type
  TStarterExec = class
  private
    FLog: ILog;
    FSisConfig: ISisConfig;
    FUsuLogin: IUsuLogin;
//    FCaminhoFirebird: string;
    FLoja: ILoja;
    FOutput: IOutput;
    FDBMSConfig: IDBMSConfig;
    FDBMS: IDBMS;
    FServConnection: IDBConnection;

    procedure CrieEEntreNaPastaBin;
    function ConfigArqExiste: boolean;
    procedure PreenchaSisConfigVersao;
    procedure ConfigCrieObjetos;
    function ConfigEdit: Boolean;

    procedure GravarLoja(pDBConnection: IDBConnection);
    procedure GravarFuncTec(pDBConnection: IDBConnection);

    procedure ExecuteApp;
  public
    property DB: IDBMS read FDBMS;
    property Log: ILog read FLog;
    procedure Execute;
    constructor Create(pLog: ILog; pOutput: IOutput);
  end;

implementation

uses dialogs, sysutils, System.UITypes, btu.lib.config.factory, winplatform
  , btu.lib.files, btu.lib.sis.constants, btu.lib.win.VersionInfo
  , btu.lib.win.constants, winversion, IniFiles
  , btu.sta.constants, btu.lib.usu.factory, btu.lib.entit.factory
  , btn.lib.types.strings, btu.sta.exec_xml_u, btu.sta.exec.testes_u,
  btu.lib.win.pastas;

{ TStarterExec }

function TStarterExec.ConfigEdit: Boolean;
var
  r: tmodalresult;
begin
  StarterFormConfig := TStarterFormConfig.Create(nil, FSisConfig, FUsuLogin, FLoja);
  try
    r := StarterFormConfig.ShowModal;
    result := IsPositiveResult(r);
    if r = mrCancel then
      exit;

  finally
    StarterFormConfig.Free;
  end;
end;

function TStarterExec.ConfigArqExiste: boolean;
var
  s: string;
begin
//  s := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
//    CONFIG_NOME_ARQ;

  s := PastaAtual + CONFIG_NOME_ARQ;
  log.Exibir('ConfigArqExiste, vai testar se existe ' + s);

  result := FileExists(s);
  if result then
    Log.Exibir('ConfigArqExiste, existia')
  else
    Log.Exibir('ConfigArqExiste, não existia');
end;

procedure TStarterExec.PreenchaSisConfigVersao;
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
  TestesChamar;
  CrieEEntreNaPastaBin;


  if FileExists('C:\Pr\app\bantu\bantu-sis\bantu-starter\bats\apag ini.bat') then
    winexec('C:\Pr\app\bantu\bantu-sis\bantu-starter\bats\apag ini.bat', SW_SHOWNORMAL);

  ConfigCrieObjetos;

  if not ConfigArqExiste then
  begin
    PreenchaSisConfigVersao;
    if not ConfigEdit then
    begin
      exit;
    end;
    FOutput.Enabled := true;
    ConfigXmlCreate(FSisConfig);
  end
  else
    ConfigXmlCarregue(FSisConfig);

  FDBMSConfig := DBMSConfigCreate(FSisConfig, FLog, FOutput);
  FDBMS := DBMSFirebirdCreate(FSisConfig, FDBMSConfig, FLog, FOutput);

  FDBMS.GarantirDBMSInstalado(FLog, FOutput);

  if FSisConfig.LocalMachineIsServer then
  begin
    FDBMS.GarantirDBServCriadoEAtualizado(FLog, FOutput);
    FServConnection := DBConnectionCreate(FSisConfig, FDBMS, ldbServidor, FLog, FOutput);
    if FServConnection.Abrir then
    begin
      FServConnection.StartTransaction;
      try
        try
          GravarLoja(FServConnection);
          GravarFuncTec(FServConnection);
        except on e: exception do
          FLog.Exibir(e.Message);
        end;
      finally
        FServConnection.Commit;
        FServConnection.Fechar;
      end;
    end;
  end;
  ExecuteApp;
end;

procedure TStarterExec.ExecuteApp;
begin

end;

procedure TStarterExec.GravarFuncTec(pDBConnection: IDBConnection);
begin

end;

procedure TStarterExec.GravarLoja(pDBConnection: IDBConnection);
var
  s: string;
begin
  S := 'EXECUTE PROCEDURE LOJA_PA.LOJA_GARANTIR('
    + FLoja.Id.ToString
    + ','
    + FLoja.Descr.QuotedString
    +', TRUE);'
    ;
  pDBConnection.ExecuteSQL(s);
end;

procedure TStarterExec.ConfigCrieObjetos;
begin
  FSisConfig := SisConfigCreate;
  FUsuLogin := UsuLoginCreate;
  FLoja := btu.lib.entit.factory.LojaCreate;
  Log.Exibir('ConfigCrieObjetos');

end;

constructor TStarterExec.Create(pLog: ILog; pOutput: IOutput);
var
  s: string;
begin
  FLog := pLog;
  s := 'TStarterExec iniciado.';
  Log.Exibir(s);

  FOutput := pOutput;
end;

procedure TStarterExec.CrieEEntreNaPastaBin;
var
  Resultado: boolean;
const
  PASTA_BIN = '..\bin';
begin
  Log.Exibir('Vai criar e entrar na pasta PASTA_BIN='+PASTA_BIN);
  Resultado := PastaCriarEntrar(PASTA_BIN);

  if not resultado then
  begin
    Log.Exibir('Erro pasta do sistema não localizada');
    raise Exception.Create('Erro pasta do sistema não localizada');
  end;
end;

end.
