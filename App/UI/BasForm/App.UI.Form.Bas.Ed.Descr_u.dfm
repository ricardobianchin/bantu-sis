inherited EdDescrBasForm: TEdDescrBasForm
  Caption = 'EdDescrBasForm'
  ExplicitHeight = 335
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
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 140
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 253
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 333
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 80
    Top = 80
  end
  inherited ActionList1_Diag: TActionList
    Left = 232
    Top = 80
  end
end
