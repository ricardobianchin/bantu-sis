inherited EdDescrBasForm: TEdDescrBasForm
  Caption = 'EdDescrBasForm'
  TextHeight = 15
  object LabeledEdit1: TLabeledEdit [2]
    Left = 8
    Top = 48
    Width = 260
    Height = 23
    EditLabel.Width = 67
    EditLabel.Height = 15
    EditLabel.Caption = 'LabeledEdit1'
    TabOrder = 1
    Text = ''
    OnChange = LabeledEdit1Change
    OnKeyPress = LabeledEdit1KeyPress
  end
  inherited BasePanel: TPanel
    ExplicitTop = 260
    ExplicitWidth = 499
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 156
      ExplicitLeft = 152
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 269
      ExplicitLeft = 265
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 349
      ExplicitLeft = 345
    end
  end
end
