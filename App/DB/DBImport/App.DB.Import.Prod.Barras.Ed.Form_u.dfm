inherited ImportBarEdForm: TImportBarEdForm
  Caption = 'ImportBarEdForm'
  ClientHeight = 199
  ClientWidth = 439
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 127
    Width = 439
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 184
    Width = 439
  end
  object Label1: TLabel [2]
    Left = 272
    Top = 24
    Width = 68
    Height = 15
    Caption = 'Gerar codigo'
    OnClick = Label1Click
  end
  inherited LabeledEdit1: TLabeledEdit
    EditLabel.Width = 90
    EditLabel.Caption = 'C'#243'digo de Barras'
    EditLabel.ExplicitWidth = 90
  end
  inherited BasePanel: TPanel
    Top = 147
    Width = 439
    ExplicitTop = 146
    ExplicitWidth = 435
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 92
      ExplicitLeft = 88
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 205
      ExplicitLeft = 201
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 285
      ExplicitLeft = 281
    end
  end
end
