inherited PerfilDeUsoEdForm: TPerfilDeUsoEdForm
  Caption = 'PerfilDeUsoEdBasForm'
  ClientHeight = 186
  ClientWidth = 512
  ExplicitWidth = 524
  ExplicitHeight = 224
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 114
    Width = 512
    ExplicitTop = 114
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 134
    Width = 512
    ExplicitTop = 134
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
    Top = 149
    Width = 512
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      TabOrder = 0
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      TabOrder = 1
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      TabOrder = 2
    end
  end
end
