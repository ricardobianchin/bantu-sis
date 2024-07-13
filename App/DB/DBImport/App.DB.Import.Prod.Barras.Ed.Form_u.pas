unit App.DB.Import.Prod.Barras.Ed.Form_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.IO.Input.Str.Form_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.Buttons;

type
  TImportBarEdForm = class(TInputStrForm)
    Label1: TLabel;
    procedure Label1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImportBarEdForm: TImportBarEdForm;

implementation

uses Sis.Types.Codigos.Utils, Sis.UI.Controls.Utils;

{$R *.dfm}

procedure TImportBarEdForm.FormCreate(Sender: TObject);
begin
  inherited;
  ClearStyleElements(Self);

end;

procedure TImportBarEdForm.Label1Click(Sender: TObject);
begin
  inherited;
  LabeledEdit1.Text := EAN13GetRandom;
end;

end.
