unit App.Retag.Est.Prod.Natu.ComboBoxManager_u;

interface

uses Sis.UI.Controls.ComboBoxManager_u, Vcl.StdCtrls;

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
begin
  LimparItens;
  ComboBox.Items.Clear;
  PegarIdChar(#33, 'PRODUTO');
  PegarIdChar(#34, 'SERVICO');
  PegarIdChar(#35, 'COMBO');
  PegarIdChar(#36, 'MATERIA-PRIMA');
  PegarIdChar(#37, 'COMPOSTO');
end;

end.
