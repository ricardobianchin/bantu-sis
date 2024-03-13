inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 487
  ExplicitWidth = 499
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 487
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 243
    Width = 487
    ExplicitTop = 243
  end
  inherited BasePanel: TPanel
    Top = 258
    Width = 487
    ExplicitWidth = 487
    DesignSize = (
      487
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 124
      ExplicitLeft = 124
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 237
      ExplicitLeft = 237
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 317
      ExplicitLeft = 317
    end
  end
end
