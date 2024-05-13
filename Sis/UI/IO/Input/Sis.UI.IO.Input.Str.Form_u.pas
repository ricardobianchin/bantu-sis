unit Sis.UI.IO.Input.Str.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask;

type
  TInputStrForm = class(TDiagBtnBasForm)
    LabeledEdit1: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  InputStrForm: TInputStrForm;

implementation

{$R *.dfm}

procedure TInputStrForm.FormCreate(Sender: TObject);
begin
  inherited;
  LabeledEdit1.OnKeyPress := EditKeyPressUltimo;
end;

end.
