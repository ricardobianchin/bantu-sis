inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 431
  ExplicitWidth = 443
  ExplicitHeight = 319
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 431
    ExplicitTop = 209
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
    Width = 431
    ExplicitTop = 229
  end
  inherited BasePanel: TPanel
    Top = 244
    Width = 431
    ExplicitTop = 245
    ExplicitWidth = 431
    DesignSize = (
      431
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 24
      ExplicitLeft = 36
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 137
      ExplicitLeft = 149
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 217
      ExplicitLeft = 229
    end
  end
end
