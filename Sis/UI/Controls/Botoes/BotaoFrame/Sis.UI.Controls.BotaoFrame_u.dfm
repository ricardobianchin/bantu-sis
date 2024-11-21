inherited BotaoFrame: TBotaoFrame
  Width = 110
  Height = 69
  Cursor = crHandPoint
  ParentColor = False
  ParentFont = False
  ExplicitWidth = 110
  ExplicitHeight = 69
  object FundoPanel: TPanel
    Left = 1
    Top = 1
    Width = 107
    Height = 67
    Caption = ' '
    TabOrder = 0
    object TitLabel: TLabel
      Left = 1
      Top = 41
      Width = 105
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Tit1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 40
      ExplicitWidth = 19
    end
    object Tit2Label: TLabel
      Left = 1
      Top = 54
      Width = 105
      Height = 12
      Align = alTop
      Alignment = taCenter
      Caption = 'Tit2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ExplicitTop = 53
      ExplicitWidth = 106
    end
    object IconPanel: TPanel
      Left = 1
      Top = 1
      Width = 105
      Height = 40
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 108
      object IconImage: TImage
        Left = 20
        Top = 0
        Width = 65
        Height = 40
        Center = True
      end
    end
  end
end
