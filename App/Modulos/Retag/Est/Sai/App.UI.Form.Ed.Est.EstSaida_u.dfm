inherited EstSaidaEdForm: TEstSaidaEdForm
  Caption = 'EstSaidaEdForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited MensLabel: TLabel
    ExplicitTop = 261
  end
  inherited ObjetivoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 281
  end
  inherited BasePanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited OkBitBtn_DiagBtn: TBitBtn
      Glyph.Data = {00000000}
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Glyph.Data = {00000000}
    end
  end
  inherited CodLabeledEdit: TLabeledEdit
    StyleElements = [seFont, seClient, seBorder]
  end
end
