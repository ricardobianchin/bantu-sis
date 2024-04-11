inherited PagFormaEdForm: TPagFormaEdForm
  Caption = 'PagFormaEdForm'
  ClientHeight = 319
  ClientWidth = 624
  ExplicitWidth = 636
  ExplicitHeight = 357
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 247
    Width = 624
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 267
    Width = 624
  end
  object TipoTitLabel: TLabel [3]
    Left = 344
    Top = 28
    Width = 20
    Height = 15
    Caption = 'Uso'
  end
  object Label1: TLabel [4]
    Left = 463
    Top = 28
    Width = 70
    Height = 15
    Caption = 'Recebimento'
  end
  inherited BasePanel: TPanel
    Top = 282
    Width = 624
    ExplicitTop = 247
    ExplicitWidth = 443
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 241
      ExplicitLeft = 60
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 354
      ExplicitLeft = 173
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 434
      ExplicitLeft = 253
    end
  end
  object MoldeTipoPanel: TPanel [6]
    Left = 2
    Top = 24
    Width = 334
    Height = 23
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object TitLabel: TLabel
      Left = 0
      Top = 0
      Width = 103
      Height = 23
      Align = alLeft
      Caption = 'Unidade de Medida'
      FocusControl = ComboBox1
      Layout = tlCenter
      ExplicitHeight = 15
    end
    object BuscaSpeedButton: TSpeedButton
      Left = 311
      Top = 0
      Width = 23
      Height = 23
      Hint = 'Buscar...'
      Align = alLeft
      ImageIndex = 0
      Images = SisImgDataModule.ImageList16Flat
    end
    object EspacadorLabel: TLabel
      Left = 103
      Top = 0
      Width = 6
      Height = 23
      Align = alLeft
      Caption = '  '
      ExplicitHeight = 15
    end
    object Espacador2Label: TLabel
      Left = 309
      Top = 0
      Width = 2
      Height = 23
      Align = alLeft
      AutoSize = False
      Visible = False
      ExplicitLeft = 304
    end
    object ComboBox1: TComboBox
      Left = 109
      Top = 0
      Width = 200
      Height = 23
      Align = alLeft
      TabOrder = 0
      Text = 'ComboBox1'
    end
  end
  object DescrLabeledEdit: TLabeledEdit [7]
    Left = 57
    Top = 68
    Width = 329
    Height = 23
    EditLabel.Width = 51
    EditLabel.Height = 23
    EditLabel.Caption = 'Descri'#231#227'o'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 2
    Text = ''
  end
  object PagFormaTipoComboBox: TComboBox [8]
    Left = 369
    Top = 24
    Width = 81
    Height = 23
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 3
    Text = 'COMPRA'
    Items.Strings = (
      'VENDA'
      'COMPRA')
  end
  object AtivoCheckBox: TCheckBox [9]
    Left = 527
    Top = 115
    Width = 52
    Height = 17
    Caption = 'Ativa'
    TabOrder = 4
  end
  object LabeledEdit1: TLabeledEdit [10]
    Left = 497
    Top = 68
    Width = 82
    Height = 23
    EditLabel.Width = 102
    EditLabel.Height = 23
    EditLabel.Caption = 'Descri'#231#227'o Reduzida'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 5
    Text = 'UUUUUUUU'
  end
  object CheckBox1: TCheckBox [11]
    Left = 0
    Top = 202
    Width = 124
    Height = 17
    Caption = 'Permite Promo'#231#227'o'
    TabOrder = 6
  end
  object CheckBox2: TCheckBox [12]
    Left = 460
    Top = 159
    Width = 124
    Height = 17
    Caption = 'Permite Comiss'#227'o'
    TabOrder = 7
  end
  object MoldeTaxaAdmLabeledEdit: TLabeledEdit [13]
    Left = 84
    Top = 112
    Width = 53
    Height = 23
    Alignment = taCenter
    EditLabel.Width = 81
    EditLabel.Height = 23
    EditLabel.Caption = 'Taxa de Adm %'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 8
    Text = '123,45'
  end
  object LabeledEdit3: TLabeledEdit [14]
    Left = 446
    Top = 113
    Width = 75
    Height = 23
    Alignment = taCenter
    EditLabel.Width = 92
    EditLabel.Height = 23
    EditLabel.Caption = 'Venda M'#237'nima R$'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 9
    Text = '123,45'
  end
  object LabeledEdit2: TLabeledEdit [15]
    Left = 127
    Top = 156
    Width = 53
    Height = 23
    Alignment = taCenter
    EditLabel.Width = 119
    EditLabel.Height = 23
    EditLabel.Caption = 'Abater da Comiss'#227'o %'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 10
    Text = '123,45'
  end
  object LabeledEdit4: TLabeledEdit [16]
    Left = 242
    Top = 113
    Width = 53
    Height = 23
    Alignment = taCenter
    EditLabel.Width = 84
    EditLabel.Height = 23
    EditLabel.Caption = 'Reembolso Dias'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 11
    Text = '123,45'
  end
  object CheckBox3: TCheckBox [17]
    Left = 301
    Top = 116
    Width = 44
    Height = 17
    Caption = 'TEF'
    TabOrder = 12
  end
  object CheckBox4: TCheckBox [18]
    Left = 189
    Top = 159
    Width = 124
    Height = 17
    Caption = 'Exige Autoriza'#231#227'o'
    TabOrder = 13
  end
  object CheckBox5: TCheckBox [19]
    Left = 319
    Top = 159
    Width = 135
    Height = 17
    Caption = 'Exige Indicar Cliente'
    TabOrder = 14
  end
  object ComboBox2: TComboBox [20]
    Left = 536
    Top = 24
    Width = 81
    Height = 23
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 15
    Text = 'A PRAZO'
    Items.Strings = (
      'A VISTA'
      'A PRAZO')
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 56
    Top = 16
  end
  inherited ActionList1_Diag: TActionList
    Left = 96
    Top = 8
  end
end
