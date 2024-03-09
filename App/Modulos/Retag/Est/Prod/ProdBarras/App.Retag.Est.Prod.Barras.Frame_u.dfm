object ProdBarrasFrame: TProdBarrasFrame
  Left = 0
  Top = 0
  Width = 244
  Height = 24
  ParentShowHint = False
  ShowHint = True
  TabOrder = 0
  object SpeedButton1: TSpeedButton
    Left = 199
    Top = 1
    Width = 23
    Height = 22
    Hint = 'Lista de C'#243'digo deste Produto'
    ImageIndex = 1
    Images = SisImgDataModule.ImageList16Flat
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 221
    Top = 1
    Width = 23
    Height = 22
    Hint = 'Pesquisar na Web'
    ImageIndex = 2
    Images = SisImgDataModule.ImageList16Flat
    OnClick = SpeedButton2Click
  end
  object LabeledEdit1: TLabeledEdit
    Left = 94
    Top = 1
    Width = 105
    Height = 23
    EditLabel.Width = 90
    EditLabel.Height = 23
    EditLabel.Caption = 'C'#243'digo de Barras'
    LabelPosition = lpLeft
    LabelSpacing = 4
    NumbersOnly = True
    TabOrder = 0
    Text = '7896422515658'
  end
end
