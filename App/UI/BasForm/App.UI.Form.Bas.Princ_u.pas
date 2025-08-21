unit App.UI.Form.Bas.Princ_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Act_u, System.Actions, App.AppInfo, App.AppObj, App.Loja,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Imaging.jpeg, Sis.UI.Constants,
  Vcl.Imaging.pngimage, Sis.Config.SisConfig, Sis.DB.DBTypes, Sis.Usuario,
  Sis.TerminalList, Sis.Terminal.Factory_u, App.Loja.DBI, Sis.Terminal.DBI,
  System.DateUtils, App.DB.Bak;

type
  TPrincBasForm = class(TActBasForm)
    TitleBarPanel: TPanel;
    ToolBar1: TToolBar;
    FecharToolButton: TToolButton;
    MinimizeToolButton: TToolButton;
    MinimizeAction_PrincBasForm: TAction;
    TitleBarCaptionLabel: TLabel;
    Logo1Image: TImage;
    DtHCompileLabel: TLabel;
    AppComandosExecTimer_PrincBasForm: TTimer;
    TarefasTimer_PrincBasForm: TTimer;

    procedure MinimizeAction_PrincBasFormExecute(Sender: TObject);
    procedure TitleBarPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure DtHCompileLabelClick(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure FecharAction_ActBasFormExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AppComandosExecTimer_PrincBasFormTimer(Sender: TObject);
    procedure TarefasTimer_PrincBasFormTimer(Sender: TObject);
  private
    { Private declarations }
    MutexHandle: THandle;
    FsLogo1NomeArq: string;
    FAppInfo: IAppInfo;
    FTerminalList: ITerminalList;
    FLoja: IAppLoja;
    FAppObj: IAppObj;

    FStatusOutput: IOutput;
    FProcessOutput: IOutput;
    FProcessLog: IProcessLog;

    FDBMSConfig: IDBMSConfig;
    FDBMS: IDBMS;

    FDBUpdaterVariaveis: string;
    FPrecisaFechar: Boolean;

    FAppComandosBuscandoArquivos: Boolean;

    FAppBak: IAppBak;

    procedure Garanta_Config_e_DB;
    function AtualizeVersaoExecutaveis: Boolean;
    procedure ConfigureForm;
    procedure ConfigureSplashForm;
    function Garanta_Config_XML_e_Perg(pLoja: IAppLoja; pUsuarioAdmin: IUsuario;
      pTerminalList: ITerminalList; out pCriouTerminais: Boolean): Boolean;

    function Garanta_DB(pCriouTerminais: Boolean;
      pUsuarioAdmin: IUsuario): Boolean;

    procedure CarregarLoja;

    procedure AssistPedirPraFechar;
  protected
    function ExeParamsDecida: Boolean; virtual;
    procedure DoSegundaInstancia; virtual;

    function AppComandoGetNome(pDtH: TDateTime = 0): string; virtual;
    procedure AppComandosApagueAntigos(pIdadeMaxima: TDateTime = OneSecond *
      15); virtual;
    procedure AppComandoSalve(pComando: string); virtual;
    procedure AppComandoExecute(var pComando: string); virtual;

    procedure DBUpdaterVariaveisPegar(pChave, pValor: string);

    property StatusOutput: IOutput read FStatusOutput;
    property ProcessOutput: IOutput read FProcessOutput;
    property ProcessLog: IProcessLog read FProcessLog;

    property AppInfo: IAppInfo read FAppInfo;
    property AppObj: IAppObj read FAppObj;
    property Loja: IAppLoja read FLoja;

    procedure OculteSplashForm;
    function GetAppInfoCreate: IAppInfo; virtual; abstract;

    property DBMSConfig: IDBMSConfig read FDBMSConfig;
    property DBMS: IDBMS read FDBMS;

    procedure PreenchaAtividade; virtual; abstract;
    property DBUpdaterVariaveis: string read FDBUpdaterVariaveis
      write FDBUpdaterVariaveis;

    procedure PreenchaDBUpdaterVariaveis; virtual;

    procedure AjusteControles; override;
    procedure AssistAbrir; virtual;

    property PrecisaFechar: Boolean read FPrecisaFechar write FPrecisaFechar;

    function AppBakCreate(pAppObj: IAppObj; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog): IAppBak; virtual; abstract;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  PrincBasForm: TPrincBasForm;

implementation

{$R *.dfm}

uses App.Factory, App.UI.Form.Status_u, Sis.UI.IO.Factory, Sis.UI.ImgDM,
  Sis.UI.Controls.Utils, Sis.UI.IO.Output.ProcessLog.Factory, Sis.DB.Factory,
  App.AppObj_u_ExecEventos, Sis.UI.Form.Splash_u, Sis.UI.Controls.TImage,
  App.AtualizaVersao, Sis.Types.Bool_u, Sis.Usuario.Factory,
  App.SisConfig.Garantir, App.DB.Garantir_u, Sis.Loja.Factory, Sis.UI.IO.Files,
  Sis.UI.ImgsList.Prepare, App.SisConfig.Factory, App.SisConfig.DBI,
  App.DB.Utils, AppVersao_u, Sis.Sis.Constants, App.AppInfo.Types,
  App.Constants, App.Pess.Factory_u, Sis.Types.strings_u, Sis.Types.Utils_u,
  App.UI.Form.Perg_u, Sis.Usuario.DBI, Sis.UI.IO.Files.ApagueAntigos_u,
  App.DonoConfig.Utils;

procedure TPrincBasForm.AjusteControles;
begin
  inherited;
  FProcessLog.PegueLocal('TPrincBasForm.ShowTimer_BasFormTimer');
  try
    inherited;
    ToolBar1.Left := Width - ToolBar1.Width;
    ToolBar1.Repaint;
    OculteSplashForm;
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TPrincBasForm.AppComandoExecute(var pComando: string);
begin
  pComando := AnsiUpperCase(pComando);
  if pComando = 'HIDE' then
  begin
    pComando := '';
    Hide;
    exit;
  end;

  if pComando = 'SHOW' then
  begin
    pComando := '';
    if not Visible then
      Show;
    exit;
  end;

  if pComando = 'CLOSE' then
  begin
    pComando := '';
    Close;
    exit;
  end;
end;

function TPrincBasForm.AppComandoGetNome(pDtH: TDateTime): string;
begin
  if pDtH = 0 then
    pDtH := Now;
  Result := AppInfo.PastaAppComandos + DateTimeToNomeArq(pDtH) +
    ' AppComando.tmp';
end;

procedure TPrincBasForm.AppComandoSalve(pComando: string);
var
  sNomeArq: string;
  // Agora: TDateTime;
begin
  // Agora := Now;
  sNomeArq := AppComandoGetNome { (Agora) };
  pComando := AnsiUpperCase(pComando);
  Sis.UI.IO.Files.EscreverArquivo(pComando, sNomeArq);
  RenameFile(sNomeArq, ChangeFileExt(sNomeArq, '.txt'));
end;

procedure TPrincBasForm.AppComandosExecTimer_PrincBasFormTimer(Sender: TObject);
var
  SL: TStringList;
  I: Integer;
  sTexto: string;
  sNomeArq: string;
begin
  inherited;
  if FAppComandosBuscandoArquivos then
    exit;

  FAppComandosBuscandoArquivos := True;
  SL := TStringList.Create;
  try
    AppComandosApagueAntigos;
    LeDiretorio(FAppInfo.PastaAppComandos, SL, False);
    SL.Sorted := True;
    SL.Sorted := False;
    for I := 0 to SL.Count - 1 do
    begin
      sNomeArq := FAppInfo.PastaAppComandos + SL[I];
      if LerDoArquivo(sNomeArq, sTexto) then
      begin
        if sTexto <> '' then
          AppComandoExecute(sTexto);
      end;
      DeleteFile(sNomeArq);
    end;
  finally
    SL.Free;
    FAppComandosBuscandoArquivos := False;
  end;
end;

procedure TPrincBasForm.AppComandosApagueAntigos(pIdadeMaxima: TDateTime);
var
  Agora: TDateTime;
begin
  Agora := Now;
  Sis.UI.IO.Files.ApagueAntigos_u.DeleteOldFilesAndEmptyDirs
    (AppInfo.PastaAppComandos, Agora - pIdadeMaxima, False);
end;

procedure TPrincBasForm.AssistAbrir;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaBin + ASSIST_NOME_ARQ_TERMINAR;
  DeleteFile(sNomeArq);
end;

procedure TPrincBasForm.AssistPedirPraFechar;
var
  sMens: string;
  sNomeArq: string;
begin
  sMens := 'Arquivo criado automaticamente para fehcar o Assist.'#13#10'O conteúdo deste arquivo é irrelevante.';
  sNomeArq := AppObj.AppInfo.PastaBin + ASSIST_NOME_ARQ_TERMINAR;

  EscreverArquivo(sMens, sNomeArq);
end;

function TPrincBasForm.AtualizeVersaoExecutaveis: Boolean;
var
  oAtualizaVersao: IAtualizaVersao;
  bPrecisaResetar: Boolean;
  sLog: string;
begin
  FProcessLog.PegueLocal('TPrincBasForm.AtualizeVersaoExecutaveis');

  try
    Result := AppObj.AppTestesConfig.App.ExecsAtu;
    if not Result then
    begin
      sLog := 'AppTestesConfig.App.ExecsAtu=N, abortando';
      exit;
    end;

    oAtualizaVersao := AppAtualizaVersaoCreate(FAppInfo, FProcessOutput,
      FProcessLog);
    bPrecisaResetar := oAtualizaVersao.Execute;

    Result := bPrecisaResetar;
    sLog := iif(bPrecisaResetar, 'Result=True,Precisa reiniciar',
      'Result=False,Não precisa reiniciar');
  finally
    FProcessLog.RegistreLog(sLog);
    FProcessLog.RetorneLocal;
  end;
end;

procedure TPrincBasForm.CarregarLoja;
var
  DBConnection: IDBConnection;
  oDBConnectionParams: TDBConnectionParams;
  sMens: string;
  oLojaDBI: IAppLojaDBI;
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, FAppObj);

  DBConnection := DBConnectionCreate('CarregLojaConn', AppObj.SisConfig,
    oDBConnectionParams, ProcessLog, FProcessOutput);
  oLojaDBI := AppLojaDBICreate(FLoja, DBConnection);;
  oLojaDBI.Ler(sMens);
