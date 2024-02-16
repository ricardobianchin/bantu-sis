inherited EdDescrBasForm: TEdDescrBasForm
  Caption = 'EdDescrBasForm'
  ClientHeight = 298
  ClientWidth = 503
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 241
    Width = 503
  end
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
    Top = 261
    Width = 503
    ExplicitTop = 260
    ExplicitWidth = 499
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 160
      ExplicitLeft = 156
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 273
      ExplicitLeft = 269
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 353
      ExplicitLeft = 349
    end
  end
end
