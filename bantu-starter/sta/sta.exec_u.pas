unit sta.exec_u;

interface

uses btu.sta.ui.ConfigForm, btu.lib.config, btu.lib.usu.Usuario,
  btu.lib.entit.loja, sis.ui.io.log, btu.lib.db.types,
  sis.ui.io.output, windows, btu.lib.db.dbms, btu.lib.db.factory,
  btu.lib.db.dbms.config;

type
  TStarterExec = class
  private
    FLog: ILog;
    FSisConfig: ISisConfig;
    FUsuarioGerente: IUsuario;
    // FCaminhoFirebird: string;
    FLoja: ILoja;
    FOutput: IOutput;
    FDBMSConfig: IDBMSConfig;
    FDBMS: IDBMS;
    FServConnection: IDBConnection;

    procedure CrieEEntreNaPastaBin;
    function ConfigArqExiste: boolean;
    procedure PreenchaSisConfigVersao;
    procedure ConfigCrieObjetos;
    function ConfigEdit: boolean;

    procedure GravarLoja(pDBConnection: IDBConnection);
    procedure GravarUsuGerente(pDBConnection: IDBConnection);

    procedure ExecuteApp;
  public
    property db: IDBMS read FDBMS;
    property log: ILog read FLog;
    procedure Execute;
    constructor Create(pLog: ILog; pOutput: IOutput);
  end;

implementation

uses dialogs, sysutils, System.UITypes, btu.lib.config.factory, winplatform,
  sis.files, sis.sis.constants, sis.win.VersionInfo,
  sis.win.constants, winversion, IniFiles, db, sis.win.execs,
  btu.sta.constants, btu.lib.usu.factory, btu.lib.entit.factory,
  sis.types.strings, btu.sta.exec.testes_u, btu.lib.config.xmli,
  sis.win.pastas, sis.types.strings.crypt;

{ TStarterExec }

function TStarterExec.ConfigEdit: boolean;
var
  r: tmodalresult;
begin
  StarterFormConfig := TStarterFormConfig.Create(nil, FSisConfig,
    FUsuarioGerente, FLoja);
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
  // s := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
  // CONFIG_NOME_ARQ;

  s := PastaAtual + CONFIG_NOME_ARQ;
  log.Exibir('ConfigArqExiste, vai testar se existe ' + s);

  result := FileExists(s);
  if result then
    log.Exibir('ConfigArqExiste, existia')
  else
    log.Exibir('ConfigArqExiste, não existia');
end;

procedure TStarterExec.PreenchaSisConfigVersao;
var
  iMajor: integer;
  iMinor: integer;
  sCSDVersion: string;
begin
  if not GetWinVersion(iMajor, iMinor, sCSDVersion) then
    raise Exception.Create(btu.sta.constants.MSG_ERRO_WINVERSION);

  if winplatform.IsWow64Process then
    FSisConfig.WinVersionInfo.winplatform := wplatWin64
  else
    FSisConfig.WinVersionInfo.winplatform := wplatWin32;

  FSisConfig.WinVersionInfo.PegarVersion(iMajor, iMinor);
  FSisConfig.WinVersionInfo.CSDVersion := sCSDVersion;
end;

procedure TStarterExec.Execute;
var
  bExistiaXML: boolean;
  oConfigXMLI: IConfigXMLI;
begin
  TestesChamar;
  CrieEEntreNaPastaBin;

  if FileExists('C:\Pr\app\bantu\bantu-sis\bantu-starter\bats\apag ini.bat')
  then
    winexec('C:\Pr\app\bantu\bantu-sis\bantu-starter\bats\apag ini.bat',
      SW_SHOWNORMAL);

  ConfigCrieObjetos;
  oConfigXMLI := ConfigXMLICreate(FSisConfig);

  PreenchaSisConfigVersao;
  bExistiaXML := ConfigArqExiste;
  if not bExistiaXML then
  begin
    if not ConfigEdit then
    begin
      exit;
    end;
//    FOutput.Enabled := true;
    oConfigXMLI.Gravar;
  end
  else
  begin
//    FOutput.Enabled := true;
    oConfigXMLI.Ler;
  end;

