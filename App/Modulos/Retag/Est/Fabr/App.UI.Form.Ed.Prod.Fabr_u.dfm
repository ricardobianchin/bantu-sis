inherited ProdFabrEdForm: TProdFabrEdForm
  Caption = 'ProdFabrEdForm'
  ExplicitWidth = 503
  TextHeight = 15
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
    ExplicitTop = 260
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 148
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 261
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 341
    end
  end
end
