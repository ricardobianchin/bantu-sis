unit sta.exec_u;

interface

uses btu.sta.ui.ConfigForm, btu.lib.config, btu.lib.usu.Usuario,
  btu.lib.entit.loja, sis.ui.io.ProcessLog, btu.lib.db.types,
  sis.ui.io.output, windows, btu.lib.db.dbms, btu.lib.db.factory,
  btu.lib.db.dbms.config, Forms;

type
  TStarterExec = class
  private
    FProcessLog: IProcessLog;
    FSisConfig: ISisConfig;
    FUsuarioGerente: IUsuario;
    // FCaminhoFirebird: string;
    FLoja: ILoja;
    FOutput: IOutput;
    FOutputStatus: IOutput;
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
    property db: IDBMS read FDBMS;
    property ProcessLog: IProcessLog read FProcessLog;
    property output: IOutput read FOutput;
    property OutputStatus: IOutput read FOutputStatus;
    procedure Execute;
    constructor Create(pProcessLog: IProcessLog;
      pOutput, pOutputStatus: IOutput);
  end;

implementation

uses dialogs, sysutils, System.UITypes, btu.lib.config.factory, winplatform,
  sis.files, sis.sis.constants, sis.win.VersionInfo, sta.Inst.Update_u,
  sis.win.constants, winversion, IniFiles, db, sis.win.execs,
  sta.constants, btu.lib.usu.factory, btu.lib.entit.factory,
  sis.types.strings, sta.Exec.testes_u, btu.lib.config.xmli,
  sis.win.pastas, sis.types.strings.crypt, sis.files.Sync;

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
  FProcessLog.Exibir('Sincronizar atualização');
  sOrig := FSisConfig.PastaProduto + 'Starter\inst\inst-bin\';
  sDest := FSisConfig.PastaProduto + 'bin\';

  sis.files.Sync.AtualizarArquivos(sOrig, sDest, FOutput);
  FProcessLog.Exibir('Sincronizar atualização fim');
end;

procedure TStarterExec.CopieInicial;
var
  sOrig: string;
  sDest: string;
begin
  FProcessLog.Exibir('Sincronizar inicial');
  sOrig := FSisConfig.PastaProduto +
    'Starter\inst\inst-Delphi-redist\Redist\win64\';
  sDest := FSisConfig.PastaProduto + 'bin\';
  sis.files.Sync.AtualizarArquivos(sOrig, sDest, FOutput);
  FProcessLog.Exibir('Sincronizar inicial fim');
end;

function TStarterExec.ConfigArqExiste: boolean;
var
  s: string;
begin
  s := PastaAtual + CONFIG_NOME_ARQ;
  ProcessLog.Exibir('ConfigArqExiste, vai testar se arq config existe ' + s);

  result := FileExists(s);
  if result then
  begin
    ProcessLog.Exibir('ConfigArqExiste, existia');
    exit
  end;

  ProcessLog.Exibir('ConfigArqExiste, não existia');
end;

procedure TStarterExec.PreenchaSisConfigVersao;
var
  iMajor: integer;
  iMinor: integer;
  sCSDVersion: string;
