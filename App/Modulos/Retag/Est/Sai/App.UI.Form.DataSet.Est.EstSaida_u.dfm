inherited AppEstSaidaDataSetForm: TAppEstSaidaDataSetForm
  Caption = 'AppEstSaidaDataSetForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    Top = 420
    Height = 23
    AutoSize = False
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
      inherited TitToolBar1_BasTabSheet: TToolBar
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 560
      end
    end
  end
  inherited DBGrid1: TDBGrid
    Height = 420
  end
  inherited SelectPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
end
