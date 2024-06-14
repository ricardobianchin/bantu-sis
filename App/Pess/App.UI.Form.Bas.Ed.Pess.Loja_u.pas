unit App.UI.Form.Bas.Ed.Pess.Loja_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed.Pess_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TPessLojaEdForm = class(TPessEdBasForm)
    AtivoCheckBox: TCheckBox;
    procedure AtivoCheckBoxKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PessLojaEdForm: TPessLojaEdForm;

implementation

{$R *.dfm}

procedure TPessLojaEdForm.AtivoCheckBoxKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    OkAct_Diag.Execute;
    exit;
  end;
end;

end.
