inherited EdDescrBasForm: TEdDescrBasForm
  Caption = 'EdDescrBasForm'
  ExplicitWidth = 519
  ExplicitHeight = 336
  TextHeight = 15
  inherited BasePanel: TPanel
    ExplicitTop = 260
    ExplicitWidth = 503
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 168
      ExplicitLeft = 164
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 281
      ExplicitLeft = 277
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 361
      ExplicitLeft = 357
    end
  end
  object LabeledEdit1: TLabeledEdit [2]
    Left = 16
    Top = 24
    Width = 260
    Height = 23
    EditLabel.Width = 67
    EditLabel.Height = 15
    EditLabel.Caption = 'LabeledEdit1'
    TabOrder = 1
    Text = ''
  end
end
