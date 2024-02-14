inherited ProdFabrEdForm: TProdFabrEdForm
  Caption = 'ProdFabrEdForm'
  ClientHeight = 298
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 241
    ExplicitTop = 241
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited LabeledEdit1: TLabeledEdit
    Left = 8
    Top = 49
    EditLabel.ExplicitLeft = 8
    EditLabel.ExplicitTop = 31
    OnChange = LabeledEdit1Change
    OnKeyPress = LabeledEdit1KeyPress
    ExplicitLeft = 8
    ExplicitTop = 49
  end
  inherited BasePanel: TPanel
    Top = 261
    ExplicitTop = 261
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 164
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 277
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 357
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 40
    Top = 80
  end
  inherited ActionList1_Diag: TActionList
    Left = 144
    Top = 104
  end
end
