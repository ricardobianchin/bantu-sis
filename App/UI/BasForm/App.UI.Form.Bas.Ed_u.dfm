inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 471
  ExplicitWidth = 487
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 471
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 239
    Width = 471
    ExplicitTop = 240
  end
  inherited BasePanel: TPanel
    Top = 254
    Width = 471
    ExplicitTop = 255
    ExplicitWidth = 475
    DesignSize = (
      471
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 100
      ExplicitLeft = 124
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 213
      ExplicitLeft = 237
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 293
      ExplicitLeft = 317
    end
  end
end