end;

procedure TPrincBasForm.ConfigureForm;
var
  sLog: string;
begin
  FProcessLog.PegueLocal('TPrincBasForm.ConfigureForm');
  try
    sLog := 'Carregar,nomeexib=' + FAppInfo.NomeExib + ',Logo1=' +
      FsLogo1NomeArq;
    FProcessLog.RegistreLog(sLog);

    TitleBarCaptionLabel.Caption := FAppInfo.NomeExib;
    TitleBarCaptionLabel.StyleElements := [];
    TitleBarCaptionLabel.Font.Color := clWhite;

    Color := FAppInfo.FundoCor;
    Font.Color := FAppInfo.FonteCor;

    Sis.UI.Controls.TImage.TImageCarretarJpg(Logo1Image, FsLogo1NomeArq);
    FProcessLog.RegistreLog('Fim');
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TPrincBasForm.ConfigureSplashForm;
var
  sLog: string;
begin
  FProcessLog.PegueLocal('TPrincBasForm.ConfigureSplashForm');
  try
    SplashForm := TSplashForm.Create(nil);

    SplashForm.Color := FAppInfo.FundoCor;
    SplashForm.Font.Color := FAppInfo.FonteCor;

    SplashForm.MensLabel.Color := FAppInfo.FundoCor;
    SplashForm.MensLabel.Font.Color := FAppInfo.FonteCor;

    sLog := 'Ja ajustou cores do splash, vai SplashForm.CarregarLogo';
    FProcessLog.RegistreLog(sLog);

    SplashForm.Output.Exibir(FAppInfo.NomeExib);
    SplashForm.CarregarLogo(FsLogo1NomeArq);
  finally
    FProcessLog.RetorneLocal;
  end;
