unit sta.exec_u;

interface

uses btu.sta.ui.ConfigForm, btu.lib.config, btu.lib.usu.Usuario,
  btu.lib.entit.loja, sis.ui.io.log, btu.lib.db.types,
  sis.ui.io.output, windows, btu.lib.db.dbms, btu.lib.db.factory,
  btu.lib.db.dbms.config, Forms;

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
    procedure CopieInicial;
    procedure CopieAtu;

  public
    property DB: IDBMS read FDBMS;
    property Log: ILog read FLog;
    property Output: IOutput read FOutput;
    procedure Execute;
    constructor Create(pLog: ILog; pOutput: IOutput);
  end;

implementation

uses dialogs, sysutils, System.UITypes, btu.lib.config.factory, winplatform,
  sis.files, sis.sis.constants, sis.win.VersionInfo, Sta.Inst.Update_u,
  sis.win.constants, winversion, IniFiles, db, sis.win.execs,
  Sta.Constants, btu.lib.usu.factory, btu.lib.entit.factory,
  sis.types.strings, Sta.Exec.testes_u, btu.lib.config.xmli,
  sis.win.pastas, sis.types.strings.crypt, Sis.Files.Sync;

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

procedure TStarterExec.CopieAtu;
var
  sOrig: string;
  sDest: string;
begin
  FLog.Exibir('Sincronizar atualização');
  sOrig := FSisConfig.PastaProduto + 'Starter\inst\inst-bin\';
  sDest := FSisConfig.PastaProduto + 'bin\';

  Sis.Files.Sync.AtualizarArquivos(sOrig, sDest, FOutput);
  FLog.Exibir('Sincronizar atualização fim');
end;

procedure TStarterExec.CopieInicial;
var
  sOrig: string;
  sDest: string;
begin
  FLog.Exibir('Sincronizar inicial');
  sOrig := FSisConfig.PastaProduto + 'Starter\inst\inst-Delphi-redist\Redist\win64\';
  sDest := FSisConfig.PastaProduto + 'bin\';
  Sis.Files.Sync.AtualizarArquivos(sOrig, sDest, FOutput);
  FLog.Exibir('Sincronizar inicial fim');
end;

function TStarterExec.ConfigArqExiste: boolean;
var
  s: string;
begin
  // s := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
  // CONFIG_NOME_ARQ;

  s := PastaAtual + CONFIG_NOME_ARQ;
  log.Exibir('ConfigArqExiste, vai testar se arq config existe ' + s);

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
    raise Exception.Create(Sta.Constants.MSG_ERRO_WINVERSION);

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
  FOutput.Exibir('TStarterExec.Execute inicio');
  Log.Exibir('TStarterExec.Execute inicio, TestesChamar');
  TestesChamar;

  Log.Exibir('TStarterExec.Execute CrieEEntreNaPastaBin');
  CrieEEntreNaPastaBin;
{
  if FileExists('C:\Pr\app\bantu\bantu-sis\src\bantu-starter\bats\apag ini.bat')
  then
  begin
    winexec('C:\Pr\app\bantu\bantu-sis\src\bantu-starter\bats\apag ini.bat',
      SW_SHOWNORMAL);
  end;
}
  Log.Exibir('TStarterExec.Execute ConfigCrieObjetos');
  ConfigCrieObjetos;


  Log.Exibir('TStarterExec.Execute InstUpdate');
  FOutput.Exibir('Busca por atualizações...');
  if Sta.Inst.Update_u.InstUpdate(FSisConfig, Log, Output) then
  begin
    FOutput.Exibir('Atualizando o sistema...');
    Log.Exibir('TStarterExec.Execute InstUpdate exit');
    Exit;
  end;
  Log.Exibir('TStarterExec.Execute InstUpdate nao exit');



  Log.Exibir('TStarterExec.Execute ConfigXMLICreate');
  oConfigXMLI := ConfigXMLICreate(FSisConfig);

  Log.Exibir('TStarterExec.Execute PreenchaSisConfigVersao');
  PreenchaSisConfigVersao;
  Log.Exibir('TStarterExec.Execute ConfigArqExiste');
  bExistiaXML := ConfigArqExiste;
  if not bExistiaXML then
  begin
    Log.Exibir('TStarterExec.Execute nao existia xml, CopieInicial');
    CopieInicial;
    Log.Exibir('TStarterExec.Execute vai ConfigEdit');
    if not ConfigEdit then
    begin
      Log.Exibir('TStarterExec.Execute ConfigEdit cancel');
      exit;
    end;
//    FOutput.Enabled := true;
    Log.Exibir('TStarterExec.Execute ConfigEdit ok, oConfigXMLI.Gravar');
    oConfigXMLI.Gravar;
  end
  else
  begin
    Log.Exibir('TStarterExec.Execute existia xml, oConfigXMLI.Ler');
//    FOutput.Enabled := true;
    oConfigXMLI.Ler;
  end;

  FOutput.Exibir('Atualiza arquivos...');
  CopieAtu;

//  FSisConfig.DBMSInfo.DatabaseType := dbmstFirebird;
//  FSisConfig.DBMSInfo.Version := 4.0;

  FOutput.Exibir('Verificando banco de dados...');
  FDBMSConfig := DBMSConfigCreate(FSisConfig, FLog, FOutput);
  FDBMS := DBMSFirebirdCreate(FSisConfig, FDBMSConfig, FLog, FOutput);

  Log.Exibir('TStarterExec.Execute FDBMS.GarantirDBMSInstalado');
  FDBMS.GarantirDBMSInstalado(FLog, FOutput);
  Log.Exibir('TStarterExec.Execute FDBMS.GarantirDBMSInstalado, retornou');

  Log.Exibir('TStarterExec.Execute FDBMS.GarantirDBServCriadoEAtualizado');
  if not FDBMS.GarantirDBServCriadoEAtualizado(FLog, FOutput) then
  begin
    Log.Exibir('TStarterExec.Execute FDBMS.GarantirDBServCriadoEAtualizado, retornou erro, vai abortar');
    ShowMessage('Ocorreu um erro na instalação. Consulte o log de instalação para determinar o motivo');
    exit;
  end;
  Log.Exibir('TStarterExec.Execute FDBMS.GarantirDBServCriadoEAtualizado, retornou');

  Log.Exibir('TStarterExec.Execute FDBMS.GarantirDBServCriadoEAtualizado'
   +' acabou, vai testar se precisa criar loja');
  if FSisConfig.LocalMachineIsServer and (not ConfigArqExiste) then
  begin
    FOutput.Exibir('Granvando dados iniciais...');
    Log.Exibir('TStarterExec.Execute vai gravar loja e gerente');
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

  Log.Exibir('TStarterExec.Execute ExecuteApp');
  ExecuteApp;
  Log.Exibir('TStarterExec.Execute ExecuteApp fim');
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
  s := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  SetCurrentDir(s);
  FLog := pLog;
  FOutput := pOutput;

  s := 'TStarter instanciado';
  log.Exibir(s);
  FOutput.Exibir(S);
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
    log.Exibir('TStarterExec.CrieEEntreNaPastaBin Erro pasta do sistema não localizada');
    raise Exception.Create('TStarterExec.CrieEEntreNaPastaBin Erro pasta do sistema não localizada');
  end;
end;

end.
