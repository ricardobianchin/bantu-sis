inherited ProdTipoEdForm: TProdTipoEdForm
  Caption = 'ProdTipoEdForm'
  ClientWidth = 487
  ExplicitWidth = 499
  ExplicitHeight = 306
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 487
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 487
  end
  object LabeledEdit1: TLabeledEdit [3]
    Left = 8
    Top = 48
    Width = 260
    Height = 23
    EditLabel.Width = 67
    EditLabel.Height = 15
    EditLabel.Caption = 'LabeledEdit1'
    MaxLength = 40
    TabOrder = 1
    Text = ''
    OnChange = LabeledEdit1Change
    OnKeyPress = LabeledEdit1KeyPress
  end
  inherited BasePanel: TPanel
    Width = 487
    ExplicitWidth = 487
  end
end