end;

constructor TPrincBasForm.Create(AOwner: TComponent);
var
  bResultado: Boolean;
  sMens: string;
begin
  inherited Create(AOwner);
  // ReportMemoryLeaksOnShutdown := True;
  Randomize;
  FAppComandosBuscandoArquivos := False;
  FPrecisaFechar := False;

  TitleBarPanel.Color := COR_AZUL_TITLEBAR;
  ToolBar1.Color := COR_AZUL_TITLEBAR;
  // DisparaShowTimer := True;
  MakeRounded(Self, 30);

  if paramcount < 2 then
  begin
    FProcessLog := ProcessLogFileCreate(Name);
  end
  else
  begin
    FProcessLog := MudoProcessLogCreate;
  end;

  FStatusOutput := MudoOutputCreate;
  FProcessOutput := MudoOutputCreate;
  // FProcessOutput := SplashForm;

  FProcessLog.PegueLocal('TPrincBasForm.FormCreate');
  try
    // FSisConfig := SisConfigCreate;

    DtHCompileLabel.Caption := AppVersao_u.VERSAO_RESUMIDA;
    DtHCompileLabel.Hint := AppVersao_u.GetInfos;

    FProcessLog.RegistreLog('DtHCompileLabel.Caption = ' +
      QuotedStr(DtHCompileLabel.Caption));
    FProcessLog.RegistreLog('DtHCompileLabel.Hint = ' +
      QuotedStr(DtHCompileLabel.Hint));

    FProcessLog.RegistreLog('FAppInfo,FAppObj,Create');
    // FAppInfo := App.Factory.AppInfoCreate(Application.ExeName);
    FAppInfo := GetAppInfoCreate;
    App.DonoConfig.Utils.DonoConfigLer(FAppInfo);

    FPrecisaFechar := not ExeParamsDecida;
    if FPrecisaFechar then
      exit;

    MutexHandle := CreateMutex(nil, True,
      'DAROS-9DC5D990-AAF7-480A-9892-02AF9D0E72ED');
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
      FProcessLog.RegistreLog('GetLastError = ERROR_ALREADY_EXISTS');
      DoSegundaInstancia;
      FPrecisaFechar := True;
      exit;
    end;

    FLoja := AppLojaCreate;

    FTerminalList := TerminalListCreate;
    FsLogo1NomeArq := FAppInfo.PastaImg + 'App\Logo Tela.jpg';

    ToolBar1.Images := SisImgDataModule.ImageList_40_24;

    ConfigureSplashForm;
    if paramcount < 2 then
    begin
      FProcessOutput := SplashForm.Output;
      SplashForm.Show;
      Application.ProcessMessages;
    end;

    FAppObj := App.Factory.AppObjCreate(FAppInfo, FLoja, { FDBMS } nil,
      FStatusOutput, FProcessOutput, FProcessLog, FTerminalList);

    PreenchaAtividade;
    PreenchaDBUpdaterVariaveis;
    bResultado := FAppObj.Inicialize;

    bResultado := AtualizeVersaoExecutaveis;
    if bResultado then
    begin
      FProcessLog.RegistreLog
        ('AtualizeVersaoExecutaveis retornou true, Application.Terminate');
      // Application.Terminate;
      FPrecisaFechar := True;
      exit;
    end;

    Garanta_Config_e_DB;

    if FLoja.Id < 1 then
    begin
      sMens := 'Verifique carregamento da Loja. Id zerado';
      FProcessLog.RegistreLog(sMens);
      raise Exception.Create(sMens);
    end;

    ConfigureForm;

    Sis.UI.ImgsList.Prepare.PrepareImgs(AppInfo.PastaImg);

    ClearStyleElements(TitleBarPanel);

    FAppBak := AppBakCreate(FAppObj, FDBMS, nil, ProcessLog);

  finally
    if not PrecisaFechar then
      FAppObj.ProcessOutput := MudoOutputCreate;
    FProcessLog.RetorneLocal;
  end;
