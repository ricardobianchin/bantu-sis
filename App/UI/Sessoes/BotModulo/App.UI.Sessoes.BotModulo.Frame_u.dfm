inherited BotaoModuloFrame: TBotaoModuloFrame
  Width = 110
  Height = 130
  ParentColor = False
  ExplicitWidth = 110
  ExplicitHeight = 130
  object FundoPanel: TPanel
    Left = 1
    Top = 1
    Width = 108
    Height = 128
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
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = -10
      ExplicitTop = 108
    end
    object ApelidoLabel: TLabel
      Left = 0
      Top = 102
      Width = 108
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'F5 - Configura'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = -10
      ExplicitTop = 121
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
      ExplicitWidth = 185
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
