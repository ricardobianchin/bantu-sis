inherited AppEstDataSetForm: TAppEstDataSetForm
  Caption = 'AppEstDataSetForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited TitAuxPanel_BasTabSheet: TPanel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited TitToolPanel_BasTabSheet: TPanel
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited DBGrid1: TDBGrid
    Height = 193
  end
  object DetailPanel: TPanel [2]
    Left = 0
    Top = 193
    Width = 700
    Height = 220
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 3
    ExplicitLeft = -8
    ExplicitTop = 199
  end
  inherited SelectPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
end
