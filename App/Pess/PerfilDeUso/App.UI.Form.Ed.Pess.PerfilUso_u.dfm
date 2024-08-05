inherited PerfilUsoEdForm: TPerfilUsoEdForm
  Caption = 'PerfilUsoEdBasForm'
  ClientHeight = 320
  ClientWidth = 528
  ExplicitWidth = 544
  ExplicitHeight = 359
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 248
    Width = 528
    ExplicitTop = 248
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 268
    Width = 528
    ExplicitTop = 268
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
    Top = 283
    Width = 528
    ExplicitTop = 282
    ExplicitWidth = 524
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 129
      ExplicitLeft = 125
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 242
      ExplicitLeft = 238
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 322
      ExplicitLeft = 318
    end
  end
end
