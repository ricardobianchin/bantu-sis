inherited EntradaEdForm: TEntradaEdForm
  Caption = 'EntradaEdForm'
  ClientHeight = 321
  ClientWidth = 858
  ExplicitWidth = 874
  ExplicitHeight = 360
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 249
    Width = 858
    ExplicitTop = 249
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 269
    Width = 858
    ExplicitTop = 269
  end
  inherited BasePanel: TPanel
    Top = 284
    Width = 858
    ExplicitTop = 284
    ExplicitWidth = 858
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 443
      ExplicitLeft = 443
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 556
      ExplicitLeft = 556
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 657
      ExplicitLeft = 657
    end
  end
  inherited NotaGroupBox: TGroupBox
    Width = 839
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    ExplicitWidth = 839
    ExplicitHeight = 57
    object SerieNumEditBtu: TNumEditBtu
      Left = 604
      Top = 18
      Width = 41
      Height = 23
      Alignment = taCenter
      AutoExit = True
      Caption = 'S'#233'rie'
      EditLabel.Width = 25
      EditLabel.Height = 23
      EditLabel.Caption = 'S'#233'rie'
      LabelPosition = lpLeft
      LabelSpacing = 4
      ReadOnly = False
      TabOrder = 1
      Text = '1'
      OnKeyPress = SerieNumEditBtuKeyPress
      NCasas = 0
      NCasasEsq = 3
      Valor = '1'
      MascEsq = '##0'
    end
    object NDocNumEditBtu: TNumEditBtu
      Left = 497
      Top = 18
      Width = 70
      Height = 23
      Alignment = taCenter
      AutoExit = True
      Caption = 'N'#186' Nota'
      EditLabel.Width = 43
      EditLabel.Height = 23
      EditLabel.Caption = 'N'#186' Nota'
      LabelPosition = lpLeft
      LabelSpacing = 4
      ReadOnly = False
      TabOrder = 2
      Text = '0'
      OnKeyPress = NDocNumEditBtuKeyPress
      NCasas = 0
      NCasasEsq = 8
      Valor = 0
      MascEsq = '#######0'
    end
  end
  inherited ItemGroupBox: TGroupBox
    Top = 99
    Width = 839
    Height = 147
    Anchors = [akLeft, akTop, akRight]
    ExplicitTop = 99
    ExplicitWidth = 839
    ExplicitHeight = 147
    object ObsLabel: TLabel [0]
      Left = 6
      Top = 116
      Width = 505
      Height = 26
      Anchors = [akLeft, akBottom]
      Caption = 
        'Quando finalizar a nota, '#39'Custo'#39', '#39'Margem'#39' e '#39'Pre'#231'o Novo'#39' ser'#227'o ' +
        'gravados no cadastro do produto.'#13#10'Se n'#227'o deseja alterar o pre'#231'o ' +
        'atual, deixe '#39'Novo Pre'#231'o'#39' zerado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = [seClient, seBorder]
    end
    inherited QtdNumEditBtu: TNumEditBtu
      Left = 72
      Top = 53
      EditLabel.ExplicitLeft = 6
      EditLabel.ExplicitTop = 52
      Text = '1,000'
      OnChange = QtdNumEditBtuChange
      OnKeyPress = QtdNumEditBtuKeyPress
      Valor = '1'
      ExplicitLeft = 72
      ExplicitTop = 53
    end
    object CustoNumEditBtu: TNumEditBtu
      Left = 195
      Top = 53
      Width = 81
      Height = 23
      Hint = 'Custo Total do item na nota de compra'
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
      Left = 365
      Top = 53
      Width = 105
      Height = 23
      Hint = 'Custo do item '#247' Quantidade'
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
      OnChange = CustoUnitNumEditBtuChange
      OnMouseMove = CustoUnitNumEditBtuMouseMove
      NCasas = 4
      NCasasEsq = 8
      Valor = 0
      MascEsq = '#######0'
    end
    object ProdIdDelesLabeledEdit: TLabeledEdit
      Left = 203
      Top = 20
      Width = 130
      Height = 23
      EditLabel.Width = 119
      EditLabel.Height = 23
      EditLabel.Caption = 'C'#243'digo no Fornecedor'
      LabelPosition = lpLeft
      MaxLength = 60
      TabOrder = 3
      Text = ''
      OnKeyPress = ProdIdDelesLabeledEditKeyPress
    end
    object CustoUltimoNumEditBtu: TNumEditBtu
      Left = 553
      Top = 53
      Width = 105
      Height = 23
      Hint = 'Do hist'#243'rico do produto'
      AutoExit = True
      Caption = #218'ltimo Custo'
      EditLabel.Width = 70
      EditLabel.Height = 23
      EditLabel.Caption = #218'ltimo Custo'
      LabelPosition = lpLeft
      LabelSpacing = 4
      ReadOnly = False
      TabOrder = 4
      Text = '0,0000'
      NCasas = 4
      NCasasEsq = 8
      Valor = 0
      MascEsq = '#######0'
    end
    object MargemNumEditBtu: TNumEditBtu
      Left = 54
      Top = 85
      Width = 72
      Height = 23
      Hint = 'Margem de Lucro'
      AutoExit = True
      Caption = 'Margem'
      EditLabel.Width = 45
      EditLabel.Height = 23
      EditLabel.Caption = 'Margem'
      LabelPosition = lpLeft
      LabelSpacing = 4
      ReadOnly = False
      TabOrder = 5
      Text = '1,0000'
      OnChange = MargemNumEditBtuChange
      OnKeyPress = MargemNumEditBtuKeyPress
      NCasas = 4
      NCasasEsq = 4
      Valor = '1'
      MascEsq = '###0'
    end
    object PrecoSugeridoNumEditBtu: TNumEditBtu
      Left = 217
      Top = 85
      Width = 81
      Height = 23
      Hint = 'Margem '#215' Custo Unit'#225'rio'
      AutoExit = True
      Caption = 'Pre'#231'o Sugerido'
      EditLabel.Width = 80
      EditLabel.Height = 23
      EditLabel.Caption = 'Pre'#231'o Sugerido'
      LabelPosition = lpLeft
      LabelSpacing = 4
      ReadOnly = False
      TabOrder = 6
      Text = '0,00'
      NCasas = 2
      NCasasEsq = 8
      Valor = 0
      MascEsq = '#######0'
    end
    object PrecoAtualNumEditBtu: TNumEditBtu
      Left = 371
      Top = 85
      Width = 81
      Height = 23
      Hint = 'Do hist'#243'rico do produto'
      AutoExit = True
      Caption = 'Pre'#231'o Atual'
      EditLabel.Width = 61
      EditLabel.Height = 23
      EditLabel.Caption = 'Pre'#231'o Atual'
      LabelPosition = lpLeft
      LabelSpacing = 4
      ReadOnly = False
      TabOrder = 7
      Text = '0,00'
      NCasas = 2
      NCasasEsq = 8
      Valor = 0
      MascEsq = '#######0'
    end
    object PrecoNovoNumEditBtu: TNumEditBtu
      Left = 526
      Top = 85
      Width = 81
      Height = 23
      AutoExit = True
      Caption = 'Novo Pre'#231'o'
      EditLabel.Width = 62
      EditLabel.Height = 23
      EditLabel.Caption = 'Novo Pre'#231'o'
      LabelPosition = lpLeft
      LabelSpacing = 4
      ReadOnly = False
      TabOrder = 8
      Text = '0,00'
      OnKeyPress = PrecoNovoNumEditBtuKeyPress
      NCasas = 2
      NCasasEsq = 8
      Valor = 0
      MascEsq = '#######0'
    end
    object NItemNumEditBtu: TNumEditBtu
      Left = 33
      Top = 20
      Width = 41
      Height = 23
      Hint = 'Num. do item na nota de compra'
      Alignment = taCenter
      AutoExit = True
      Caption = 'Item'
      EditLabel.Width = 24
      EditLabel.Height = 23
      EditLabel.Caption = 'Item'
      LabelPosition = lpLeft
      LabelSpacing = 4
      ReadOnly = False
      TabOrder = 9
      Text = '1'
      NCasas = 0
      NCasasEsq = 3
      Valor = '1'
      MascEsq = '##0'
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 232
    Top = 0
  end
  inherited ActionList1_Diag: TActionList
    Left = 344
    Top = 8
  end
end
