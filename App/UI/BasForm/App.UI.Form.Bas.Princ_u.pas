unit App.UI.Form.Bas.Princ_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Act_u, System.Actions, App.AppInfo,
  App.AppObj, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Sis.Config.SisConfig, Sis.DB.DBTypes, Sis.Usuario,
  Sis.Loja, Sis.UI.Constants, Sis.Entities.TerminalList, App.Ger.GerForm_u,
  Sis.Entities.Factory;

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
    GerFormAbrirAction_PrincBasForm: TAction;
    GerFormCentralizarAction_PrincBasForm: TAction;
    GerenciadorDeTarefasGroupBox_PrincBasForm: TGroupBox;
    AbrirButton_PrincBasForm: TButton;
    CentrButton_PrincBasForm: TButton;
    Timer1: TTimer;

    procedure MinimizeAction_PrincBasFormExecute(Sender: TObject);
    procedure TitleBarPanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure DtHCompileLabelClick(Sender: TObject);
    procedure GerFormAbrirAction_PrincBasFormExecute
      (Sender: TObject);
    procedure GerFormCentralizarAction_PrincBasFormExecute
      (Sender: TObject);
    procedure FecharAction_ActBasFormExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FsLogo1NomeArq: string;
    FAppInfo: IAppInfo;
    FTerminalList: ITerminalList;
    FAppObj: IAppObj;
    FLoja: ILoja;

    FStatusOutput: IOutput;
    FProcessOutput: IOutput;
    FProcessLog: IProcessLog;

    FDBMSConfig: IDBMSConfig;
    FDBMS: IDBMS;

    FDBUpdaterVariaveis: string;

    FGerForm: TGerAppForm;

    procedure GarantaDB;
    function AtualizeVersaoExecutaveis: boolean;
    procedure ConfigureForm;
    procedure ConfigureSplashForm;
    function GarantirConfig(pLoja: ILoja; pUsuarioGerente: IUsuario;
      pTerminalList: ITerminalList): boolean;

    procedure CarregarMachineId;
    procedure CarregarLoja;

  protected
    procedure DBUpdaterVariaveisPegar(pChave, pValor: string);

    procedure GerFormInicializar; virtual; abstract;

    property StatusOutput: IOutput read FStatusOutput;
    property ProcessOutput: IOutput read FProcessOutput;
    property ProcessLog: IProcessLog read FProcessLog;

    property AppInfo: IAppInfo read FAppInfo;
    property AppObj: IAppObj read FAppObj;
    property Loja: ILoja read FLoja;

    procedure OculteSplashForm;
    function GetAppInfoCreate: IAppInfo; virtual; abstract;

    property DBMSConfig: IDBMSConfig read FDBMSConfig;
    property DBMS: IDBMS read FDBMS;

    procedure PreenchaAtividade; virtual; abstract;
    property DBUpdaterVariaveis: string read FDBUpdaterVariaveis
      write FDBUpdaterVariaveis;

    procedure PreenchaDBUpdaterVariaveis; virtual;

    property GerForm: TGerAppForm read FGerForm write FGerForm;

    procedure AjusteControles; override;
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
  System.DateUtils, App.AtualizaVersao, Sis.Types.Bool_u, Sis.Usuario.Factory,
  App.SisConfig.Garantir, App.DB.Garantir, Sis.Loja.Factory,
  Sis.UI.ImgsList.Prepare, App.SisConfig.Factory, App.SisConfig.DBI,
  App.DB.Utils, AppVersao_u, Sis.Sis.Constants, App.AppInfo.Types;

procedure TPrincBasForm.AjusteControles;
begin
  inherited;
  FProcessLog.PegueLocal('TPrincBasForm.ShowTimer_BasFormTimer');
  try
    inherited;
    ToolBar1.Repaint;
    OculteSplashForm;
  finally
    FProcessLog.RetorneLocal;
  end;
end;

function TPrincBasForm.AtualizeVersaoExecutaveis: boolean;
var
  oAtualizaVersao: IAtualizaVersao;
  bPrecisaResetar: boolean;
  sLog: string;
begin
{$IFDEF DEBUG}
  exit;
{$ENDIF}
  FProcessLog.PegueLocal('TPrincBasForm.AtualizeVersaoExecutaveis');

  try
    Result := AppObj.AppTestesConfig.App.ExecsAtu;
    if not Result then
    begin
      sLog := 'AppTestesConfig.App.ExecsAtu=N, abortando';
      Exit;
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
begin
  oDBConnectionParams := TerminalIdToDBConnectionParams
    (TERMINAL_ID_RETAGUARDA, FAppObj);

  DBConnection := DBConnectionCreate('CarregLojaConn', AppObj.SisConfig,
    oDBConnectionParams, ProcessLog, FProcessOutput);

  LojaLeia(FLoja, DBConnection);
end;

procedure TPrincBasForm.CarregarMachineId;
var
  oSisConfigDBI: ISisConfigDBI;
begin
  oSisConfigDBI := SisConfigDBICreate(FAppObj, DBMS, FProcessLog,
    FProcessOutput);

  oSisConfigDBI.LerMachineIdent;
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

    SplashForm.Exibir(FAppInfo.NomeExib);
    SplashForm.CarregarLogo(FsLogo1NomeArq);
  finally
    FProcessLog.RetorneLocal;
  end;
end;

constructor TPrincBasForm.Create(AOwner: TComponent);
var
  bResultado: boolean;
  sMens: string;
