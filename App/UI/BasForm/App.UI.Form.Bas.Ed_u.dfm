inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 463
  ExplicitWidth = 475
  ExplicitHeight = 327
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
    ExplicitTop = 237
  end
  inherited BasePanel: TPanel
    Top = 252
    Width = 463
    ExplicitTop = 251
    ExplicitWidth = 459
    DesignSize = (
      463
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 88
      ExplicitLeft = 84
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 201
      ExplicitLeft = 197
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 281
      ExplicitLeft = 277
    end
  end
end
