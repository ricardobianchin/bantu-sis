inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientHeight = 267
  ClientWidth = 427
  ExplicitWidth = 443
  ExplicitHeight = 306
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 195
    Width = 427
    ExplicitTop = 196
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 215
    Width = 427
    ExplicitTop = 216
  end
  inherited BasePanel: TPanel
    Top = 230
    Width = 427
    ExplicitTop = 230
    ExplicitWidth = 427
    DesignSize = (
      427
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 12
      ExplicitLeft = 12
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 125
      Width = 96
      ExplicitLeft = 125
      ExplicitWidth = 96
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 226
      Width = 96
      ExplicitLeft = 226
      ExplicitWidth = 96
    end
  end
end
