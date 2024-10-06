inherited BotaoModuloFrame: TBotaoModuloFrame
  Width = 110
  Height = 140
  Cursor = crHandPoint
  ParentColor = False
  ExplicitWidth = 110
  ExplicitHeight = 140
  object FundoPanel: TPanel
    Left = 1
    Top = 1
    Width = 108
    Height = 137
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object TitLabel: TLabel
      Left = 0
      Top = 89
      Width = 108
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'F5 - Configura'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 1
      ExplicitTop = 90
      ExplicitWidth = 97
    end
    object ApelidoLabel: TLabel
      Left = 0
      Top = 102
      Width = 108
      Height = 12
      Align = alTop
      Alignment = taCenter
      Caption = 'F5 - Configura'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ExplicitLeft = 1
      ExplicitTop = 103
      ExplicitWidth = 74
    end
    object IconPanel: TPanel
      Left = 0
      Top = 0
      Width = 108
      Height = 89
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 106
      object IconImage: TImage
        Left = 9
        Top = 0
        Width = 89
        Height = 89
        Center = True
      end
    end
  end
end
