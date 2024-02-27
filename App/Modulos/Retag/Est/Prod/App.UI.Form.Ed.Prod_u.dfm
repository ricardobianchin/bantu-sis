inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 329
  ClientWidth = 888
  ExplicitWidth = 900
  ExplicitHeight = 367
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 272
    Width = 888
    ExplicitTop = 272
  end
  object Label1: TLabel [2]
    Left = 8
    Top = 79
    Width = 55
    Height = 15
    Caption = 'Fabricante'
  end
  object Label2: TLabel [3]
    Left = 208
    Top = 79
    Width = 85
    Height = 15
    Caption = 'Tipo de Produto'
  end
  object Label3: TLabel [4]
    Left = 408
    Top = 79
    Width = 103
    Height = 15
    Caption = 'Unidade de Medida'
  end
  object Label4: TLabel [5]
    Left = 608
    Top = 79
    Width = 41
    Height = 15
    Caption = 'ICMS %'
  end
  object Label5: TLabel [6]
    Left = 279
    Top = 127
    Width = 80
    Height = 15
    Caption = 'Uso de Balan'#231'a'
  end
  object DescrLabeledEdit: TLabeledEdit [7]
    Left = 73
    Top = 47
    Width = 366
    Height = 23
    EditLabel.Width = 51
    EditLabel.Height = 15
    EditLabel.Caption = 'Descri'#231#227'o'
    MaxLength = 120
    TabOrder = 1
    Text = ''
  end
  object FabrComboBox: TComboBox [8]
    Left = 8
    Top = 96
    Width = 193
    Height = 23
    TabOrder = 3
  end
  object ComboBox1: TComboBox [9]
    Left = 208
    Top = 96
    Width = 193
    Height = 23
    TabOrder = 4
  end
  object ComboBox2: TComboBox [10]
    Left = 408
    Top = 96
    Width = 193
    Height = 23
    TabOrder = 5
  end
  object LabeledEdit3: TLabeledEdit [11]
    Left = 163
    Top = 144
    Width = 110
    Height = 23
    EditLabel.Width = 90
    EditLabel.Height = 15
    EditLabel.Caption = 'C'#243'digo de Barras'
    MaxLength = 29
    TabOrder = 7
    Text = ''
  end
  object AtivoCheckBox: TCheckBox [12]
    Left = 8
    Top = 194
    Width = 97
    Height = 17
    Caption = 'Ativo no Sistema'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object ComboBox4: TComboBox [13]
    Left = 279
    Top = 144
    Width = 193
    Height = 23
    TabOrder = 9
  end
  object ComboBox3: TComboBox [14]
    Left = 608
    Top = 96
    Width = 193
    Height = 23
    TabOrder = 6
  end
  object DescrRedLabeledEdit: TLabeledEdit [15]
    Left = 443
    Top = 47
    Width = 207
    Height = 23
    EditLabel.Width = 102
    EditLabel.Height = 15
    EditLabel.Caption = 'Descri'#231#227'o Reduzida'
    MaxLength = 29
    TabOrder = 2
    Text = ''
  end
  inherited BasePanel: TPanel
    Top = 292
    Width = 888
    ExplicitTop = 291
    ExplicitWidth = 884
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 513
      ExplicitLeft = 509
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 626
      ExplicitLeft = 622
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 706
      ExplicitLeft = 702
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 88
    Top = 192
  end
  inherited ActionList1_Diag: TActionList
    Left = 232
    Top = 176
  end
end
