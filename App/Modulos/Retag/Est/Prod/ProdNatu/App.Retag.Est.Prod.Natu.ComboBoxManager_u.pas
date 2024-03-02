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
end;

procedure TProdNatuComboBoxManager.Preencher;
begin
  LimparItens;
  ComboBox.Items.Clear;
  PegarChar('P', 'PRODUTO');
  PegarChar('S', 'SERVICO');
  PegarChar('B', 'COMBO');
  PegarChar('M', 'MATERIA-PRIMA');
  PegarChar('C', 'COMPOSTO');
end;

end.
