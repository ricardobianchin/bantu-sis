inherited RetagProdEdObrigFrame: TRetagProdEdObrigFrame
  Width = 800
  Height = 190
  ExplicitWidth = 800
  ExplicitHeight = 190
  object NatuLabel: TLabel
    Left = 113
    Top = 6
    Width = 47
    Height = 15
    Caption = 'Natureza'
  end
  object DescrEdit: TLabeledEdit
    Left = 59
    Top = 45
    Width = 406
    Height = 23
    EditLabel.Width = 51
    EditLabel.Height = 23
    EditLabel.Caption = 'Descri'#231#227'o'
    LabelPosition = lpLeft
    LabelSpacing = 4
    MaxLength = 120
    TabOrder = 0
    Text = ''
  end
  object DescrRedEdit: TLabeledEdit
    Left = 581
    Top = 45
    Width = 194
    Height = 23
    EditLabel.Width = 102
    EditLabel.Height = 23
    EditLabel.Caption = 'Descri'#231#227'o Reduzida'
    LabelPosition = lpLeft
    MaxLength = 29
    TabOrder = 1
    Text = ''
  end
  object NatuCombo: TComboBox
    Left = 164
    Top = 2
    Width = 119
    Height = 23
    TabOrder = 2
  end
  object CustoGroupBox: TGroupBox
    Left = 7
    Top = 121
    Width = 253
    Height = 52
    Caption = 'Custo'
    TabOrder = 3
  end
  object PrecoGroupBox: TGroupBox
    Left = 264
    Top = 121
    Width = 364
    Height = 52
    Caption = 'Pre'#231'o'
    TabOrder = 4
  end
end