end;

procedure TPrincBasForm.DBUpdaterVariaveisPegar(pChave, pValor: string);
begin
  FDBUpdaterVariaveis := FDBUpdaterVariaveis + pChave + '=' + pValor + #13#10;
end;

destructor TPrincBasForm.Destroy;
begin // vai terminar em erro $$
  inherited;
  if MutexHandle <> 0 then
    CloseHandle(MutexHandle);
  // // FProcessLog.PegueLocal('TPrincBasForm.FormDestroy');
  // try
  // ExecEvento(TEventoDoSistema.eventosisFim, FAppInfo, FStatusOutput,
  // FProcessLog);
  // inherited;
  // finally
  // // FProcessLog.RetorneLocal;
  // end;
end;

procedure TPrincBasForm.DoSegundaInstancia;
begin
end;

procedure TPrincBasForm.DtHCompileLabelClick(Sender: TObject);
begin
  inherited;
  ShowMessage(AppVersao_u.GetInfos);
end;

function TPrincBasForm.ExeParamsDecida: Boolean;
begin
  Result := True;
end;

procedure TPrincBasForm.FecharAction_ActBasFormExecute(Sender: TObject);
var
  bResultado: Boolean;
begin
  bResultado := App.UI.Form.Perg_u.Perg
    ('Fechar o Gerenciador?'#13#10'Tarefas como a atualização automática de preços ficarão pausadas. Para não interrompê-las, escolha ''Ocultar''',
    'Administrador do Sistema Daros', TBooleanDefault.boolFalse);

  if not bResultado then
    exit;

  AssistPedirPraFechar;
  inherited;
{$IFNDEF DEBUG}
{$ENDIF}
end;

