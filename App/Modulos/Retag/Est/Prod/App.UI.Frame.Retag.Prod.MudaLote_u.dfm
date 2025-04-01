inherited MudaLoteFrame: TMudaLoteFrame
  Width = 608
  Height = 80
  ExplicitWidth = 608
  ExplicitHeight = 80
  object TipoLabel: TLabel
    Left = 8
    Top = 54
    Width = 23
    Height = 15
    Caption = 'Tipo'
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 295
    Height = 15
    Caption = 'Os produtos exibidos receber'#227'o as seguintes mudan'#231'as:'
  end
  object TipoComboBox: TComboBox
    Left = 38
    Top = 51
    Width = 155
    Height = 23
    TabOrder = 0
    Text = 'TipoComboBox'
  end
  object TitPanel: TPanel
    Left = 0
    Top = 0
    Width = 608
    Height = 27
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
    TabOrder = 1
    StyleElements = []
    DesignSize = (
      608
      27)
    object Label1: TLabel
      Left = 8
      Top = 3
      Width = 119
      Height = 20
      Caption = 'Mudan'#231'a em Lote'
    end
    object ToolBar1: TToolBar
      Left = 576
      Top = 6
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
end
