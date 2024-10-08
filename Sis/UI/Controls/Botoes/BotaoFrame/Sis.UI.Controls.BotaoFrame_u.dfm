inherited BotaoFrame: TBotaoFrame
  Width = 110
  Height = 140
  Cursor = crHandPoint
  ParentColor = False
  ParentFont = False
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
      Caption = 'Tit1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 19
    end
    object Tit2Label: TLabel
      Left = 0
      Top = 102
      Width = 108
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
      ExplicitWidth = 15
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
