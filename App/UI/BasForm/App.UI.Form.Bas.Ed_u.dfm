inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 455
  ExplicitWidth = 471
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 455
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 235
    Width = 455
    ExplicitTop = 236
  end
  inherited BasePanel: TPanel
    Top = 250
    Width = 455
    ExplicitTop = 251
    ExplicitWidth = 459
    DesignSize = (
      455
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 80
      ExplicitLeft = 84
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 193
      ExplicitLeft = 197
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 273
      ExplicitLeft = 277
    end
  end
end
