inherited EdBasForm: TEdBasForm
  Caption = 'EdBasForm'
  ClientHeight = 298
  ExplicitWidth = 515
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 241
    ExplicitTop = 241
  end
  object ObjetivoLabel: TLabel [1]
    Left = 8
    Top = 8
    Width = 12
    Height = 15
    Caption = '    '
  end
  inherited BasePanel: TPanel
    Top = 261
    ExplicitTop = 261
    ExplicitWidth = 507
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 168
      ExplicitLeft = 164
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 281
      ExplicitLeft = 277
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 361
      ExplicitLeft = 357
    end
  end
end
