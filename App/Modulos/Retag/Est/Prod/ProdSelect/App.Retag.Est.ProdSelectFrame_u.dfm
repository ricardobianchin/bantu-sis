inherited ProdSelectFrame: TProdSelectFrame
  Width = 500
  Height = 24
  ExplicitWidth = 500
  ExplicitHeight = 24
  object BuscaSpeedButton: TSpeedButton
    Left = 471
    Top = 0
    Width = 23
    Height = 23
    Hint = 'Buscar...'
    ImageIndex = 0
    Images = SisImgDataModule.ImageList16Flat
    OnClick = BuscaSpeedButtonClick
  end
  object ProdLabeledEdit: TLabeledEdit
    Left = 49
    Top = 0
    Width = 419
    Height = 23
    EditLabel.Width = 43
    EditLabel.Height = 23
    EditLabel.Caption = 'Produto'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 0
    Text = ''
    StyleElements = []
    OnClick = ProdLabeledEditClick
  end
end
