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
    object DespTIpoLabel: TLabel [0]
      Left = 47
      Top = 41
      Width = 111
      Height = 20
      Caption = 'Tipo de Despesa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    inherited ObsPanel: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited Label2: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited ObsMemo: TMemo
        StyleElements = [seFont, seClient, seBorder]
      end
    end
    object ValorNumEditBtu: TNumEditBtu
      Left = 165
      Top = 3
      Width = 100
      Height = 28
      AutoExit = True
      Caption = 'Valor R$'
      EditLabel.Width = 55
      EditLabel.Height = 28
      EditLabel.Caption = 'Valor R$'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -15
      EditLabel.Font.Name = 'Segoe UI'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      LabelPosition = lpLeft
      LabelSpacing = 5
      ParentFont = False
      ReadOnly = False
      TabOrder = 1
      Text = '0,00'
      NCasas = 2
      NCasasEsq = 7
      Valor = 0
      MascEsq = '######0'
    end
    object FornecLabeledEdit: TLabeledEdit
      Left = 165
      Top = 73
      Width = 185
      Height = 28
      EditLabel.Width = 75
      EditLabel.Height = 28
      EditLabel.Caption = 'Fornecedor'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -15
      EditLabel.Font.Name = 'Segoe UI'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      LabelPosition = lpLeft
      LabelSpacing = 5
      ParentFont = False
      TabOrder = 2
      Text = ''
    end
    object FornecComboBox: TComboBox
      Left = 165
      Top = 38
      Width = 185
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
end
