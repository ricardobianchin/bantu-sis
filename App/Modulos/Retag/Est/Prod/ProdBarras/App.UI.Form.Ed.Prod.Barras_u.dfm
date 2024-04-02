inherited ProdBarrasEdForm: TProdBarrasEdForm
  Caption = 'ProdBarrasEdForm'
  ClientHeight = 178
  ClientWidth = 356
  OnDestroy = FormDestroy
  ExplicitWidth = 368
  ExplicitHeight = 216
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 106
    Width = 356
    ExplicitTop = 106
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 163
    Width = 356
    ExplicitTop = 163
  end
  object LabeledEdit1: TLabeledEdit [2]
    Left = 11
    Top = 22
    Width = 105
    Height = 23
    EditLabel.Width = 90
    EditLabel.Height = 15
    EditLabel.Caption = 'C'#243'digo de Barras'
    MaxLength = 14
    NumbersOnly = True
    TabOrder = 0
    Text = ''
    OnChange = LabeledEdit1Change
    OnKeyPress = LabeledEdit1KeyPress
  end
  inherited BasePanel: TPanel
    Top = 126
    Width = 356
    TabOrder = 1
    ExplicitTop = 125
    ExplicitWidth = 352
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 5
      ExplicitLeft = 1
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 118
      ExplicitLeft = 114
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 198
      ExplicitLeft = 194
    end
  end
end
