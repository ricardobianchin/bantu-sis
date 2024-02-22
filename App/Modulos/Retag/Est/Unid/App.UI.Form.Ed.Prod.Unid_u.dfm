inherited ProdUnidEdForm: TProdUnidEdForm
  Caption = 'ProdUnidEdForm'
  TextHeight = 15
  object SiglaLabeledEdit: TLabeledEdit [2]
    Left = 273
    Top = 48
    Width = 80
    Height = 23
    EditLabel.Width = 25
    EditLabel.Height = 15
    EditLabel.Caption = 'Sigla'
    TabOrder = 1
    Text = ''
    OnChange = SiglaLabeledEditChange
    OnKeyPress = SiglaLabeledEditKeyPress
  end
  object DescrLabeledEdit: TLabeledEdit [3]
    Left = 8
    Top = 48
    Width = 260
    Height = 23
    EditLabel.Width = 51
    EditLabel.Height = 15
    EditLabel.Caption = 'Descri'#231#227'o'
    MaxLength = 40
    TabOrder = 0
    Text = ''
    OnChange = DescrLabeledEditChange
    OnKeyPress = DescrLabeledEditKeyPress
  end
  inherited BasePanel: TPanel
    TabOrder = 2
  end
end
