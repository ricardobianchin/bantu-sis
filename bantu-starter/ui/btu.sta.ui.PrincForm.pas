unit btu.sta.ui.PrincForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sis.ui.io.LogProcess, Vcl.AppEvnts,    Sis.UI.IO.Output.Form_u,
  sis.ui.io.output, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TPrincForm = class(TForm, IOutput)
    ApplicationEvents1: TApplicationEvents;
    StatusMemo: TMemo;
    ShowTimer: TTimer;
    DtHCompileLabel: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure ShowTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FLogProcess: ILogProcess;
//    FOutputForm: TOutputForm;
//    FOutputToForm: IOutput;
//    FOutput: IOutput;
    procedure ExecStarter;
  public

    { Public declarations }
    procedure Exibir(pFrase: string);
    procedure ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
  end;

var
  PrincForm: TPrincForm;

implementation

{$R *.dfm}

uses Sta.exec_u, sis.ui.Img.DataModule, sis.ui.io.LogProcess.factory,
  sis.ui.io.factory, sis.ui.controls.utils, sis.ui.io.output.exibirpausa.form_u,
  btu.lib.debug, Sta.Versao;

procedure TPrincForm.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
//  ShowMessage(e.ClassName+' '+e.Message);
end;

procedure TPrincForm.ExecStarter;
var
  e: TStarterExec;
begin
  try
  FLogProcess := LogProcessFileCreate( 'Starter');

//  FOutputForm := TOutputForm.Create(self);
//  FOutputToForm := OutputToFormCreate(FOutputForm);
  FLogProcess.Exibir('TPrincForm.FormCreate, TStarterExec.Create');
  e := TStarterExec.Create(FLogProcess, Self{FOutputToForm});
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

procedure TPrincForm.Exibir(pFrase: string);
begin
  StatusMemo.Lines.Add(pFrase);
  SimuleTecla(VK_END, StatusMemo);
  //Repaint;
  Application.ProcessMessages;
  // s le ep(1250);

end;

procedure TPrincForm.ExibirPausa(pFrase: string; pMsgDlgType: TMsgDlgType);
begin
  Exibir(pFrase);
  sis.ui.io.output.exibirpausa.form_u.Exibir(pFrase, pMsgDlgType);
end;

procedure TPrincForm.FormCreate(Sender: TObject);
begin
  SisImgDataModule := TSisImgDataModule.Create(self);
  DtHCompileLabel.Caption := 'Compilado em: ' + Sta.Versao.DTH_COMPILE;
end;

procedure TPrincForm.FormShow(Sender: TObject);
begin
  ShowTimer.Enabled := true;

end;

procedure TPrincForm.ShowTimerTimer(Sender: TObject);
begin
  ShowTimer.Enabled := False;
  ExecStarter;
end;

end.
