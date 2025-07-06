inherited PromoEdForm: TPromoEdForm
  Caption = 'PromoEdForm'
  ClientHeight = 311
  ClientWidth = 598
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 614
  ExplicitHeight = 350
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 239
    Width = 598
  end
  inherited ObjetivoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 259
    Width = 598
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited BasePanel: TPanel
    Top = 274
    Width = 598
    StyleElements = [seFont, seClient, seBorder]
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 183
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 296
      Glyph.Data = {00000000}
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 397
      Glyph.Data = {00000000}
    end
  end
end
