inherited ProdICMSEdForm: TProdICMSEdForm
  Caption = 'ProdICMSEdForm'
  ClientWidth = 487
  ExplicitWidth = 499
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 487
    ExplicitTop = 239
  end
  inherited BasePanel: TPanel
    Width = 487
    ExplicitWidth = 487
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 112
      ExplicitLeft = 108
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 225
      ExplicitLeft = 221
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 305
      ExplicitLeft = 301
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