begin
  if not GetWinVersion(iMajor, iMinor, sCSDVersion) then
    raise Exception.Create(sta.constants.MSG_ERRO_WINVERSION);

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
  FOutputStatus.Exibir('Iniciando...');
  FOutput.Exibir('TStarterExec.Execute inicio');
  ProcessLog.Exibir('TStarterExec.Execute inicio, TestesChamar');
  TestesChamar;

  ProcessLog.Exibir('TStarterExec.Execute CrieEEntreNaPastaBin');
  CrieEEntreNaPastaBin;

  if FileExists('C:\Pr\app\bantu\bantu-sis\src\bantu-starter\bats\apag ini.bat')
  then
  begin
    winexec('C:\Pr\app\bantu\bantu-sis\src\bantu-starter\bats\apag ini.bat',
      SW_SHOWNORMAL);
  end;

  ProcessLog.Exibir('TStarterExec.Execute ConfigCrieObjetos');
  ConfigCrieObjetos;

  ProcessLog.Exibir('TStarterExec.Execute InstUpdate');
  FOutputStatus.Exibir('Busca por atualizações...');
  FOutput.Exibir('Busca por atualizações...');
  if sta.Inst.Update_u.InstUpdate(FSisConfig, ProcessLog, OutputStatus) then
  begin
    FOutput.Exibir('Atualizando o sistema...');
    ProcessLog.Exibir('TStarterExec.Execute InstUpdate exit');
    exit;
  end;
  ProcessLog.Exibir('TStarterExec.Execute InstUpdate nao exit');

  FOutputStatus.Exibir('Busca por configurações...');
  ProcessLog.Exibir('TStarterExec.Execute ConfigXMLICreate');
  oConfigXMLI := ConfigXMLICreate(FSisConfig);

  ProcessLog.Exibir('TStarterExec.Execute PreenchaSisConfigVersao');
  PreenchaSisConfigVersao;
  ProcessLog.Exibir('TStarterExec.Execute ConfigArqExiste');
  bExistiaXML := ConfigArqExiste;
  if not bExistiaXML then
  begin
    ProcessLog.Exibir('TStarterExec.Execute nao existia xml, CopieInicial');
    CopieInicial;
    ProcessLog.Exibir('TStarterExec.Execute vai ConfigEdit');
    if not ConfigEdit then
    begin
      ProcessLog.Exibir('TStarterExec.Execute ConfigEdit cancel');
      exit;
    end;
    // FOutput.Enabled := true;
    ProcessLog.Exibir('TStarterExec.Execute ConfigEdit ok, oConfigXMLI.Gravar');
    oConfigXMLI.Gravar;
  end
  else
  begin
    ProcessLog.Exibir('TStarterExec.Execute existia xml, oConfigXMLI.Ler');
    // FOutput.Enabled := true;
    oConfigXMLI.Ler;
  end;

  FOutput.Exibir('Atualiza arquivos...');
  CopieAtu;

  // FSisConfig.DBMSInfo.DatabaseType := dbmstFirebird;
  // FSisConfig.DBMSInfo.Version := 4.0;

  FOutputStatus.Exibir('Verificando banco de dados...');
  FOutput.Exibir('Verificando banco de dados...');
  FDBMSConfig := DBMSConfigCreate(FSisConfig, FProcessLog, FOutput);
  FDBMS := DBMSFirebirdCreate(FSisConfig, FDBMSConfig, FProcessLog, FOutput);

  // ProcessLog.Exibir('TStarterExec.Execute FDBMS.GarantirDBMSInstalado');
  // FDBMS.GarantirDBMSInstalado(FProcessLog, FOutputStatus);
  // ProcessLog.Exibir('TStarterExec.Execute FDBMS.GarantirDBMSInstalado, retornou');

  FOutputStatus.Exibir('Verificando versão do banco de dados...');
  ProcessLog.Exibir
    ('TStarterExec.Execute FDBMS.GarantirDBServCriadoEAtualizado');
  if not FDBMS.GarantirDBServCriadoEAtualizado(FProcessLog, FOutput) then
  begin
    ProcessLog.Exibir
      ('TStarterExec.Execute FDBMS.GarantirDBServCriadoEAtualizado, retornou erro, vai abortar');
    ShowMessage
      ('Ocorreu um erro na instalação. Consulte o ProcessLog de instalação para determinar o motivo');
    exit;
  end;
  ProcessLog.Exibir
    ('TStarterExec.Execute FDBMS.GarantirDBServCriadoEAtualizado, voltou.');

  ProcessLog.Exibir('TStarterExec.Execute FDBMS.GarantirDBServCriadoEAtualizado'
    + ' acabou, vai testar se precisa criar loja');
  if FSisConfig.LocalMachineIsServer { and (not ConfigArqExiste) } then
  begin
    FOutputStatus.Exibir('Granvando dados iniciais...');
    FOutput.Exibir('Granvando dados iniciais...');
    ProcessLog.Exibir('TStarterExec.Execute vai gravar loja e gerente');
    FServConnection := DBConnectionCreate(FSisConfig, FDBMS, ldbServidor,
      FProcessLog, FOutput);
    if FServConnection.Abrir then
    begin
      FServConnection.StartTransaction;
      try
        try
          GravarLoja(FServConnection);
          GravarUsuGerente(FServConnection);
        except
          on e: Exception do
            FProcessLog.Exibir(e.Message);
        end;
      finally
        FServConnection.Commit;
        FServConnection.Fechar;
      end;
    end;
  end;

  ProcessLog.Exibir('TStarterExec.Execute ExecuteApp');
  ExecuteApp;
  ProcessLog.Exibir('TStarterExec.Execute ExecuteApp fim');
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
    FProcessLog.Exibir(sLog);
  end;
