inherited ComboBoxSelectBasFrame: TComboBoxSelectBasFrame
  Width = 334
  ExplicitWidth = 334
  inherited TitLabel: TLabel
    Height = 37
  end
  object BuscaSpeedButton: TSpeedButton [1]
    Left = 208
    Top = 0
    Width = 23
    Height = 37
    Hint = 'Buscar...'
    Align = alLeft
    ImageIndex = 0
    Images = SisImgDataModule.ImageList16Flat
    ExplicitLeft = 322
    ExplicitHeight = 22
  end
  object Espacador2Label: TLabel [3]
    Left = 206
    Top = 0
    Width = 2
    Height = 37
    Align = alLeft
    AutoSize = False
    Visible = False
    ExplicitLeft = 309
    ExplicitHeight = 23
  end
  inherited ComboBox1: TComboBox
    ExplicitLeft = 6
  end
end
