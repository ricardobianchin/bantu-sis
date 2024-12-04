inherited ProdFabrEdForm: TProdFabrEdForm
  Caption = 'ProdFabrEdForm'
  ClientWidth = 483
  ExplicitWidth = 495
  ExplicitHeight = 305
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 210
    Width = 483
    ExplicitTop = 210
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 195
    Width = 483
    ExplicitTop = 195
  end
  object LabeledEdit1: TLabeledEdit [3]
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
    Width = 483
    ExplicitWidth = 483
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 8
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 121
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 222
    end
  end
end
