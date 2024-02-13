unit App.UI.Form.Bas.Ed.Descr_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask;

type
  TEdDescrBasForm = class(TEdBasForm)
    LabeledEdit1: TLabeledEdit;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EdDescrBasForm: TEdDescrBasForm;

implementation

{$R *.dfm}

procedure TEdDescrBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  LabeledEdit1.SetFocus;
end;

end.
