inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 447
  ExplicitWidth = 463
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 447
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 233
    Width = 447
    ExplicitTop = 234
  end
  inherited BasePanel: TPanel
    Top = 248
    Width = 447
    ExplicitTop = 249
    ExplicitWidth = 451
    DesignSize = (
      447
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 72
      ExplicitLeft = 84
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 185
      ExplicitLeft = 197
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 265
      ExplicitLeft = 277
    end
  end
end
