inherited ProdTipoEdForm: TProdTipoEdForm
  Caption = 'ProdTipoEdForm'
  ClientWidth = 483
  ExplicitWidth = 499
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 483
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 483
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
    Width = 483
    ExplicitWidth = 483
  end
end