begin
  inherited Create(AOwner);
  // ReportMemoryLeaksOnShutdown := True;
  Randomize;
  TitleBarPanel.Color := COR_AZUL_TITLEBAR;
  ToolBar1.Color := COR_AZUL_TITLEBAR;
  // DisparaShowTimer := True;
  MakeRounded(Self, 30);
  ToolBar1.Left := Width - ToolBar1.Width;
  FProcessLog := ProcessLogFileCreate(Name);
  FStatusOutput := MudoOutputCreate;
  FProcessOutput := nil;
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
    FLoja := LojaCreate;
    FAppInfo := GetAppInfoCreate;

    FTerminalList := TerminalListCreate;
    FsLogo1NomeArq := FAppInfo.PastaImg + 'App\Logo Tela.jpg';

    ToolBar1.Images := SisImgDataModule.ImageList_40_24;

    ConfigureSplashForm;
    FProcessOutput := SplashForm;
    SplashForm.Show;
    Application.ProcessMessages;

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
      Application.Terminate;
      Exit;
    end;
    GarantaDB;

    if FLoja.Id < 1 then
    begin
      CarregarLoja;
    end;

    if FLoja.Id < 1 then
    begin
      sMens := 'Verifique carregamento da Loja. Id zerado';
      FProcessLog.RegistreLog(sMens);
      raise Exception.Create(sMens);
    end;

    ConfigureForm;

    Sis.UI.ImgsList.Prepare.PrepareImgs(AppInfo.PastaImg);

    CarregarMachineId;

    ClearStyleElements(TitleBarPanel);

    GerFormInicializar;
  finally
    FAppObj.ProcessOutput := MudoOutputCreate;
    FProcessLog.RetorneLocal;
  end;
end;

procedure TPrincBasForm.DBUpdaterVariaveisPegar(pChave, pValor: string);
begin
  FDBUpdaterVariaveis := FDBUpdaterVariaveis + pChave + '=' + pValor + #13#10;
end;

destructor TPrincBasForm.Destroy;
begin
//  FProcessLog.PegueLocal('TPrincBasForm.FormDestroy');
  try
//    ExecEvento(TSessaoMomento.ssmomFim, FAppInfo, FStatusOutput, FProcessLog);
    inherited;
  finally
//    FProcessLog.RetorneLocal;
  end;
end;

procedure TPrincBasForm.DtHCompileLabelClick(Sender: TObject);
begin
  inherited;
  ShowMessage(AppVersao_u.GetInfos);
end;

procedure TPrincBasForm.FecharAction_ActBasFormExecute(Sender: TObject);
begin
  GerFormAbrirAction_PrincBasForm.Execute;
  Application.ProcessMessages;
  GerForm.Terminate;
  GerForm.EspereTerminar;
  inherited;
end;

procedure TPrincBasForm.GarantaDB;
var
  bResultado: boolean;
  oUsuarioGerente: IUsuario;
  oSisConfig: ISisConfig;
begin
  FProcessLog.PegueLocal('TPrincBasForm.GarantaDB');
  try
    oUsuarioGerente := UsuarioCreate;

    bResultado := GarantirConfig(FLoja, oUsuarioGerente, FAppObj.TerminalList);

    if not bResultado then
    begin
      FProcessLog.RegistreLog
        ('GarantirConfig retornou false, Application.Terminate');
      Application.Terminate;
      Exit;
    end;

    oSisConfig := FAppObj.SisConfig;
    bResultado := GarantirDB(FAppObj, FProcessLog, FProcessOutput, FLoja,
      oUsuarioGerente, DBUpdaterVariaveis);

    if not bResultado then
    begin
      FProcessLog.RegistreLog
        ('GarantirDB retornou false, Application.Terminate');
      Application.Terminate;
      Exit;
    end;
    oSisConfig := FAppObj.SisConfig;
    FDBMSConfig := DBMSConfigCreate(oSisConfig, FProcessLog, FProcessOutput);
    FDBMS := DBMSCreate(oSisConfig, FDBMSConfig, FProcessLog, FProcessOutput);
    FAppObj.DBMS := FDBMS;
  finally
    FProcessLog.RetorneLocal;
  end;
end;

function TPrincBasForm.GarantirConfig(pLoja: ILoja; pUsuarioGerente: IUsuario;
  pTerminalList: ITerminalList): boolean;
var
  oAppSisConfigGarantirXML: IAppSisConfigGarantirXML;
  sLog: string;
  oSisConfig: ISisConfig;
begin
  FProcessLog.PegueLocal('TPrincBasForm.GarantirConfig');
  try
    oSisConfig := FAppObj.SisConfig;

    oAppSisConfigGarantirXML := SisConfigGarantirCreate(FAppObj, oSisConfig,
      pUsuarioGerente, pLoja, FProcessOutput, FProcessLog, pTerminalList);
    FProcessLog.RegistreLog('vai oAppSisConfigGarantirXML.Execute');
    Result := oAppSisConfigGarantirXML.Execute;

    sLog := iif(Result, 'Result=True,ok', 'Result=False,deve abortar');
    FProcessLog.RegistreLog(sLog);
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TPrincBasForm.GerFormAbrirAction_PrincBasFormExecute
  (Sender: TObject);
begin
  inherited;
  if FGerForm.Visible then
    GerFormCentralizarAction_PrincBasForm.Execute
  else
    FGerForm.Show;
end;

procedure TPrincBasForm.
  GerFormCentralizarAction_PrincBasFormExecute(Sender: TObject);
begin
  inherited;
  ControlAlignToRect(FGerForm, Screen.WorkAreaRect);
  FGerForm.BringToFront;
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

end;

procedure TPrincBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  GerForm.ExecuteTimer.Enabled := True;
  Timer1.Enabled := True;
end;

procedure TPrincBasForm.Timer1Timer(Sender: TObject);
begin
  inherited;
  Close;
//  FecharAction_ActBasForm.Execute;
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
