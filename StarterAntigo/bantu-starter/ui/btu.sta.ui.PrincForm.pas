unit btu.sta.ui.PrincForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sis.ui.io.LogProcess, Vcl.AppEvnts,    Sis.UI.IO.Output.Form_u,
  sis.ui.io.output, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

const
  Radius = 30;

type
  TStarterPrincForm = class(TForm, IOutput)
    ApplicationEvents1: TApplicationEvents;
    StatusMemo: TMemo;
    ShowTimer: TTimer;
    DtHCompileLabel: TLabel;
    Image1: TImage;
    StatusLabel: TLabel;

    procedure FormCreate(Sender: TObject);

    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure ShowTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FLogProcess: ILogProcess;
//    FOutputForm: TOutputForm;
//    FOutputToForm: IOutput;
    FOutputStatus: IOutput;
    procedure ExecStarter;
    procedure MakeRounded(Control: TWinControl);
  public

    { Public declarations }
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
  end;

var
  StarterPrincForm: TStarterPrincForm;

implementation

{$R *.dfm}

uses Sta.exec_u, sis.ui.Img.DataModule, sis.ui.io.LogProcess.factory,
  sis.ui.io.factory, sis.ui.controls.utils, sis.ui.io.output.exibirpausa.form_u,
  btu.lib.debug, Sta.Versao;

procedure TStarterPrincForm.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
//  ShowMessage(e.ClassName+' '+e.Message);
end;

procedure TStarterPrincForm.ExecStarter;
var
  e: TStarterExec;
begin
  try
  FLogProcess := LogProcessFileCreate( 'Starter');

//  FOutputForm := TOutputForm.Create(self);
//  FOutputToForm := OutputToFormCreate(FOutputForm);
  FLogProcess.Exibir('TPrincForm.FormCreate, TStarterExec.Create');
  e := TStarterExec.Create(FLogProcess, Self, FOutputStatus);
  try
    e.Execute;
  finally
    e.Free;
  end;
  except on E: Exception do
    FLogProcess.Exibir('TPrincForm.ExecStarter Erro '+E.ClassName+' '+e.Message);
  end;
  FLogProcess.Exibir('Vai finalizar a aplicação');
  Application.Terminate;
end;

procedure TStarterPrincForm.Exibir(pFrase: string);
begin
  StatusMemo.Lines.Add(pFrase);
  SimuleTecla(VK_END, StatusMemo);
  //Repaint;
  Application.ProcessMessages;
  // s le ep(1250);

end;

procedure TStarterPrincForm.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin
  Exibir(pFrase);
  sis.ui.io.output.exibirpausa.form_u.Exibir(pFrase, pMsgDlgType);
end;

procedure TStarterPrincForm.FormCreate(Sender: TObject);
begin
  SisImgDataModule := TSisImgDataModule.Create(self);
  DtHCompileLabel.Caption := 'Compilado em: ' + Sta.Versao.DTH_COMPILE;
  MakeRounded(Self);
  FOutputStatus := OutputToLabelCreate(StatusLabel);
end;

procedure TStarterPrincForm.FormShow(Sender: TObject);
begin
  ShowTimer.Enabled := true;

end;

procedure TStarterPrincForm.MakeRounded(Control: TWinControl);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control do
  begin
    R   := ClientRect;
    rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, Radius, Radius);
    Perform(EM_GETRECT, 0, lParam(@r));
    InflateRect(r, - 5, - 5);
    Perform(EM_SETRECTNP, 0, lParam(@r));
    SetWindowRgn(Handle, rgn, True);
    Invalidate;
  end;
end;

procedure TStarterPrincForm.ShowTimerTimer(Sender: TObject);
begin
  ShowTimer.Enabled := False;
  ExecStarter;
end;

end.
