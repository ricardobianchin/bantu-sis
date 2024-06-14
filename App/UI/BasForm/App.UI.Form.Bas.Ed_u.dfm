inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 435
  ExplicitWidth = 451
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 435
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 229
    Width = 435
    ExplicitTop = 230
  end
  inherited BasePanel: TPanel
    Top = 244
    Width = 435
    ExplicitTop = 244
    ExplicitWidth = 435
    DesignSize = (
      435
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 44
      ExplicitLeft = 60
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 157
      ExplicitLeft = 173
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 237
      ExplicitLeft = 253
    end
  end
end
