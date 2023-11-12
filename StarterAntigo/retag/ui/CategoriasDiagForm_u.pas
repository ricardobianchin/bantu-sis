unit CategoriasDiagForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DiagForm_u, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList;

type
  TCategDiagForm = class(TDiagForm)
    NomeLabeledEdit: TLabeledEdit;
    procedure NomeLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure NomeLabeledEditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function PodeOk: boolean; override;
  public
    { Public declarations }
  end;

function Editar(var pNome: string): boolean;

var
  CategDiagForm: TCategDiagForm;

implementation

{$R *.dfm}

uses btn.lib.types.strings;

function Editar(var pNome: string): boolean;
begin
  CategDiagForm := TCategDiagForm.Create(nil);
  try
    CategDiagForm.NomeLabeledEdit.Text := pNome;
    Result := CategDiagForm.ShowModal = mrOk;
    if Result then
    begin
      pNome := CategDiagForm.NomeLabeledEdit.Text;
    end;
  finally
    CategDiagForm.Free;
  end;
end;

procedure TCategDiagForm.FormShow(Sender: TObject);
begin
  inherited;
  NomeLabeledEdit.SetFocus;
end;

procedure TCategDiagForm.NomeLabeledEditChange(Sender: TObject);
begin
  inherited;
  ErroLabel.Caption := '';
end;

procedure TCategDiagForm.NomeLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = #13 then
  begin
    OkAction.Execute;
    exit;
  end;

  btn.lib.types.strings.CharSemAcento(Key);
end;

function TCategDiagForm.PodeOk: boolean;
begin
  NomeLabeledEdit.Text := Trim(NomeLabeledEdit.Text);
  result := NomeLabeledEdit.Text <> '';
  if not result then
  begin
    ErroLabel.Caption := 'Nome é obrigatório';
    NomeLabeledEdit.SetFocus;
  end;
end;

end.
