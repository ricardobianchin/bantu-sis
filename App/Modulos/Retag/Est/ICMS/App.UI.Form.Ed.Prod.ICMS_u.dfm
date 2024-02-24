inherited ProdICMSEdForm: TProdICMSEdForm
  Caption = 'ProdICMSEdForm'
  ClientHeight = 297
  ExplicitWidth = 499
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 240
    ExplicitTop = 239
  end
  inherited BasePanel: TPanel
    Top = 260
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 116
      ExplicitLeft = 116
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 229
      ExplicitLeft = 229
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 309
      ExplicitLeft = 309
    end
  end
  object AtivoCheckBox: TCheckBox [3]
    Left = 232
    Top = 24
    Width = 97
    Height = 17
    Caption = 'Ativo'
    TabOrder = 1
    OnKeyPress = AtivoCheckBoxKeyPress
  end
end
