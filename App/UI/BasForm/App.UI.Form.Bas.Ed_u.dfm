inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientHeight = 282
  ClientWidth = 431
  ExplicitWidth = 447
  ExplicitHeight = 321
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 210
    Width = 431
    ExplicitTop = 210
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
    ExplicitTop = 245
    ExplicitWidth = 431
    DesignSize = (
      431
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 20
      ExplicitLeft = 36
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 133
      ExplicitLeft = 149
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 213
      ExplicitLeft = 229
    end
  end
end
