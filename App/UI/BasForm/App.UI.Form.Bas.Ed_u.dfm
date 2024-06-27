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
    ExplicitTop = 211
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
    ExplicitTop = 231
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
      Left = 36
      ExplicitLeft = 40
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 149
      ExplicitLeft = 153
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 229
      ExplicitLeft = 233
    end
  end
end
