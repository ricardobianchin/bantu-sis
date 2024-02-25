inherited ProdICMSEdForm: TProdICMSEdForm
  Caption = 'ProdICMSEdForm'
  TextHeight = 15
  inherited BasePanel: TPanel
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
