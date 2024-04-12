inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 443
  ExplicitWidth = 455
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 443
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 232
    Width = 443
    ExplicitTop = 232
  end
  inherited BasePanel: TPanel
    Top = 247
    Width = 443
    ExplicitTop = 246
    ExplicitWidth = 439
    DesignSize = (
      443
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 60
      ExplicitLeft = 60
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 173
      ExplicitLeft = 173
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 253
      ExplicitLeft = 253
    end
  end
end
