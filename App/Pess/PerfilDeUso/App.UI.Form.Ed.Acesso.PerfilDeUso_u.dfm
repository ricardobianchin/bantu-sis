inherited PerfilDeUsoEdForm: TPerfilDeUsoEdForm
  Caption = 'PerfilDeUsoEdBasForm'
  ClientHeight = 187
  ClientWidth = 516
  ExplicitWidth = 532
  ExplicitHeight = 226
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 115
    Width = 516
    ExplicitTop = 116
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 135
    Width = 516
    ExplicitTop = 136
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
    Top = 150
    Width = 516
    ExplicitTop = 280
    ExplicitWidth = 516
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 113
      ExplicitLeft = 109
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 226
      ExplicitLeft = 222
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 306
      ExplicitLeft = 302
    end
  end
end
