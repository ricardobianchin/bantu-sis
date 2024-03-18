object ProdBarrasFrame: TProdBarrasFrame
  Left = 0
  Top = 0
  Width = 244
  Height = 40
  ParentShowHint = False
  ShowHint = True
  TabOrder = 0
  object BarrasListSpeedButton: TSpeedButton
    Left = 199
    Top = 1
    Width = 23
    Height = 22
    Hint = 'Lista de C'#243'digo deste Produto'
    ImageIndex = 1
    Images = SisImgDataModule.ImageList16Flat
    OnClick = BarrasListSpeedButtonClick
  end
  object ConsultarWebSpeedButton: TSpeedButton
    Left = 221
    Top = 1
    Width = 23
    Height = 22
    Hint = 'Pesquisar na Web'
    ImageIndex = 2
    Images = SisImgDataModule.ImageList16Flat
    OnClick = ConsultarWebSpeedButtonClick
  end
  object ErroLabel: TLabel
    Left = 189
    Top = 24
    Width = 49
    Height = 15
    Alignment = taRightJustify
    Caption = 'ErroLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 192
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Visible = False
    StyleElements = []
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
    MaxLength = 14
    NumbersOnly = True
    TabOrder = 0
    OnChange = LabeledEdit1Change
  end
end
