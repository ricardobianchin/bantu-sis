inherited ProdSelectFrame: TProdSelectFrame
  Width = 499
  Height = 26
  OnResize = FrameResize
  ExplicitWidth = 499
  ExplicitHeight = 26
  object BuscaSpeedButton: TSpeedButton
    Left = 471
    Top = 0
    Width = 23
    Height = 23
    Hint = 'Buscar...'
    ImageIndex = 0
    Images = SisImgDataModule.ImageList16Flat
    Visible = False
    OnClick = BuscaSpeedButtonClick
  end
  object ListaSpeedButton: TSpeedButton
    Left = 472
    Top = 0
    Width = 23
    Height = 23
    Hint = 'Produtos...'
    ImageIndex = 1
    Images = SisImgDataModule.ImageList16Flat
    OnClick = ListaSpeedButtonClick
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
    OnKeyDown = ProdLabeledEditKeyDown
    OnKeyPress = ProdLabeledEditKeyPress
  end
end
