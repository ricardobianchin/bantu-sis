inherited AppEstDataSetForm: TAppEstDataSetForm
  Caption = 'AppEstDataSetForm'
  TextHeight = 15
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
  inherited ActionList1_ActBasForm: TActionList
    object CancAction_DatasetTabSheet: TAction
      Caption = 'Cancelar Nota'
      OnExecute = CancAction_DatasetTabSheetExecute
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
