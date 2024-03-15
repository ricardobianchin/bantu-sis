inherited ProdICMSEdForm: TProdICMSEdForm
  Caption = 'ProdICMSEdForm'
  TextHeight = 15
  object AtivoCheckBox: TCheckBox [3]
    Left = 232
    Top = 24
    Width = 97
    Height = 17
    Caption = 'Ativo'
    TabOrder = 1
    OnKeyPress = AtivoCheckBoxKeyPress
  end
  inherited BasePanel: TPanel
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
end
