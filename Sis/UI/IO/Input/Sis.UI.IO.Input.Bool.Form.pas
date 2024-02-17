unit Sis.UI.IO.Input.Bool.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TPergBooleanForm = class(TDiagBtnBasForm)
    MensagemLabel: TLabel;
    procedure MensCopyAct_DiagExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PergBooleanForm: TPergBooleanForm;

implementation

{$R *.dfm}

uses Sis.Win.Utils_u;

procedure TPergBooleanForm.MensCopyAct_DiagExecute(Sender: TObject);
begin
//  inherited;
  MensCopyAct_Diag.Enabled := False;
  Application.ProcessMessages;
  SetClipboardText(ClassName + ', ' + Name + ', ' + Caption + ', [' +
    MensagemLabel.Caption + ']');
  Sleep(200);
  MensCopyAct_Diag.Enabled := True;
end;

end.
