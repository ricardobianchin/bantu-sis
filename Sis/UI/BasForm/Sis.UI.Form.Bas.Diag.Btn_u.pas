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
    procedure MensCopyAct_DiagExecute(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FBaseControlsAlinhador: IControlsAlinhador;
  protected
    procedure PreencherBaseControlsAlinhador(pBaseControlsAlinhador: IControlsAlinhador); virtual;
    procedure CriarControles; virtual;
    procedure AjusteControles; virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  DiagBtnBasForm: TDiagBtnBasForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Factory;

procedure TDiagBtnBasForm.AjusteControles;
begin
  PreencherBaseControlsAlinhador(FBaseControlsAlinhador);
  FBaseControlsAlinhador.Execute;
end;

constructor TDiagBtnBasForm.Create(AOwner: TComponent);
begin
  inherited;
  FBaseControlsAlinhador := ControlsAlinhadorADireitaCreate;
  MensLabel.Top := BasePanel.Top - CancelBitBtn_DiagBtn.Height - 3;
  //MensLabel.Font.Color := $009393FF;//onyx
//  MensLabel.Font.Color := 192;//iceberg
  MensLabel.Font.Color := 166;//iceberg
  CriarControles;
end;

procedure TDiagBtnBasForm.CriarControles;
begin

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

procedure TDiagBtnBasForm.PreencherBaseControlsAlinhador(
  pBaseControlsAlinhador: IControlsAlinhador);
begin
  pBaseControlsAlinhador.PegarControl(OkBitBtn_DiagBtn);
  pBaseControlsAlinhador.PegarControl(CancelBitBtn_DiagBtn);
  pBaseControlsAlinhador.PegarControl(MensCopyBitBtn_DiagBtn);
end;

procedure TDiagBtnBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  AjusteControles;
end;

end.