end;

procedure TStarterExec.GravarUsuGerente(pDBConnection: IDBConnection);
var
  s: string;
  sSenha: string;
  // iPessoaId: integer;
begin
  Encriptar('123', sSenha);

  s := 'SELECT PESSOA_ID_RETORNADA FROM USUARIO_PA.USUARIO_GARANTIR(' +
    FLoja.Id.ToString + ',' + 'SUPORTE TECNICO'.QuotedString + ',' +
    'SUP'.QuotedString + ',' + sSenha.QuotedString + ',' +
    'SUPORTE'.QuotedString + ',' + '1);';

  { iPessoaId := } pDBConnection.GetValue(s);

  S := 'EXECUTE PROCEDURE USUARIO_PA.USUARIO_TEM_PERFIL_USO_GARANTIR(' +
    FLoja.Id.ToString + ',0,1,1);';

  pDBConnection.ExecuteSQL(s);

  Encriptar(FUsuarioGerente.Senha, sSenha);

  s := 'SELECT PESSOA_ID_RETORNADA FROM USUARIO_PA.USUARIO_GARANTIR(' +
    FLoja.Id.ToString + ',' + FUsuarioGerente.NomeCompleto.QuotedString + ',' +
    FUsuarioGerente.NomeUsu.QuotedString + ',' + sSenha.QuotedString + ',' +
    FUsuarioGerente.NomeExib.QuotedString + ',' + '2);';

  { iPessoaId := } pDBConnection.GetValue(s);

  S := 'EXECUTE PROCEDURE USUARIO_PA.USUARIO_TEM_PERFIL_USO_GARANTIR(' +
    FLoja.Id.ToString + ',0,2,2);';

  pDBConnection.ExecuteSQL(s);


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
  ProcessLog.Exibir('ConfigCrieObjetos');

end;

constructor TStarterExec.Create(pProcessLog: IProcessLog;
  pOutput, pOutputStatus: IOutput);
var
  sArqExe: string;
  sPasta: string;
begin
  FProcessLog := pProcessLog;
  FOutput := pOutput;
  FOutputStatus := pOutputStatus;

  sArqExe := ParamStr(0);
  sPasta := GarantaPastaDoArq(sArqExe);

  ProcessLog.Exibir('TStarter.Create,Move para pasta=' + sPasta);
end;

procedure TStarterExec.CrieEEntreNaPastaBin;
var
  Resultado: boolean;
  sPasta: string;
  s: string;

const
  PASTA_BIN = '..\bin';
begin
  s := 'Vai criar e entrar na pasta PASTA_BIN=' + PASTA_BIN;
  ProcessLog.Exibir(s);
  Resultado := PastaCriarEntrar(PASTA_BIN);

  if not Resultado then
  begin
    s := 'TStarterExec.CrieEEntreNaPastaBin' +
      ',Erro pasta do sistema não localizada';
    ProcessLog.Exibir(s);
    raise Exception.Create(s);
  end
  else
  begin
    sPasta := GetCurrentDir;
    s := 'foi para pasta ' + sPasta;
    ProcessLog.Exibir(s);
  end;
end;

end.
