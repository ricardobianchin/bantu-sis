inherited EstFiltroFrame: TEstFiltroFrame
  Width = 800
  Height = 66
  ExplicitWidth = 800
  ExplicitHeight = 66
  object FundoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 800
    Height = 66
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitHeight = 86
    DesignSize = (
      800
      66)
    object ErroLabel: TLabel
      Left = 8
      Top = 52
      Width = 172
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Erro no filtro. Data Inicial inv'#225'lida'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 192
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
      ExplicitTop = 59
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
      TabOrder = 0
      StyleElements = []
      DesignSize = (
        800
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
      object TitToolBar: TToolBar
        Left = 780
        Top = 2
        Width = 42
        Height = 14
        Align = alNone
        Anchors = [akTop, akRight]
        ButtonHeight = 14
        ButtonWidth = 20
        Caption = 'TitToolBar'
        Images = SisImgDataModule.ImageList_13_8_Preto
        TabOrder = 0
        Transparent = True
        Visible = False
        StyleElements = []
        object TitFecharToolButton: TToolButton
          Left = 0
          Top = 0
          Hint = 'Ocultar'
          Caption = 'TitFecharToolButton'
          ImageIndex = 0
        end
      end
    end
  end
  inherited AgendeChangeTimer: TTimer
    Left = 376
    Top = 65534
  end
end
