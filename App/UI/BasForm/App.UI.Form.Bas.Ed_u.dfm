inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 467
  ExplicitWidth = 483
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 467
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 238
    Width = 467
    ExplicitTop = 239
  end
  inherited BasePanel: TPanel
    Top = 253
    Width = 467
    ExplicitTop = 254
    ExplicitWidth = 471
    DesignSize = (
      467
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 96
      ExplicitLeft = 124
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 209
      ExplicitLeft = 237
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 289
      ExplicitLeft = 317
    end
  end
end
