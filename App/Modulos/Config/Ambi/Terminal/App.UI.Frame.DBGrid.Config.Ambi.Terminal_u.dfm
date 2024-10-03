inherited TerminaisDBGridFrame: TTerminaisDBGridFrame
  inherited DBGrid1: TDBGrid
    Height = 174
  end
  object ToolBar1: TToolBar [1]
    Left = 0
    Top = 243
    Width = 542
    Height = 29
    Align = alBottom
    ButtonHeight = 21
    ButtonWidth = 47
    Caption = 'ToolBar1'
    List = True
    ShowCaptions = True
    TabOrder = 1
    object InsToolButton: TToolButton
      Left = 0
      Top = 0
      Action = InsAction
    end
    object AltToolButton: TToolButton
      Left = 47
      Top = 0
      Action = AltAction
    end
    object ExclToolButton: TToolButton
      Left = 94
      Top = 0
      Action = ExclAction
    end
  end
  object ActionList1: TActionList
    Left = 400
    Top = 104
    object InsAction: TAction
      Caption = 'Novo'
      OnExecute = InsActionExecute
    end
    object AltAction: TAction
      Caption = 'Alterar'
    end
    object ExclAction: TAction
      Caption = 'Excluir'
    end
  end
end
