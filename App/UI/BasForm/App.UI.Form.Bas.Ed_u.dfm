inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 459
  ExplicitWidth = 475
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 459
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 236
    Width = 459
    ExplicitTop = 237
  end
  inherited BasePanel: TPanel
    Top = 251
    Width = 459
    ExplicitTop = 252
    ExplicitWidth = 463
    DesignSize = (
      459
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 84
      ExplicitLeft = 84
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 197
      ExplicitLeft = 197
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 277
      ExplicitLeft = 277
    end
  end
end
