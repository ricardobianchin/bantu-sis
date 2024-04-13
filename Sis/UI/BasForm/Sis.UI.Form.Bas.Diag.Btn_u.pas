unit Sis.UI.Form.Bas.Diag.Btn_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.StdActns,
  Sis.Win.Utils_u, Sis.UI.Controls.Alinhador;

type
  TDiagBtnBasForm = class(TDiagBasForm)
    BasePanel: TPanel;
    OkBitBtn_DiagBtn: TBitBtn;
    CancelBitBtn_DiagBtn: TBitBtn;
    MensCopyAct_Diag: TAction;
    MensCopyBitBtn_DiagBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure MensCopyAct_DiagExecute(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure CriarControles; virtual;
    procedure AjusteControles; virtual;
  public
    { Public declarations }
  end;

var
  DiagBtnBasForm: TDiagBtnBasForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Factory;

procedure TDiagBtnBasForm.AjusteControles;
var
  oControlsAlinhador: IControlsAlinhador;
begin
  oControlsAlinhador := ControlsAlinhadorADireitaCreate;

  oControlsAlinhador.PegarControl(OkBitBtn_DiagBtn);
  oControlsAlinhador.PegarControl(CancelBitBtn_DiagBtn);
  oControlsAlinhador.PegarControl(MensCopyBitBtn_DiagBtn);

  oControlsAlinhador.Execute;
end;

procedure TDiagBtnBasForm.CriarControles;
begin

end;

procedure TDiagBtnBasForm.FormCreate(Sender: TObject);
begin
  inherited;
  MensLabel.Top := BasePanel.Top - CancelBitBtn_DiagBtn.Height - 3;
  //MensLabel.Font.Color := $009393FF;//onyx
//  MensLabel.Font.Color := 192;//iceberg
  MensLabel.Font.Color := 166;//iceberg
end;

procedure TDiagBtnBasForm.MensCopyAct_DiagExecute(Sender: TObject);
begin
  inherited;
  MensCopyAct_Diag.Enabled := False;
  Application.ProcessMessages;
  SetClipboardText(ClassName + ', ' + Name + ', ' + Caption + ', [' +
    MensLabel.Caption + ']');
  Sleep(200);
  MensCopyAct_Diag.Enabled := True;
end;

procedure TDiagBtnBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  CriarControles;
  AjusteControles;
end;

end.
