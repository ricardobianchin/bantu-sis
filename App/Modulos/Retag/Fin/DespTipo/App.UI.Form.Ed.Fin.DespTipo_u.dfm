inherited DespTipoEdForm: TDespTipoEdForm
  Caption = 'DespTipoEdForm'
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
  object LabeledEdit1: TLabeledEdit [4]
    Left = 8
    Top = 48
    Width = 260
    Height = 23
    EditLabel.Width = 67
    EditLabel.Height = 15
    EditLabel.Caption = 'LabeledEdit1'
    MaxLength = 20
    TabOrder = 1
    Text = ''
    OnChange = LabeledEdit1Change
    OnKeyPress = LabeledEdit1KeyPress
  end
end
