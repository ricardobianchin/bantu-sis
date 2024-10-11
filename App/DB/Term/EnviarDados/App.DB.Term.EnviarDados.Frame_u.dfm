inherited TermEnviarDadosFrame: TTermEnviarDadosFrame
  Height = 191
  ExplicitHeight = 191
  object StatusLabel: TLabel
    Left = 0
    Top = 124
    Width = 385
    Height = 15
    Align = alTop
    Caption = '    '
    WordWrap = True
    ExplicitWidth = 12
  end
  object AtualizarListaBitBtn: TBitBtn
    Left = 8
    Top = 161
    Width = 92
    Height = 25
    Action = AtualizarListaAction
    Anchors = [akLeft, akBottom]
    Caption = 'Atualizar Lista'
    TabOrder = 0
    ExplicitTop = 146
  end
  object TermCheckListBox: TCheckListBox
    Left = 0
    Top = 0
    Width = 385
    Height = 107
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 15
    TabOrder = 1
  end
  object TermEnviarDadosBitBtn: TBitBtn
    Left = 112
    Top = 161
    Width = 92
    Height = 25
    Action = TermEnviarDadosAction
    Anchors = [akLeft, akBottom]
    Caption = 'Enviar Dados'
    TabOrder = 2
    ExplicitTop = 146
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 107
    Width = 385
    Height = 17
    Align = alTop
    TabOrder = 3
    ExplicitLeft = 272
    ExplicitTop = 136
    ExplicitWidth = 150
  end
  object ActionList1: TActionList
    Left = 128
    Top = 40
    object AtualizarListaAction: TAction
      Caption = 'Atualizar Lista'
      OnExecute = AtualizarListaActionExecute
    end
    object TermEnviarDadosAction: TAction
      Caption = 'Enviar Dados'
      OnExecute = TermEnviarDadosActionExecute
    end
  end
end
