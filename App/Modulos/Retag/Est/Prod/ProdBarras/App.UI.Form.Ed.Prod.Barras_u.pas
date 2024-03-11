unit App.UI.Form.Ed.Prod.Barras_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag.Btn_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask;

type
  TProdBarrasEdForm = class(TDiagBtnBasForm)
    LabeledEdit1: TLabeledEdit;
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  protected
    function PodeOk: Boolean; override;
  public
    { Public declarations }

  end;

var
  ProdBarrasEdForm: TProdBarrasEdForm;

implementation

{$R *.dfm}

uses Sis.Types.Codigos.Utils;

{ TProdBarrasEdForm }

procedure TProdBarrasEdForm.LabeledEdit1Change(Sender: TObject);
begin
  inherited;
  MensLabel.Visible := false;
end;

procedure TProdBarrasEdForm.LabeledEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key = #13 then
    OkAct_Diag.Execute;
end;

function TProdBarrasEdForm.PodeOk: Boolean;
begin
  Result := BarCodValido(LabeledEdit1.Text);

  if not Result then
  begin
    ErroOutput.Exibir('Código de barras inválido');
    LabeledEdit1.SetFocus;
    exit;
  end;
end;

end.
