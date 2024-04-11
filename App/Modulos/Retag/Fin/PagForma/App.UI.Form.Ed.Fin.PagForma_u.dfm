inherited PagFormaEdForm: TPagFormaEdForm
  Caption = 'PagFormaEdForm'
  ClientHeight = 319
  ClientWidth = 624
  OnCreate = FormCreate
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
    Left = 160
    Top = 28
    Width = 20
    Height = 15
    Caption = 'Uso'
  end
  object Label1: TLabel [4]
    Left = 274
    Top = 28
    Width = 70
    Height = 15
    Caption = 'Recebimento'
  end
  object Label2: TLabel [5]
    Left = 3
    Top = 28
    Width = 23
    Height = 15
    Caption = 'Tipo'
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
    TabOrder = 1
    Text = ''
  end
  object PagFormaTipoComboBox: TComboBox [8]
    Left = 184
    Top = 24
    Width = 81
    Height = 23
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 2
    Text = 'COMPRA'
    Items.Strings = (
      'VENDA'
      'COMPRA')
  end
  object AtivoCheckBox: TCheckBox [9]
    Left = 439
    Top = 27
    Width = 52
    Height = 17
    Caption = 'Ativa'
    TabOrder = 3
  end
  object LabeledEdit1: TLabeledEdit [10]
    Left = 498
    Top = 68
    Width = 82
    Height = 23
    EditLabel.Width = 102
    EditLabel.Height = 23
    EditLabel.Caption = 'Descri'#231#227'o Reduzida'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 4
    Text = ''
  end
  object CheckBox1: TCheckBox [11]
    Left = 504
    Top = 131
    Width = 122
    Height = 17
    Caption = 'Permite Promo'#231#227'o'
    TabOrder = 5
  end
  object ComboBox2: TComboBox [12]
    Left = 347
    Top = 24
    Width = 81
    Height = 23
    Style = csDropDownList
    ItemIndex = 1
    TabOrder = 6
    Text = 'A PRAZO'
    Items.Strings = (
      'A VISTA'
      'A PRAZO')
  end
  object ComboBox1: TComboBox [13]
    Left = 30
    Top = 24
    Width = 122
    Height = 23
    Style = csDropDownList
    ItemIndex = 3
    TabOrder = 7
    Text = 'TRANSFERENCIA'
    Items.Strings = (
      'DINHEIRO'
      'DEBITO'
      'CREDITO'
      'TRANSFERENCIA')
  end
  object GroupBox1: TGroupBox [14]
    Left = 4
    Top = 164
    Width = 384
    Height = 45
    Caption = 'Na Venda, Exige'
    TabOrder = 8
    object CheckBox4: TCheckBox
      Left = 82
      Top = 19
      Width = 87
      Height = 17
      Caption = 'Autoriza'#231#227'o'
      TabOrder = 0
    end
    object CheckBox5: TCheckBox
      Left = 8
      Top = 19
      Width = 65
      Height = 17
      Caption = 'Cliente'
      TabOrder = 1
    end
    object LabeledEdit3: TLabeledEdit
      Left = 299
      Top = 17
      Width = 75
      Height = 23
      Alignment = taCenter
      EditLabel.Width = 66
      EditLabel.Height = 23
      EditLabel.Caption = 'M'#237'nimo (R$)'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 2
      Text = '123,45'
    end
    object CheckBox3: TCheckBox
      Left = 178
      Top = 19
      Width = 44
      Height = 17
      Caption = 'TEF'
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox [15]
    Left = 295
    Top = 112
    Width = 204
    Height = 45
    Caption = 'Comiss'#227'o'
    TabOrder = 9
    object CheckBox2: TCheckBox
      Left = 8
      Top = 19
      Width = 63
      Height = 17
      Caption = 'Permite'
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 146
      Top = 17
      Width = 53
      Height = 23
      Alignment = taCenter
      EditLabel.Width = 56
      EditLabel.Height = 23
      EditLabel.Caption = 'Abater (%)'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 1
      Text = '123,45'
    end
  end
  object GroupBox3: TGroupBox [16]
    Left = 0
    Top = 112
    Width = 286
    Height = 45
    Caption = 'Administradora'
    TabOrder = 10
    object MoldeTaxaAdmLabeledEdit: TLabeledEdit
      Left = 55
      Top = 17
      Width = 53
      Height = 23
      Alignment = taCenter
      EditLabel.Width = 44
      EditLabel.Height = 23
      EditLabel.Caption = 'Taxa (%)'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 0
      Text = '123,45'
    end
    object LabeledEdit4: TLabeledEdit
      Left = 213
      Top = 17
      Width = 53
      Height = 23
      Alignment = taCenter
      EditLabel.Width = 92
      EditLabel.Height = 23
      EditLabel.Caption = 'Reembolso (Dias)'
      LabelPosition = lpLeft
      LabelSpacing = 4
      TabOrder = 1
      Text = '123,45'
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 88
    Top = 40
  end
  inherited ActionList1_Diag: TActionList
    Left = 174
    Top = 24
  end
end
