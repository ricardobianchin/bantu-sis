unit Sis.UI.Form.Bas.Diag.Btn_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TDiagBtnBasForm = class(TDiagBasForm)
    BasePanel: TPanel;
    OkBitBtn_DiagBtn: TBitBtn;
    CancelBitBtn_DiagBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DiagBtnBasForm: TDiagBtnBasForm;

implementation

{$R *.dfm}

procedure TDiagBtnBasForm.FormCreate(Sender: TObject);
begin
  inherited;
  MensLabel.Top := BasePanel.Top - CancelBitBtn_DiagBtn.Height - 3;
end;

end.
