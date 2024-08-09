inherited PerfilDeUsoEdForm: TPerfilDeUsoEdForm
  Caption = 'PerfilDeUsoEdBasForm'
  ClientHeight = 319
  ClientWidth = 524
  ExplicitWidth = 540
  ExplicitHeight = 358
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 247
    Width = 524
    ExplicitTop = 247
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 267
    Width = 524
    ExplicitTop = 267
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
    Top = 282
    Width = 524
    ExplicitTop = 282
    ExplicitWidth = 524
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 121
      ExplicitLeft = 117
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 234
      ExplicitLeft = 230
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 314
      ExplicitLeft = 310
    end
  end
end
