inherited DBSelectForm: TDBSelectForm
  Caption = 'DBSelectForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited AlteracaoTextoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited FundoPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited BasePanel: TPanel
      Top = 296
      Height = 15
      AutoSize = True
      StyleElements = [seClient, seBorder]
      ExplicitTop = 296
      ExplicitHeight = 15
      inherited QtdRegsLabel: TLabel
        Top = 0
        StyleElements = [seFont, seClient, seBorder]
        ExplicitTop = 0
      end
    end
  end
end
