unit App.Retag.Est.Prod.Natu.ComboBoxManager_u;

interface

uses Sis.UI.Controls.ComboBoxManager_u, Vcl.StdCtrls, App.Est.Types_u;

type
  TProdNatuComboBoxManager = class(TComboBoxManager)
  private
    procedure Preencher;
  public
    constructor Create(pComboBox: TComboBox);
  end;

implementation

{ TProdNatuComboBoxManager }

constructor TProdNatuComboBoxManager.Create(pComboBox: TComboBox);
begin
  inherited Create(pComboBox);
  Preencher;
end;

procedure TProdNatuComboBoxManager.Preencher;
var
  i: integer;
begin
  LimparItens;
  ComboBox.Items.Clear;
  for i := Ord(pnatuProduto) to High(TProdNatu) do
  begin
    PegarIdChar(Chr(i), ProdNatuStr[TProdNatu(i)]);
  end;
end;

end.
