inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 443
  ExplicitWidth = 459
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
    ExplicitTop = 233
  end
  inherited BasePanel: TPanel
    Top = 247
    Width = 443
    ExplicitTop = 247
    ExplicitWidth = 443
    DesignSize = (
      443
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 64
      ExplicitLeft = 84
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 177
      ExplicitLeft = 197
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 257
      ExplicitLeft = 277
    end
  end
end
