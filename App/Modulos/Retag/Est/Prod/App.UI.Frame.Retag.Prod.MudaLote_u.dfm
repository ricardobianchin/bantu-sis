inherited MudaLoteFrame: TMudaLoteFrame
  Width = 800
  Height = 69
  Visible = False
  ExplicitWidth = 800
  ExplicitHeight = 69
  object TipoLabel: TLabel
    Left = 229
    Top = 43
    Width = 23
    Height = 15
    Alignment = taRightJustify
    Caption = 'Tipo'
  end
  object SubTituloLabel: TLabel
    Left = 5
    Top = 20
    Width = 295
    Height = 15
    Caption = 'Os produtos exibidos receber'#227'o as seguintes mudan'#231'as:'
  end
  object FabrLabel: TLabel
    Left = 5
    Top = 42
    Width = 55
    Height = 15
    Alignment = taRightJustify
    Caption = 'Fabricante'
  end
  object StatusLabel: TLabel
    Left = 481
    Top = 43
    Width = 71
    Height = 15
    Caption = 'Executando...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Visible = False
    StyleElements = [seClient, seBorder]
  end
  object TipoComboBox: TComboBox
    Left = 257
    Top = 40
    Width = 155
    Height = 23
    TabOrder = 1
    Text = 'TipoComboBox'
    OnChange = FabrComboBoxChange
  end
  object TitPanel: TPanel
    Left = 0
    Top = 0
    Width = 800
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
    TabOrder = 2
    StyleElements = []
    DesignSize = (
      800
      18)
    object TitLabel: TLabel
      Left = 8
      Top = -1
      Width = 105
      Height = 17
      Caption = 'Mudan'#231'a em Lote'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object ToolBar1: TToolBar
      Left = 777
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
      StyleElements = []
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Hint = 'Ocultar'
        Caption = 'ToolButton1'
        ImageIndex = 0
        OnClick = ToolButton1Click
      end
    end
  end
  object FabrComboBox: TComboBox
    Left = 66
    Top = 40
    Width = 155
    Height = 23
    TabOrder = 0
    Text = 'TipoComboBox'
    OnChange = FabrComboBoxChange
  end
  object ToolBar2: TToolBar
    Left = 418
    Top = 41
    Width = 59
    Height = 21
    Align = alNone
    ButtonHeight = 21
    ButtonWidth = 57
    Caption = 'ToolBar2'
    List = True
    ShowCaptions = True
    TabOrder = 3
    object ExecutarToolButton: TToolButton
      Left = 0
      Top = 0
      Caption = 'Executar'
      ImageIndex = 0
      OnClick = ExecutarToolButtonClick
    end
  end
  object ProgressBar1: TProgressBar
    Left = 561
    Top = 43
    Width = 100
    Height = 17
    TabOrder = 4
    Visible = False
  end
end
