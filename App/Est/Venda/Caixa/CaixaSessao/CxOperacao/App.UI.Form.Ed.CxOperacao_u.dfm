inherited CxOperacaoEdForm: TCxOperacaoEdForm
  Caption = 'CxOperacaoEdForm'
  TextHeight = 15
  inherited MensLabel: TLabel
    ExplicitTop = 196
  end
  inherited AlteracaoTextoLabel: TLabel
    ExplicitTop = 216
  end
  inherited BasePanel: TPanel
    ExplicitTop = 230
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 12
      ExplicitLeft = 8
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 125
      Glyph.Data = {00000000}
      ExplicitLeft = 121
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 226
      Glyph.Data = {00000000}
      ExplicitLeft = 222
    end
  end
end
