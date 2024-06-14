inherited PessLojaEdForm: TPessLojaEdForm
  Caption = 'PessLojaEdForm'
  ClientWidth = 435
  ExplicitWidth = 447
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 435
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 435
  end
  inherited BasePanel: TPanel
    Width = 435
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 36
      ExplicitLeft = 32
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 149
      ExplicitLeft = 145
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 229
      ExplicitLeft = 225
    end
  end
  object AtivoCheckBox: TCheckBox [6]
    Left = 280
    Top = 104
    Width = 97
    Height = 17
    Caption = 'Ativo'
    TabOrder = 2
    OnKeyPress = AtivoCheckBoxKeyPress
  end
end