//  FSisConfig.DBMSInfo.DatabaseType := dbmstFirebird;
//  FSisConfig.DBMSInfo.Version := 4.0;

  FDBMSConfig := DBMSConfigCreate(FSisConfig, FLog, FOutput);
  FDBMS := DBMSFirebirdCreate(FSisConfig, FDBMSConfig, FLog, FOutput);

  FDBMS.GarantirDBMSInstalado(FLog, FOutput);

  FDBMS.GarantirDBServCriadoEAtualizado(FLog, FOutput);
  if FSisConfig.LocalMachineIsServer and (not ConfigArqExiste) then
  begin
    FServConnection := DBConnectionCreate(FSisConfig, FDBMS, ldbServidor,
      FLog, FOutput);
    if FServConnection.Abrir then
    begin
      FServConnection.StartTransaction;
      try
        try
          GravarLoja(FServConnection);
          GravarUsuGerente(FServConnection);
        except
          on e: Exception do
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
var
  sLog, sExec, sParam, sPasta, sErro: string;
begin
  sLog := 'TStarterExec.ExecuteApp';
  try
    sPasta := FSisConfig.PastaProduto + 'bin\';
    sParam := '';
    sExec := sPasta + 'retag.exe';
    sLog := sLog + ';' + sPasta + ';' + sExec + ';' + sParam;

    if not FileExists(sExec) then
    begin
      sErro := 'Não encontrado ' + sExec;
      sLog := sLog + ';' + sErro;
      exit;
    end;
    if not ExecutePrograma(sExec, sParam, sPasta, sErro) then
      sLog := sLog + ';' + sErro;
  finally
    FLog.Exibir(sLog);
  end;
end;

procedure TStarterExec.GravarUsuGerente(pDBConnection: IDBConnection);
var
  s: string;
  sSenha: string;
//  iPessoaId: integer;
begin
  Encriptar('123', sSenha);

  s := 'SELECT PESSOA_ID_RETORNADA FROM PESSOA_PA.USUARIO_GARANTIR(' +
    FLoja.Id.ToString + ',' + 'SUPORTE TECNICO'.QuotedString + ',' +
    'TEC'.QuotedString + ',' + sSenha.QuotedString + ',' +
    'TECNICO'.QuotedString + ',' + '1);';

  {iPessoaId := }pDBConnection.GetValue(s);

  Encriptar(FUsuarioGerente.Senha, sSenha);

  s := 'SELECT PESSOA_ID_RETORNADA FROM PESSOA_PA.USUARIO_GARANTIR(' +
    FLoja.Id.ToString + ',' + FUsuarioGerente.NomeCompleto.QuotedString + ',' +
    FUsuarioGerente.NomeUsu.QuotedString + ',' + sSenha.QuotedString + ',' +
    FUsuarioGerente.NomeExib.QuotedString + ',' + '2);';

  {iPessoaId := }pDBConnection.GetValue(s);
end;

procedure TStarterExec.GravarLoja(pDBConnection: IDBConnection);
var
  s: string;
begin
  s := 'EXECUTE PROCEDURE LOJA_PA.LOJA_GARANTIR(' + FLoja.Id.ToString + ',' +
    FLoja.Descr.QuotedString + ', TRUE);';
  pDBConnection.ExecuteSQL(s);
end;

procedure TStarterExec.ConfigCrieObjetos;
begin
  FSisConfig := SisConfigCreate;
  FUsuarioGerente := UsuarioCreate;
  FLoja := btu.lib.entit.factory.LojaCreate;
  log.Exibir('ConfigCrieObjetos');

end;

constructor TStarterExec.Create(pLog: ILog; pOutput: IOutput);
var
  s: string;
begin
  FLog := pLog;
  s := 'TStarterExec iniciado.';
  log.Exibir(s);

  FOutput := pOutput;
end;

procedure TStarterExec.CrieEEntreNaPastaBin;
var
  Resultado: boolean;
const
  PASTA_BIN = '..\bin';
begin
  log.Exibir('Vai criar e entrar na pasta PASTA_BIN=' + PASTA_BIN);
  Resultado := PastaCriarEntrar(PASTA_BIN);

  if not Resultado then
  begin
    log.Exibir('Erro pasta do sistema não localizada');
    raise Exception.Create('Erro pasta do sistema não localizada');
  end;
end;

end.
