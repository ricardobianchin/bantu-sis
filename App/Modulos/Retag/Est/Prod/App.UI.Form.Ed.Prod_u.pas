unit App.UI.Form.Ed.Prod_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.Ed_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask;

type
  TProdEdForm = class(TEdBasForm)
    LabeledEdit1: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FIdNumEdit: TNumEditBtu;
  public
    { Public declarations }
  end;

var
  ProdEdForm: TProdEdForm;

implementation

{$R *.dfm}

procedure TProdEdForm.FormCreate(Sender: TObject);
begin
  inherited;
  FIdNumEdit := TNumEditBtu.Create(Self);
  FIdNumEdit.Parent := Self;
  FIdNumEdit.NCasas:=0;
  FIdNumEdit.NCasasEsq:=7;

  FIdNumEdit.MascEsq := '0000000';

  FIdNumEdit.Left := ObjetivoLabel.Left;
  FIdNumEdit.Top := ObjetivoLabel.Top + Round(ObjetivoLabel.Height * 2.5);

  FIdNumEdit.Caption := 'Código';

//  FIdNumEdit.OnKeyPress := PercNumEditKeyPress;
//  FIdNumEdit.OnChange := PercNumEditChange;

end;

procedure TProdEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  DescrLabeledEdit.SetFocus;
end;

end.
