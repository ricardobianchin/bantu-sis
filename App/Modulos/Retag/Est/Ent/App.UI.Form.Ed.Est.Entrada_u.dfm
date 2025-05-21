inherited EntradaEdForm: TEntradaEdForm
  Caption = 'EntradaEdForm'
  ClientHeight = 278
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 317
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 206
    ExplicitTop = 206
  end
  inherited ObjetivoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 226
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 226
  end
  inherited BasePanel: TPanel
    Top = 241
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 241
  end
  inherited NotaGroupBox: TGroupBox
    Height = 57
    ExplicitHeight = 57
    object FornecedorLabel: TLabel [0]
      Left = 192
      Top = 21
      Width = 38
      Height = 15
      Caption = 'Motivo'
    end
    object FornecedorComboBox: TComboBox
      Left = 236
      Top = 18
      Width = 418
      Height = 23
      Style = csDropDownList
      DropDownCount = 12
      TabOrder = 1
      OnChange = FornecedorComboBoxChange
      OnKeyPress = FornecedorComboBoxKeyPress
    end
  end
  inherited ItemGroupBox: TGroupBox
    Top = 99
    Height = 92
    ExplicitTop = 99
    ExplicitHeight = 92
    inherited QtdNumEditBtu: TNumEditBtu
      Text = '1,000'
      OnChange = QtdNumEditBtuChange
      OnKeyPress = QtdNumEditBtuKeyPress
      Valor = '1'
    end
    object CustoNumEditBtu: TNumEditBtu
      Left = 44
      Top = 56
      Width = 81
      Height = 23
      AutoExit = True
      Caption = 'Custo'
      EditLabel.Width = 31
      EditLabel.Height = 23
      EditLabel.Caption = 'Custo'
      LabelPosition = lpLeft
      LabelSpacing = 4
      ReadOnly = False
      TabOrder = 1
      Text = '0,00'
      OnChange = CustoNumEditBtuChange
      OnKeyPress = CustoNumEditBtuKeyPress
      NCasas = 2
      NCasasEsq = 8
      Valor = 0
      MascEsq = '#######0'
    end
    object CustoUnitNumEditBtu: TNumEditBtu
      Left = 216
      Top = 56
      Width = 105
      Height = 23
      AutoExit = True
      Caption = 'Custo Unit'#225'rio'
      EditLabel.Width = 76
      EditLabel.Height = 23
      EditLabel.Caption = 'Custo Unit'#225'rio'
      LabelPosition = lpLeft
      LabelSpacing = 4
      ReadOnly = False
      TabOrder = 2
      Text = '0,0000'
      NCasas = 4
      NCasasEsq = 8
      Valor = 0
      MascEsq = '#######0'
    end
  end
end
