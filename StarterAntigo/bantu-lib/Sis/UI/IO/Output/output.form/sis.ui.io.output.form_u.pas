unit sis.ui.io.output.form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TOutputForm = class(TForm)
    BasePanel: TPanel;
    Memo1: TMemo;
    ShowTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ShowTimerTimer(Sender: TObject);
  private
    { Private declarations }
    FFezShow: boolean;
  public
    { Public declarations }
    procedure AddLinha(pStr: string);
  end;

var
  OutputForm: TOutputForm;

implementation

{$R *.dfm}

uses sis.ui.Controls.utils;

{ TOutputForm }

procedure TOutputForm.AddLinha(pStr: string);
begin
  Memo1.Lines.Add(pStr);
  SimuleTecla(VK_END, Memo1);
  //Repaint;
  Application.ProcessMessages;
  // s le ep(1250);
end;

procedure TOutputForm.FormCreate(Sender: TObject);
begin
  FFezShow := False;
end;

procedure TOutputForm.FormShow(Sender: TObject);
begin
  if FFezShow then
    exit;
  FFezShow := true;
  ShowTimer.Enabled := true;
end;

procedure TOutputForm.ShowTimerTimer(Sender: TObject);
begin
  ShowTimer.Enabled := False;
  Left := Screen.Width - Width - 1;
  Top := 20;
  Application.ProcessMessages;
end;

end.
