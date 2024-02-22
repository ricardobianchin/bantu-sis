inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientWidth = 491
  ExplicitWidth = 503
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 491
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited BasePanel: TPanel
    Width = 491
    ExplicitWidth = 491
    DesignSize = (
      491
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 136
      ExplicitLeft = 140
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 249
      ExplicitLeft = 253
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 329
      ExplicitLeft = 333
    end
  end
end
