inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 431
  ExplicitWidth = 443
  ExplicitHeight = 320
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 431
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 230
    Width = 431
    ExplicitTop = 230
  end
  inherited BasePanel: TPanel
    Top = 245
    Width = 431
    ExplicitTop = 246
    ExplicitWidth = 431
    DesignSize = (
      431
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 28
      ExplicitLeft = 36
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 141
      ExplicitLeft = 149
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 221
      ExplicitLeft = 229
    end
  end
end
