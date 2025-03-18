inherited CxOperDespesaEdForm: TCxOperDespesaEdForm
  Caption = 'CxOperDespesaEdForm'
  ClientHeight = 398
  ClientWidth = 490
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 506
  ExplicitHeight = 437
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 326
    Width = 490
  end
  inherited ObjetivoLabel: TLabel
    Width = 490
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 346
    Width = 490
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited ObsLabel: TLabel
    Width = 490
  end
  inherited BasePanel: TPanel
    Top = 361
    Width = 490
    StyleElements = [seFont, seClient, seBorder]
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 19
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 132
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 233
    end
  end
  inherited MeioPanel: TPanel
    Width = 490
    Height = 296
    StyleElements = [seFont, seClient, seBorder]
    inherited ObsPanel: TPanel
      Top = 213
      Width = 490
      StyleElements = [seFont, seClient, seBorder]
      inherited Label2: TLabel
        Width = 490
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited ObsMemo: TMemo
        Width = 490
        StyleElements = [seFont, seClient, seBorder]
      end
    end
    inherited TrabPageControl: TPageControl
      Width = 490
      Height = 213
      inherited ValorTabSheet: TTabSheet
        ExplicitWidth = 482
        ExplicitHeight = 183
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
          ExplicitLeft = 125
        end
        object FornecNomeLabeledEdit: TLabeledEdit
          Left = 125
          Top = 92
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
        object NumDocLabeledEdit: TLabeledEdit
          Left = 125
          Top = 130
          Width = 185
          Height = 28
          EditLabel.Width = 113
          EditLabel.Height = 28
          EditLabel.Caption = 'Num.Documento'
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
          TabOrder = 3
          Text = ''
          OnKeyPress = NumDocLabeledEditKeyPress
        end
      end
      inherited NumerarioTabSheet: TTabSheet
        ExplicitWidth = 482
        ExplicitHeight = 183
      end
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 376
    Top = 88
  end
  inherited ActionList1_Diag: TActionList
    Left = 352
    Top = 112
  end
end
