inherited TabSheetDataSetMasterBasForm: TTabSheetDataSetMasterBasForm
  Caption = 'TabSheetDataSetMasterBasForm'
  StyleElements = [seFont, seClient, seBorder]
  ExplicitTop = -37
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited TitAuxPanel_BasTabSheet: TPanel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited TitToolPanel_BasTabSheet: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited TitToolBar1_BasTabSheet: TToolBar
        Height = 30
        ButtonHeight = 30
        ExplicitHeight = 30
      end
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
  end
  inherited SelectPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited ToolBar1: TToolBar
      ExplicitTop = -8
    end
  end
end
