unit App.UI.Form.Bas.Princ_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Act_u, System.Actions,
  App.AppInfo, App.AppObj, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Sis.Config.SisConfig;

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
    procedure MinimizeAction_PrincBasFormExecute(Sender: TObject);
    procedure FecharAction_ActBasFormExecute(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FAppInfo: IAppInfo;
    FAppObj: IAppObj;

    FStatusOutput: IOutput;
    FProcessOutput: IOutput;
    FProcessLog: IProcessLog;

    FSisConfig: ISisConfig;

    procedure CaregarLogo1;

  protected
    property AppInfo: IAppInfo read FAppInfo;
    property AppObj: IAppObj read FAppObj;

    procedure OculteStatusForm;
  public
    { Public declarations }
  end;

var
  PrincBasForm: TPrincBasForm;

implementation

{$R *.dfm}

uses App.Factory, App.UI.Form.Status_u, Sis.UI.IO.Factory,
  Sis.UI.Controls.Utils,
  Sis.UI.ImgDM, Sis.UI.IO.Output.ProcessLog.Factory;

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

  FProcessLog.RegistreLog('FAppInfo,FAppObj,Create');
  FAppInfo := App.Factory.AppInfoCreate(Application.ExeName);
  FAppObj := App.Factory.AppObjCreate(FAppInfo, FStatusOutput, FProcessOutput,
    FProcessLog);

  FAppObj.Inicialize;

  FProcessLog.RegistreLog('Carregar nomeexib e logo1');
  TitleBarCaptionLabel.Caption := FAppInfo.NomeExib;
  CaregarLogo1;
  FProcessLog.RetorneLocal;
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
