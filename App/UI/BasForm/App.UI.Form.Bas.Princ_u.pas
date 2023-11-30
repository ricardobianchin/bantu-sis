unit App.UI.Form.Bas.Princ_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Act_u, System.Actions,
  App.AppInfo, App.AppObj, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Sis.Config.SisConfig, Sis.DB.DBTypes;

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
    procedure FecharAction_ActBasFormExecute(Sender: TObject);

    procedure MinimizeAction_PrincBasFormExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
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

    procedure CaregarLogo1;

  protected
    property AppInfo: IAppInfo read FAppInfo;
    property AppObj: IAppObj read FAppObj;

    procedure OculteStatusForm;
    function GetAppInfoCreate: IAppInfo; virtual; abstract;
  public
    { Public declarations }
  end;

var
  PrincBasForm: TPrincBasForm;

implementation

{$R *.dfm}

uses App.Factory, App.UI.Form.Status_u, Sis.UI.IO.Factory,
  Sis.UI.Controls.Utils,
  Sis.UI.ImgDM, Sis.UI.IO.Output.ProcessLog.Factory, Sis.DB.Factory,
  App.AppObj_u_ExecEventos;

procedure TPrincBasForm.CaregarLogo1;
var
  s: string;
  jpg: TJPEGImage;
begin
  s := FAppInfo.PastaImg + 'App\Logo Tela.jpg';
  if not FileExists(s) then
    exit;
  jpg := TJPEGImage.Create;
  try
    jpg.LoadFromFile(s);
    Logo1Image.Picture.Graphic := jpg;
  finally
    jpg.Free;
  end;
end;

procedure TPrincBasForm.FecharAction_ActBasFormExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TPrincBasForm.FormCreate(Sender: TObject);
var
  bResultado: boolean;
begin
  StatusForm := TStatusForm.Create(nil);
  StatusForm.Show;
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

    bResultado := FAppObj.Inicialize;
    if not bResultado then
    begin
      Application.Terminate;
      exit;
    end;
    FProcessLog.RegistreLog('Carregar nomeexib e logo1');
    TitleBarCaptionLabel.Caption := FAppInfo.NomeExib;
    CaregarLogo1;
  finally
    FProcessLog.RetorneLocal;
  end;
end;

procedure TPrincBasForm.FormDestroy(Sender: TObject);
begin
  ExecEvento(TSessaoMomento.ssmomFim, FAppInfo, FStatusOutput, FProcessLog);
  inherited;

end;

procedure TPrincBasForm.MinimizeAction_PrincBasFormExecute(Sender: TObject);
begin
  inherited;
  Application.Minimize;
end;

procedure TPrincBasForm.OculteStatusForm;
begin
  if not Assigned(StatusForm) then
    FreeAndNil(StatusForm);
end;

procedure TPrincBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ToolBar1.Images := SisImgDataModule.ImageList_40_24;
end;

end.
