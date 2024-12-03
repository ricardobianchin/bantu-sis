inherited ProdICMSEdForm: TProdICMSEdForm
  Caption = 'ProdICMSEdForm'
  ExplicitWidth = 443
  ExplicitHeight = 306
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
    ExplicitTop = 230
    ExplicitWidth = 427
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 108
      ExplicitLeft = 104
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 221
      ExplicitLeft = 217
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 301
      ExplicitLeft = 297
    end
  end
end
