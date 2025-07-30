inherited AppEstSaidaDataSetForm: TAppEstSaidaDataSetForm
  Caption = 'AppEstSaidaDataSetForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    Top = 420
    Height = 23
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 420
    ExplicitHeight = 23
    inherited TitAuxPanel_BasTabSheet: TPanel
      Height = 23
      StyleElements = [seFont, seClient, seBorder]
      ExplicitHeight = 23
      inherited QtdRegsLabel_TabSheetDataSetBasForm: TLabel
        Top = 5
        ExplicitTop = 5
      end
    end
    inherited TitToolPanel_BasTabSheet: TPanel
      Height = 23
      StyleElements = [seFont, seClient, seBorder]
      ExplicitHeight = 23
    end
  end
  inherited DBGrid1: TDBGrid
    Height = 200
  end
  inherited DetailPanel: TPanel
    Top = 200
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 200
  end
  inherited SelectPanel: TPanel
    Left = 544
    Top = 160
    StyleElements = [seFont, seClient, seBorder]
    ExplicitLeft = 544
    ExplicitTop = 160
  end
end
