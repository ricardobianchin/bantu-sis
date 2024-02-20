inherited EdUnidForm: TEdUnidForm
  Caption = 'EdUnidForm'
  TextHeight = 15
  inherited BasePanel: TPanel
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 148
      ExplicitLeft = 144
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 261
      ExplicitLeft = 257
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 341
      ExplicitLeft = 337
    end
  end
  object SiglaLabeledEdit: TLabeledEdit [4]
    Left = 8
    Top = 96
    Width = 89
    Height = 23
    EditLabel.Width = 25
    EditLabel.Height = 15
    EditLabel.Caption = 'Sigla'
    MaxLength = 6
    TabOrder = 2
    Text = ''
    OnChange = LabeledEdit1Change
    OnKeyPress = LabeledEdit1KeyPress
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 136
    Top = 32
  end
  inherited ActionList1_Diag: TActionList
    Top = 24
  end
end
