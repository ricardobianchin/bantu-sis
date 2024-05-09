inherited ImportBarEdForm: TImportBarEdForm
  Caption = 'ImportBarEdForm'
  TextHeight = 15
  inherited MensLabel: TLabel
    ExplicitTop = 127
  end
  inherited AlteracaoTextoLabel: TLabel
    ExplicitTop = 184
  end
  object Label1: TLabel [2]
    Left = 272
    Top = 24
    Width = 68
    Height = 15
    Caption = 'Gerar codigo'
    OnClick = Label1Click
  end
  inherited BasePanel: TPanel
    ExplicitTop = 146
    ExplicitWidth = 435
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 96
      ExplicitLeft = 92
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 209
      ExplicitLeft = 205
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 289
      ExplicitLeft = 285
    end
  end
  inherited LabeledEdit1: TLabeledEdit
    EditLabel.Width = 90
    EditLabel.Caption = 'C'#243'digo de Barras'
    EditLabel.ExplicitWidth = 90
  end
end
