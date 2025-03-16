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
    inherited TrabPageControl: TPageControl
      inherited ValorTabSheet: TTabSheet
        object DespTIpoLabel: TLabel [0]
          Left = 7
          Top = 57
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
        inherited ValorNumEditBtu: TNumEditBtu
          Left = 125
          EditLabel.ExplicitLeft = 65
          OnKeyPress = nil
          ExplicitLeft = 125
        end
        object FornecNomeLabeledEdit: TLabeledEdit
          Left = 125
          Top = 89
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
          OnKeyPress = FornecNomeLabeledEditKeyPress
        end
        object DespTipoComboBox: TComboBox
          Left = 125
          Top = 54
          Width = 185
          Height = 28
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnKeyPress = DespTipoComboBoxKeyPress
        end
      end
    end
  end
end
