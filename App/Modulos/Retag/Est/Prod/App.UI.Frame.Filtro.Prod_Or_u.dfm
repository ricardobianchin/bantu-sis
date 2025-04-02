inherited ProdOrFiltroFrame: TProdOrFiltroFrame
  Width = 700
  Height = 48
  ExplicitWidth = 700
  ExplicitHeight = 48
  object FundoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 700
    Height = 48
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitHeight = 39
    object ErroLabel: TLabel
      Left = 0
      Top = 23
      Width = 6
      Height = 15
      Caption = '  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 192
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
    object FiltroStringLabeledEdit: TLabeledEdit
      Left = 59
      Top = 21
      Width = 121
      Height = 23
      EditLabel.Width = 51
      EditLabel.Height = 23
      EditLabel.Caption = 'Filtrar por'
      LabelPosition = lpLeft
      LabelSpacing = 5
      MaxLength = 120
      TabOrder = 0
      Text = ''
      OnChange = FiltroStringLabeledEditChange
      OnKeyPress = FiltroStringLabeledEditKeyPress
    end
    object CodRadioButton: TRadioButton
      Left = 195
      Top = 24
      Width = 74
      Height = 17
      Caption = 'C'#243'digo'
      TabOrder = 1
    end
    object BarrasRadioButton: TRadioButton
      Left = 266
      Top = 24
      Width = 86
      Height = 17
      Caption = 'C'#243'd. Barras'
      TabOrder = 2
    end
    object DescrRadioButton: TRadioButton
      Left = 360
      Top = 24
      Width = 77
      Height = 17
      Caption = 'Descri'#231#227'o'
      Checked = True
      TabOrder = 3
      TabStop = True
    end
    object FabrRadioButton: TRadioButton
      Left = 450
      Top = 24
      Width = 85
      Height = 17
      Caption = 'Fabricante'
      TabOrder = 4
    end
    object TipoRadioButton: TRadioButton
      Left = 542
      Top = 24
      Width = 62
      Height = 17
      Caption = 'Tipo'
      TabOrder = 5
    end
    object TitPanel: TPanel
      Left = 0
      Top = 0
      Width = 700
      Height = 18
      Align = alTop
      BevelOuter = bvNone
      Caption = '  '
      Color = 13023391
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 6
      StyleElements = []
      DesignSize = (
        700
        18)
      object TitLabel: TLabel
        Left = 8
        Top = -1
        Width = 29
        Height = 17
        Caption = 'Filtro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object ToolBar1: TToolBar
        Left = 629
        Top = 2
        Width = 42
        Height = 14
        Align = alNone
        Anchors = [akTop, akRight]
        ButtonHeight = 14
        ButtonWidth = 20
        Caption = 'ToolBar1'
        Images = SisImgDataModule.ImageList_13_8_Preto
        TabOrder = 0
        Transparent = True
        Visible = False
        StyleElements = []
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Hint = 'Ocultar'
          Caption = 'ToolButton1'
          ImageIndex = 0
        end
      end
    end
  end
  inherited AgendeChangeTimer: TTimer
    Left = 127
    Top = 19
  end
end
