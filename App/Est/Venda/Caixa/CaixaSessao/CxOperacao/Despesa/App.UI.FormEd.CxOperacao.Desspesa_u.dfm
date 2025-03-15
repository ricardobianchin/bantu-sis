inherited CxOperDespesaEdForm: TCxOperDespesaEdForm
  Caption = 'CxOperDespesaEdForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited ObjetivoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
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
  inherited MeioPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited ObsPanel: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited Label2: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited ObsMemo: TMemo
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
end
