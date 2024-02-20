inherited ProdFabrEdForm: TProdFabrEdForm
  Caption = 'ProdFabrEdForm'
  ClientHeight = 298
  ClientWidth = 499
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 241
    Width = 499
    ExplicitTop = 241
  end
  object LabeledEdit1: TLabeledEdit [2]
    Left = 8
    Top = 48
    Width = 260
    Height = 23
    EditLabel.Width = 67
    EditLabel.Height = 15
    EditLabel.Caption = 'LabeledEdit1'
    MaxLength = 20
    TabOrder = 1
    Text = ''
    OnChange = LabeledEdit1Change
    OnKeyPress = LabeledEdit1KeyPress
  end
  inherited BasePanel: TPanel
    Top = 261
    Width = 499
    ExplicitTop = 261
    ExplicitWidth = 499
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 152
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 265
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 345
    end
  end
end
