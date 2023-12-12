unit App.UI.Form.Bas.Princ_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Act_u, System.Actions,
  App.AppInfo, App.AppObj, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Sis.Config.SisConfig, Sis.DB.DBTypes,
  Sis.Usuario, Sis.Loja;

type
  TPrincBasForm = class(TActBasForm)
    TitleBarPanel: TPanel;
    ToolBar1: TToolBar;
    FecharToolButton: TToolButton;
    MinimizeToolButton: TToolButton;
    MinimizeAction_PrincBasForm: TAction;
    TitleBarCaptionLabel: TLabel;
    Logo1Image: TImage;
    AndamentoTitLabel: TLabel;
    StatusLabel: TLabel;
    StatusMemo: TMemo;
    DtHCompileLabel: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure MinimizeAction_PrincBasFormExecute(Sender: TObject);
  private
    { Private declarations }
    FsLogo1NomeArq: string;
    FAppInfo: IAppInfo;
    FAppObj: IAppObj;

    FStatusOutput: IOutput;
    FProcessOutput: IOutput;
    FProcessLog: IProcessLog;

    // FSisConfig: ISisConfig;

    // FUsuarioGerente: IUsuario;
    // FLoja: ILoja;
    // FDBMSConfig: IDBMSConfig;
    // FDBMS: IDBMS;
    // FServConnection: IDBConnection;

    function AtualizeVersao: boolean;
    procedure ConfigureForm;
    procedure ConfigureSplashForm;
    function GarantirConfig(pLoja: ILoja; pUsuarioGerente: IUsuario): boolean;
  protected
    property AppInfo: IAppInfo read FAppInfo;
    property AppObj: IAppObj read FAppObj;

    procedure OculteSplashForm;
    function GetAppInfoCreate: IAppInfo; virtual; abstract;
  public
    { Public declarations }
  end;

var
  PrincBasForm: TPrincBasForm;

implementation

{$R *.dfm}

uses App.Factory, App.UI.Form.Status_u, Sis.UI.IO.Factory, Sis.UI.ImgDM,
  Sis.UI.Controls.Utils, Sis.UI.IO.Output.ProcessLog.Factory, Sis.DB.Factory,
  App.AppObj_u_ExecEventos, Sis.UI.Form.Splash_u, Sis.UI.Controls.TImage,
  System.DateUtils, App.AtualizaVersao, Sis.Types.Bool_u, Sis.Entities.Factory,
  App.SisConfig.Garantir, App.DB.Garantir;

function TPrincBasForm.AtualizeVersao: boolean;
var
  oAtualizaVersao: IAtualizaVersao;
  bPrecisaResetar: boolean;
  sLog: string;
begin
  FProcessLog.PegueLocal('TPrincBasForm.AtualizeVersao');
  try
    {$IFDEF DEBUG}
    sLog := 'Config=DEBUG, abortando';
    Result := False;
    Exit;
    {$ENDIF}


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

    Color := FAppInfo.FundoCor;
    Font.Color := FAppInfo.FonteCor;

    StatusLabel.Color := FAppInfo.FundoCor;
    StatusLabel.Font.Color := FAppInfo.FonteCor;

    StatusMemo.Color := FAppInfo.FundoCor;
    StatusMemo.Font.Color := FAppInfo.FonteCor;

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

procedure TPrincBasForm.FormCreate(Sender: TObject);
var
  bResultado: boolean;
begin
  inherited;
  DisparaShowTimer := True;
  MakeRounded(Self, 30);
  ToolBar1.Left := Width - ToolBar1.Width;
  FStatusOutput := LabelOutputCreate(StatusLabel);
  FProcessOutput := MemoOutputCreate(StatusMemo);
  FProcessLog := ProcessLogFileCreate(Name);

  FProcessLog.PegueLocal('TPrincBasForm.FormCreate');
  try
    // FSisConfig := SisConfigCreate;

    FProcessLog.RegistreLog('FAppInfo,FAppObj,Create');
    // FAppInfo := App.Factory.AppInfoCreate(Application.ExeName);
    FAppInfo := GetAppInfoCreate;

    // FDBMSConfig := DBMSConfigCreate(FSisConfig, FProcessLog, FProcessOutput);

    // FDBMS: IDBMS;

    FAppObj := App.Factory.AppObjCreate(FAppInfo, FStatusOutput, FProcessOutput,
      FProcessLog);

    FsLogo1NomeArq := FAppInfo.PastaImg + 'App\Logo Tela.jpg';
    bResultado := FAppObj.Inicialize;

    ToolBar1.Images := SisImgDataModule.ImageList_40_24;

    ConfigureForm;

    ConfigureSplashForm;

    SplashForm.Show;
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TPrincBasForm.FormDestroy(Sender: TObject);
begin
  ExecEvento(TSessaoMomento.ssmomFim, FAppInfo, FStatusOutput, FProcessLog);
  inherited;

end;

function TPrincBasForm.GarantirConfig(pLoja: ILoja;
  pUsuarioGerente: IUsuario): boolean;
var
  oAppSisConfigGarantir: IAppSisConfigGarantir;
  sLog: string;
  oSisConfig: ISisConfig;
begin
  FProcessLog.PegueLocal('TPrincBasForm.GarantirConfig');
  try
    oSisConfig := FAppObj.SisConfig;

    oAppSisConfigGarantir := SisConfigGarantirCreate(FAppInfo,
      oSisConfig, pUsuarioGerente, pLoja, FProcessOutput, FProcessLog);
    FProcessLog.RegistreLog('vai oAppSisConfigGarantir.Execute');
    Result := oAppSisConfigGarantir.Execute;

    sLog := iif(Result, 'Result=True,ok', 'Result=False,deve abortar');
    FProcessLog.RegistreLog(sLog);
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TPrincBasForm.MinimizeAction_PrincBasFormExecute(Sender: TObject);
begin
  inherited;
  Application.Minimize;
end;

procedure TPrincBasForm.OculteSplashForm;
begin
  if not Assigned(SplashForm) then
    FreeAndNil(SplashForm);
end;

procedure TPrincBasForm.ShowTimer_BasFormTimer(Sender: TObject);
var
  bResultado: boolean;
  oLoja: ILoja;
  oUsuarioGerente: IUsuario;
  oSisConfig: ISisConfig;
begin
  inherited;
  FProcessLog.PegueLocal('TPrincBasForm.ShowTimer_BasFormTimer');
  try
    bResultado := AtualizeVersao;
    if bResultado then
    begin
      FProcessLog.RegistreLog
        ('AtualizeVersao retornou true, Application.Terminate');
      Application.Terminate;
      Exit;
    end;

    oLoja := LojaCreate;
    oUsuarioGerente := UsuarioCreate;

    bResultado := GarantirConfig(oLoja, oUsuarioGerente);

    if not bResultado then
    begin
      FProcessLog.RegistreLog
        ('GarantirConfig retornou false, Application.Terminate');
      Application.Terminate;
      Exit;
    end;

    oSisConfig := FAppObj.SisConfig;
    bResultado := GarantirDB(oSisConfig, FAppInfo, FProcessLog, FProcessOutput);

    if not bResultado then
    begin
      FProcessLog.RegistreLog
        ('GarantirDB retornou false, Application.Terminate');
      Application.Terminate;
      Exit;
    end;


  finally
    OculteSplashForm;
    FProcessLog.RetorneLocal;
  end;
end;

end.
