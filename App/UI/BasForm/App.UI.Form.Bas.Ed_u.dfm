inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientHeight = 268
  ClientWidth = 431
  ExplicitWidth = 443
  ExplicitHeight = 306
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 196
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
    Top = 216
    Width = 431
    ExplicitTop = 230
  end
  inherited BasePanel: TPanel
    Top = 231
    Width = 431
    ExplicitTop = 244
    ExplicitWidth = 427
    DesignSize = (
      431
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 16
      ExplicitLeft = 12
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 129
      Width = 96
      ExplicitLeft = 129
      ExplicitWidth = 96
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 230
      Width = 96
      ExplicitLeft = 230
      ExplicitWidth = 96
    end
  end
end
