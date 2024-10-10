inherited TermCargaFrameFrame: TTermCargaFrameFrame
  object AtualizarListaBitBtn: TBitBtn
    Left = 8
    Top = 146
    Width = 92
    Height = 25
    Action = AtualizarListaAction
    Anchors = [akLeft, akBottom]
    Caption = 'Atualizar Lista'
    TabOrder = 0
  end
  object TermCheckListBox: TCheckListBox
    Left = 0
    Top = 0
    Width = 385
    Height = 125
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 15
    TabOrder = 1
  end
  object TermCargaBitBtn: TBitBtn
    Left = 112
    Top = 146
    Width = 92
    Height = 25
    Action = TermCargaAction
    Anchors = [akLeft, akBottom]
    Caption = 'Enviar Dados'
    TabOrder = 2
  end
  object ActionList1: TActionList
    Left = 128
    Top = 40
    object AtualizarListaAction: TAction
      Caption = 'Atualizar Lista'
      OnExecute = AtualizarListaActionExecute
    end
    object TermCargaAction: TAction
      Caption = 'Enviar Dados'
    end
  end
end
