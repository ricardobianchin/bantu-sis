inherited BotaoModuloFrame: TBotaoModuloFrame
  Height = 140
  ExplicitHeight = 140
  inherited FundoPanel: TPanel
    Height = 137
    BevelOuter = bvNone
    StyleElements = [seFont, seClient, seBorder]
    ExplicitHeight = 137
    inherited TitLabel: TLabel
      Left = 0
      Top = 89
      Width = 107
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 0
      ExplicitTop = 89
    end
    inherited Tit2Label: TLabel
      Left = 0
      Top = 102
      Width = 107
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 0
      ExplicitTop = 102
    end
    inherited IconPanel: TPanel
      Left = 0
      Top = 0
      Width = 107
      Height = 89
      StyleElements = [seFont, seClient, seBorder]
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 107
      ExplicitHeight = 89
      inherited IconImage: TImage
        Left = 10
        Width = 89
        Height = 89
        ExplicitLeft = 10
        ExplicitWidth = 89
        ExplicitHeight = 89
      end
    end
  end
end
