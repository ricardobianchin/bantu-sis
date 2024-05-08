inherited InputStrForm: TInputStrForm
  Caption = 'InputStrForm'
  ClientHeight = 199
  ClientWidth = 439
  ExplicitWidth = 451
  ExplicitHeight = 237
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 127
    Width = 439
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 184
    Width = 439
  end
  inherited BasePanel: TPanel
    Top = 147
    Width = 439
    TabOrder = 1
    ExplicitTop = 230
    ExplicitWidth = 443
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 104
      ExplicitLeft = 108
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 217
      ExplicitLeft = 221
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 297
      ExplicitLeft = 301
    end
  end
  object LabeledEdit1: TLabeledEdit [3]
    Left = 8
    Top = 24
    Width = 257
    Height = 23
    EditLabel.Width = 67
    EditLabel.Height = 15
    EditLabel.Caption = 'LabeledEdit1'
    TabOrder = 0
    Text = ''
  end
end
