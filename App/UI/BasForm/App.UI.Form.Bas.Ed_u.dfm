inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 479
  ExplicitWidth = 495
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 479
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 241
    Width = 479
    ExplicitTop = 242
  end
  inherited BasePanel: TPanel
    Top = 256
    Width = 479
    ExplicitTop = 257
    ExplicitWidth = 483
    DesignSize = (
      479
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 116
      ExplicitLeft = 124
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 229
      ExplicitLeft = 237
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 309
      ExplicitLeft = 317
    end
  end
end
