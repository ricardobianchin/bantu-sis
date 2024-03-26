inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 463
  ExplicitWidth = 479
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 463
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 237
    Width = 463
    ExplicitTop = 238
  end
  inherited BasePanel: TPanel
    Top = 252
    Width = 463
    ExplicitTop = 253
    ExplicitWidth = 467
    DesignSize = (
      463
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 92
      ExplicitLeft = 124
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 205
      ExplicitLeft = 237
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 285
      ExplicitLeft = 317
    end
  end
end