procedure TPrincBasForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then
  begin
    if Shift = [] then
    begin
      Key := 0;
      FecharAction_ActBasForm.Execute;
    end;
  end;
end;

procedure TPrincBasForm.Garanta_Config_e_DB;
var
  bResultado: Boolean;
  oUsuarioAdmin: IUsuario;
  oSisConfig: ISisConfig;
  // variavel oSisConfig usada apenas para o debug trace into ir direto a chamada do metodo

  sMens: string;
  bCriouTerminais: Boolean;
begin
  FProcessLog.PegueLocal('TPrincBasForm.Garanta_Config_e_DB');
  try
    try
      oUsuarioAdmin := UsuarioCreate;
    except
      on e: Exception do
        FProcessLog.RegistreLog('oUsuarioAdmin := UsuarioCreate erro ' +
          e.message);
    end;

    try
      bResultado := Garanta_Config_XML_e_Perg(FLoja, oUsuarioAdmin,
        FAppObj.TerminalList, bCriouTerminais);
    except
      on e: Exception do
        FProcessLog.RegistreLog('Garanta_Config_XML_e_Perg( erro ' + e.message);
    end;

    if not bResultado then
    begin
      FProcessLog.RegistreLog
        ('Garanta_Config_XML_e_Perg retornou false, Application.Terminate');
      Application.Terminate;
      exit;
    end;

    try
      bResultado := Garanta_DB(bCriouTerminais, oUsuarioAdmin);
    except
      on e: Exception do
        FProcessLog.RegistreLog('Garanta_DB( erro ' + e.message);
    end;

    if not bResultado then
    begin
      FProcessLog.RegistreLog
        ('Garanta_DB retornou false, Application.Terminate');
      Application.Terminate;
      exit;
    end;

    oSisConfig := FAppObj.SisConfig;

    try
      FDBMSConfig := DBMSConfigCreate(oSisConfig, FProcessLog, FProcessOutput);
    except
      on e: Exception do
        FProcessLog.RegistreLog('DBMSConfigCreate erro ' + e.message);
    end;

    try
      FDBMS := DBMSCreate(oSisConfig, FDBMSConfig, FProcessLog, FProcessOutput);
    except
      on e: Exception do
        FProcessLog.RegistreLog('DBMSCreate erro ' + e.message);
    end;
    FAppObj.DBMS := FDBMS;
    FProcessLog.RegistreLog('TPrincBasForm.Garanta_Config_e_DB; ok');
  finally
    FProcessLog.RetorneLocal;
  end;
end;

function TPrincBasForm.Garanta_Config_XML_e_Perg(pLoja: IAppLoja;
  pUsuarioAdmin: IUsuario; pTerminalList: ITerminalList;
  out pCriouTerminais: Boolean): Boolean;
var
  oAppSisConfigGarantirXML: IAppSisConfigGarantirXML;
  sLog: string;
  oSisConfig: ISisConfig;
