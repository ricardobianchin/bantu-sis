inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 439
  ExplicitWidth = 455
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 439
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 231
    Width = 439
    ExplicitTop = 232
  end
  inherited BasePanel: TPanel
    Top = 246
    Width = 439
    ExplicitTop = 246
    ExplicitWidth = 439
    DesignSize = (
      439
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 52
      ExplicitLeft = 60
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 165
      ExplicitLeft = 173
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 245
      ExplicitLeft = 253
    end
  end
end
