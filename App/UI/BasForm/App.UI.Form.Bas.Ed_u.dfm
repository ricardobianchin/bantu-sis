inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 483
  ExplicitWidth = 499
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 483
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 242
    Width = 483
    ExplicitTop = 243
  end
  inherited BasePanel: TPanel
    Top = 257
    Width = 483
    ExplicitTop = 258
    ExplicitWidth = 487
    DesignSize = (
      483
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 120
      ExplicitLeft = 124
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 233
      ExplicitLeft = 237
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 313
      ExplicitLeft = 317
    end
  end
end
