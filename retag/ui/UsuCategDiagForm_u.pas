unit UsuCategDiagForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DiagForm_u, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TUsuCategDiagForm = class(TDiagForm)
    NomeLabeledEdit: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UsuCategDiagForm: TUsuCategDiagForm;

function Editar(var pNome: string): boolean;

implementation

{$R *.dfm}

uses types;

function Editar(var pNome: string): boolean;
begin
  UsuCategDiagForm := TUsuCategDiagForm.Create(nil);
  try
    UsuCategDiagForm.NomeLabeledEdit.Text := pNome;
    Result := UsuCategDiagForm.ShowModal = mrOk;
    if Result then
    begin
      pNome := UsuCategDiagForm.NomeLabeledEdit.Text;
    end;
  finally
    UsuCategDiagForm.Free;
  end;
end;


end.
