inherited RetagProdEdComunsFrame: TRetagProdEdComunsFrame
  Width = 800
  Height = 407
  ExplicitWidth = 800
  ExplicitHeight = 407
  object DescrErroLabel: TLabel
    Left = 5
    Top = 69
    Width = 78
    Height = 15
    Caption = 'DescrErroLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 192
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = []
  end
  object DescrRedErroLabel: TLabel
    Left = 477
    Top = 69
    Width = 98
    Height = 15
    Caption = 'DescrRedErroLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 192
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = []
  end
  object GeraBarrasLabel: TLabel
    Left = 473
    Top = 34
    Width = 56
    Height = 15
    Caption = 'GeraBarras'
    OnClick = GeraBarrasLabelClick
  end
  object DescrEdit: TLabeledEdit
    Left = 60
    Top = 46
    Width = 406
    Height = 23
    EditLabel.Width = 51
    EditLabel.Height = 23
    EditLabel.Caption = 'Descri'#231#227'o'
    LabelPosition = lpLeft
    LabelSpacing = 4
    MaxLength = 120
    TabOrder = 0
    Text = ''
    OnChange = DescrEditChange
  end
  object DescrRedEdit: TLabeledEdit
    Left = 577
    Top = 46
    Width = 194
    Height = 23
    EditLabel.Width = 102
    EditLabel.Height = 23
    EditLabel.Caption = 'Descri'#231#227'o Reduzida'
    LabelPosition = lpLeft
    MaxLength = 29
    TabOrder = 1
    Text = ''
    OnChange = DescrRedEditChange
  end
  object CustoGroupBox: TGroupBox
    Left = 5
    Top = 121
    Width = 253
    Height = 68
    Caption = 'Custo'
    TabOrder = 2
    object CustoErroLabel: TLabel
      Left = 2
      Top = 51
      Width = 249
      Height = 15
      Align = alBottom
      Caption = 'CustoErroLabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 192
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = []
      ExplicitWidth = 80
    end
  end
  object PrecoGroupBox: TGroupBox
    Left = 262
    Top = 121
    Width = 364
    Height = 68
    Caption = 'Pre'#231'o'
    TabOrder = 3
    object PrecoErroLabel: TLabel
      Left = 2
      Top = 51
      Width = 360
      Height = 15
      Align = alBottom
      Caption = 'PrecoErroLabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 192
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = []
      ExplicitWidth = 79
    end
  end
  object BalGroupBox: TGroupBox
    Left = 5
    Top = 195
    Width = 399
    Height = 207
    Caption = 'Balan'#231'a'
    TabOrder = 4
    object BalTextoEtiqTitLabel: TLabel
      Left = 5
      Top = 94
      Width = 175
      Height = 15
      Caption = 'Texto da Etiqueta (400 caracteres)'
    end
    object BalTextoEtiqMemo: TMemo
      Left = 5
      Top = 111
      Width = 388
      Height = 91
      TabStop = False
      MaxLength = 400
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object MoldeBalDptoLabeledEdit: TLabeledEdit
      Left = 84
      Top = 57
      Width = 39
      Height = 23
      Alignment = taCenter
      EditLabel.Width = 76
      EditLabel.Height = 23
      EditLabel.Caption = 'Departamento'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 1
      Text = '12'
    end
    object MoldeBalValidEditLabeledEdit: TLabeledEdit
      Left = 220
      Top = 57
      Width = 40
      Height = 23
      Alignment = taCenter
      EditLabel.Width = 76
      EditLabel.Height = 23
      EditLabel.Caption = 'Validade (dias)'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 2
      Text = '1234'
    end
    object BalancaExigeCheckBox: TCheckBox
      Left = 11
      Top = 24
      Width = 97
      Height = 17
      Caption = 'Produto Exige Balan'#231'a'
      TabOrder = 3
    end
  end
  object LocalizLabeledEdit: TLabeledEdit
    Left = 608
    Top = 214
    Width = 95
    Height = 23
    EditLabel.Width = 61
    EditLabel.Height = 23
    EditLabel.Caption = 'Localiza'#231#227'o'
    LabelPosition = lpLeft
    LabelSpacing = 4
    MaxLength = 15
    TabOrder = 6
    Text = ''
  end
  object MoldeCapacEmbLabeledEdit: TLabeledEdit
    Left = 565
    Top = 252
    Width = 53
    Height = 23
    Alignment = taCenter
    EditLabel.Width = 144
    EditLabel.Height = 23
    EditLabel.Caption = 'Capacidade da Embalagem'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 7
    Text = '12345'
  end
  object AtivoCheckBox: TCheckBox
    Left = 417
    Top = 216
    Width = 109
    Height = 17
    Caption = 'Ativo no Sistema'
    TabOrder = 5
    OnKeyPress = AtivoCheckBoxKeyPress
  end
  object MoldeMargemLabeledEdit: TLabeledEdit
    Left = 677
    Top = 252
    Width = 53
    Height = 23
    Alignment = taCenter
    EditLabel.Width = 45
    EditLabel.Height = 23
    EditLabel.Caption = 'Margem'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 8
    Text = '123,45'
  end
  object NCMLabeledEdit: TLabeledEdit
    Left = 450
    Top = 290
    Width = 80
    Height = 23
    EditLabel.Width = 28
    EditLabel.Height = 23
    EditLabel.Caption = 'NCM'
    LabelPosition = lpLeft
    LabelSpacing = 4
    MaxLength = 8
    NumbersOnly = True
    TabOrder = 9
    Text = ''
  end
end
