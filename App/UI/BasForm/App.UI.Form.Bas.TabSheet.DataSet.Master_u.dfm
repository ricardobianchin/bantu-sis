inherited TabSheetDataSetMasterBasForm: TTabSheetDataSetMasterBasForm
  Caption = 'TabSheetDataSetMasterBasForm'
  StyleElements = [seFont, seClient, seBorder]
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
  end
  inherited ActionList1_ActBasForm: TActionList
    object CancAction_DatasetTabSheet: TAction
      Caption = 'Cancelar'
    end
    object InsItemAction_DatasetTabSheet: TAction
      Caption = 'Inserir Item'
    end
    object AltItemAction_DatasetTabSheet: TAction
      Caption = 'Alterar Item'
    end
    object CancItemAction_DatasetTabSheet: TAction
      Caption = 'Cancelar Item'
    end
  end
  object DetailTimer: TTimer
    Enabled = False
    Interval = 250
    OnTimer = DetailTimerTimer
    Left = 432
    Top = 24
  end
end