begin
  FProcessLog.PegueLocal('TPrincBasForm.Garanta_Config_XML_e_Perg');
  sLog := 'sLog TPrincBasForm.Garanta_Config_XML_e_Perg';
  try
    oSisConfig := FAppObj.SisConfig;
    sLog := sLog + ',vai SisConfigGarantirCreate';
    oAppSisConfigGarantirXML := SisConfigGarantirCreate(FAppObj, oSisConfig,
      pUsuarioAdmin, pLoja, FProcessOutput, FProcessLog, pTerminalList);
    sLog := sLog + ',voltou SisConfigGarantirCreate';

    sLog := sLog + ',vai oAppSisConfigGarantirXML.Execute';
    Result := oAppSisConfigGarantirXML.Execute;
    sLog := sLog + ',oAppSisConfigGarantirXML.Execute retornou. Result=' +
      BooleanToStr(Result);

    pCriouTerminais := oAppSisConfigGarantirXML.CriouTerminais;
    sLog := sLog + ',pCriouTerminais=' + BooleanToStr(pCriouTerminais);

    sLog := ',TPrincBasForm.Garanta_Config_XML_e_Perg Result=' +
      iif(Result, 'True,ok', 'False,deve abortar');
    FProcessLog.RegistreLog(sLog);
  finally
    FProcessLog.RetorneLocal;
  end;
end;

function TPrincBasForm.Garanta_DB(pCriouTerminais: Boolean;
  pUsuarioAdmin: IUsuario): Boolean;
var
  DBConnectionServ: IDBConnection;
  oDBConnectionParamsServ: TDBConnectionParams;

  oSisConfig: ISisConfig;
  // variavel oSisConfig usada apenas para o debug trace into ir direto a chamada do metodo

  oTerminalDBI: ITerminalDBI;
  oUsuarioAdminDBI: IUsuarioDBI;
begin
  oSisConfig := FAppObj.SisConfig;
  // if pUsuarioAdmin.Id = 0 then
  // begin
  // oUsuarioAdminDBI := UsuarioDBICreate(DBConnectionServ, pUsuarioAdmin,
  // oSisConfig);
  // oUsuarioAdminDBI.LeiaAdmin;
  // end;

  Result := GarantirDB(FAppObj, FProcessLog, FProcessOutput, FLoja,
    pUsuarioAdmin, DBUpdaterVariaveis, pCriouTerminais);

  if not Result then
  begin
    FProcessLog.RegistreLog('GarantirDB retornou false, Application.Terminate');
    Application.Terminate;
    exit;
  end;
end;

procedure TPrincBasForm.MinimizeAction_PrincBasFormExecute(Sender: TObject);
begin
  inherited;
  Application.Minimize;
end;

procedure TPrincBasForm.OculteSplashForm;
begin
  FProcessOutput := MudoOutputCreate;
  if Assigned(SplashForm) then
    FreeAndNil(SplashForm);
end;

procedure TPrincBasForm.PreenchaDBUpdaterVariaveis;
var
  eAtiv: TAtividadeEconomicaSis;
  sVarNome: string;
  sVarValor: string;
  sEntrada: string;
begin
  eAtiv := AppObj.AppInfo.AtividadeEconomicaSis;

  sVarNome := 'ATIVIDADE_ECONOMICA_ID';
  sVarValor := eAtiv.ToExpandedASCII;
  DBUpdaterVariaveisPegar(sVarNome, sVarValor);

  sVarNome := 'ATIVIDADE_ECONOMICA_NAME';
  sVarValor := AtividadeEconomicaSisName[eAtiv];
  DBUpdaterVariaveisPegar(sVarNome, sVarValor);

  sVarNome := 'DATA_ZERADA';
  sVarValor := QuotedStr(DATA_ZERADA_FIREBIRD_STR);
  DBUpdaterVariaveisPegar(sVarNome, sVarValor);
end;

procedure TPrincBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  if PrecisaFechar then
    exit;
  AssistAbrir;
  AppComandosExecTimer_PrincBasForm.Enabled := True;
  FAppBak.Execute;
  TarefasTimer_PrincBasForm.Enabled := True;
end;

procedure TPrincBasForm.TarefasTimer_PrincBasFormTimer(Sender: TObject);
begin
  inherited;
  FAppBak.Execute;
end;

procedure TPrincBasForm.TitleBarPanelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
  inherited;
  if Button = mbLeft then
  begin
    ReleaseCapture;
    Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
  end;
end;

end.
