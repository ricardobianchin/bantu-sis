inherited EdDescrBasForm: TEdDescrBasForm
  Caption = 'EdDescrBasForm'
  ClientWidth = 499
  ExplicitHeight = 335
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 499
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
    Width = 499
    ExplicitWidth = 499
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 144
      ExplicitLeft = 140
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 257
      ExplicitLeft = 253
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 337
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
