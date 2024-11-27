inherited PessEdBasForm: TPessEdBasForm
  Caption = 'PessEdBasForm'
  ClientHeight = 530
  ClientWidth = 941
  ExplicitWidth = 953
  ExplicitHeight = 568
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 458
    Width = 941
    ExplicitTop = 458
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 478
    Width = 941
    ExplicitTop = 478
  end
  inherited BasePanel: TPanel
    Top = 493
    Width = 941
    TabOrder = 1
    ExplicitTop = 492
    ExplicitWidth = 937
    DesignSize = (
      941
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 482
      ExplicitLeft = 478
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 595
      ExplicitLeft = 591
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 675
      ExplicitLeft = 671
    end
  end
  object EnderecoPanel: TPanel [4]
    Left = 0
    Top = 150
    Width = 941
    Height = 305
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitWidth = 937
  end
  object TitPanel: TPanel [5]
    Left = 0
    Top = 0
    Width = 941
    Height = 18
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    ExplicitWidth = 937
  end
  object NomePanel: TPanel [6]
    Left = 0
    Top = 18
    Width = 941
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 3
    ExplicitWidth = 937
    object NomePessLabel: TLabel
      Left = 8
      Top = 4
      Width = 33
      Height = 15
      Caption = 'Nome'
      FocusControl = NomePessEdit
    end
    object NomePessEdit: TEdit
      Left = 47
      Top = 0
      Width = 480
      Height = 23
      MaxLength = 60
      TabOrder = 0
      OnKeyPress = NomePessEditKeyPress
    end
  end
  object PesJurPanel: TPanel [7]
    Left = 0
    Top = 51
    Width = 941
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 4
    ExplicitWidth = 937
    object NomeFantaPessLabel: TLabel
      Left = 8
      Top = 4
      Width = 79
      Height = 15
      Caption = 'Nome Fantasia'
      FocusControl = NomeFantaPessEdit
    end
    object ApelidoPessLabel: TLabel
      Left = 374
      Top = 4
      Width = 61
      Height = 15
      Caption = 'Nome Exib.'
      FocusControl = ApelidoPessEdit
    end
    object NomeFantaPessEdit: TEdit
      Left = 94
      Top = 0
      Width = 274
      Height = 23
      MaxLength = 60
      TabOrder = 0
      OnKeyPress = NomeFantaPessEditKeyPress
    end
    object ApelidoPessEdit: TEdit
      Left = 440
      Top = 0
      Width = 161
      Height = 23
      MaxLength = 20
      TabOrder = 1
      OnKeyPress = ApelidoPessEditKeyPress
    end
  end
  object DocsPanel: TPanel [8]
    Left = 0
    Top = 84
    Width = 941
    Height = 66
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 5
    ExplicitWidth = 937
    object MUFPessLabel: TLabel
      Left = 692
      Top = 4
      Width = 77
      Height = 15
      Caption = #211'rg'#227'o Emissor'
      FocusControl = MUFPessEdit
    end
    object MPessLabel: TLabel
      Left = 475
      Top = 4
      Width = 56
      Height = 15
      Caption = 'Inscr.Mun.'
      FocusControl = MPessEditEdit
    end
    object DtNascPessLabel: TLabel
      Left = 284
      Top = 37
      Width = 56
      Height = 15
      Caption = 'Data Nasc.'
    end
    object EMailPessLabel: TLabel
      Left = 8
      Top = 37
      Width = 34
      Height = 15
      Caption = 'e-mail'
      FocusControl = EMailPessEdit
    end
    object CPessLabel: TLabel
      Left = 9
      Top = 4
      Width = 53
      Height = 15
      Caption = 'CPF/CNPJ'
      FocusControl = CPessEdit
    end
    object IPessLabel: TLabel
      Left = 237
      Top = 4
      Width = 64
      Height = 15
      Caption = 'Id./Inscr.Est.'
    end
    object CPessEdit: TEdit
      Left = 68
      Top = 0
      Width = 161
      Height = 23
      MaxLength = 20
      NumbersOnly = True
      TabOrder = 0
      OnExit = CPessEditExit
      OnKeyDown = CPessEditKeyDown
      OnKeyPress = CPessEditKeyPress
    end
    object IPessEdit: TEdit
      Left = 306
      Top = 0
      Width = 161
      Height = 23
      MaxLength = 20
      TabOrder = 1
      OnKeyPress = IPessEditKeyPress
    end
    object MPessEditEdit: TEdit
      Left = 536
      Top = 0
      Width = 147
      Height = 23
      MaxLength = 20
      TabOrder = 2
      OnKeyPress = MPessEditEditKeyPress
    end
    object MUFPessEdit: TEdit
      Left = 775
      Top = 0
      Width = 87
      Height = 23
      MaxLength = 20
      TabOrder = 3
      OnKeyPress = MUFPessEditKeyPress
    end
    object AtivoPessCheckBox: TCheckBox
      Left = 444
      Top = 36
      Width = 48
      Height = 17
      Hint = 'Registro Ativo no Sistema'
      Caption = 'Ativo'
      TabOrder = 4
      OnKeyPress = AtivoPessCheckBoxKeyPress
    end
    object DtNascDateTimePicker: TDateTimePicker
      Left = 346
      Top = 33
      Width = 89
      Height = 23
      Date = 45467.000000000000000000
      Time = 0.703898645835579400
      TabOrder = 5
      OnKeyPress = DtNascDateTimePickerKeyPress
    end
    object EMailPessEdit: TEdit
      Left = 50
      Top = 33
      Width = 226
      Height = 23
      MaxLength = 60
      TabOrder = 6
      OnKeyPress = EMailPessEditKeyPress
    end
    object Button1: TButton
      Left = 166
      Top = 13
      Width = 26
      Height = 17
      Caption = 'cnpj'
      TabOrder = 7
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 198
      Top = 13
      Width = 26
      Height = 17
      Caption = 'cpf'
      TabOrder = 8
      OnClick = Button2Click
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 176
    Top = 200
  end
  inherited ActionList1_Diag: TActionList
    Left = 96
    Top = 160
  end
end
