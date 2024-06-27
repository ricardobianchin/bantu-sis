inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientHeight = 283
  ClientWidth = 435
  ExplicitWidth = 447
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 211
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
    Top = 231
    Width = 435
    ExplicitTop = 230
  end
  inherited BasePanel: TPanel
    Top = 246
    Width = 435
    ExplicitTop = 244
    ExplicitWidth = 431
    DesignSize = (
      435
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 44
      ExplicitLeft = 40
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 157
      ExplicitLeft = 153
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 237
      ExplicitLeft = 233
    end
  end
end
