inherited PessEdBasForm: TPessEdBasForm
  Caption = 'PessEdBasForm'
  ClientHeight = 536
  ClientWidth = 965
  ExplicitWidth = 977
  ExplicitHeight = 574
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 464
    Width = 965
    ExplicitTop = 464
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 484
    Width = 965
    ExplicitTop = 484
  end
  object NomePessLabel: TLabel [3]
    Left = 8
    Top = 32
    Width = 33
    Height = 15
    Caption = 'Nome'
    FocusControl = NomePessEdit
  end
  object NomeFantaPessLabel: TLabel [4]
    Left = 8
    Top = 61
    Width = 79
    Height = 15
    Caption = 'Nome Fantasia'
    FocusControl = NomeFantaPessEdit
  end
  object ApelidoPessLabel: TLabel [5]
    Left = 374
    Top = 61
    Width = 61
    Height = 15
    Caption = 'Nome Exib.'
    FocusControl = ApelidoPessEdit
  end
  object CPessLabel: TLabel [6]
    Left = 9
    Top = 93
    Width = 53
    Height = 15
    Caption = 'CPF/CNPJ'
    FocusControl = CPessEdit
  end
  object IPessLabel: TLabel [7]
    Left = 236
    Top = 93
    Width = 64
    Height = 15
    Caption = 'Id./Inscr.Est.'
    FocusControl = IPessEdit
  end
  object MPessLabel: TLabel [8]
    Left = 473
    Top = 93
    Width = 56
    Height = 15
    Caption = 'Inscr.Mun.'
    FocusControl = MPessEditEdit
  end
  object MUFPessLabel: TLabel [9]
    Left = 689
    Top = 93
    Width = 77
    Height = 15
    Caption = #211'rg'#227'o Emissor'
    FocusControl = MUFPessEdit
  end
  object EMailPessLabel: TLabel [10]
    Left = 8
    Top = 124
    Width = 34
    Height = 15
    Caption = 'e-mail'
    FocusControl = EMailPessEdit
  end
  object DtNascPessLabel: TLabel [11]
    Left = 284
    Top = 124
    Width = 56
    Height = 15
    Caption = 'Data Nasc.'
  end
  inherited BasePanel: TPanel
    Top = 499
    Width = 965
    TabOrder = 10
    ExplicitTop = 498
    ExplicitWidth = 961
    DesignSize = (
      965
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 546
      ExplicitLeft = 542
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 659
      ExplicitLeft = 655
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 739
      ExplicitLeft = 735
    end
  end
  object NomePessEdit: TEdit [13]
    Left = 47
    Top = 29
    Width = 480
    Height = 23
    MaxLength = 60
    TabOrder = 0
    OnKeyPress = NomePessEditKeyPress
  end
  object NomeFantaPessEdit: TEdit [14]
    Left = 94
    Top = 58
    Width = 274
    Height = 23
    MaxLength = 60
    TabOrder = 1
    OnKeyPress = NomeFantaPessEditKeyPress
  end
  object ApelidoPessEdit: TEdit [15]
    Left = 440
    Top = 58
    Width = 161
    Height = 23
    MaxLength = 20
    TabOrder = 2
    OnKeyPress = ApelidoPessEditKeyPress
  end
  object CPessEdit: TEdit [16]
    Left = 68
    Top = 90
    Width = 161
    Height = 23
    MaxLength = 20
    TabOrder = 3
    OnKeyPress = CPessEditKeyPress
  end
  object IPessEdit: TEdit [17]
    Left = 305
    Top = 90
    Width = 161
    Height = 23
    MaxLength = 20
    TabOrder = 4
    OnKeyPress = IPessEditKeyPress
  end
  object MPessEditEdit: TEdit [18]
    Left = 534
    Top = 90
    Width = 147
    Height = 23
    MaxLength = 20
    TabOrder = 5
    OnKeyPress = MPessEditEditKeyPress
  end
  object MUFPessEdit: TEdit [19]
    Left = 772
    Top = 90
    Width = 87
    Height = 23
    MaxLength = 20
    TabOrder = 6
    OnKeyPress = MUFPessEditKeyPress
  end
  object EMailPessEdit: TEdit [20]
    Left = 50
    Top = 121
    Width = 226
    Height = 23
    MaxLength = 60
    TabOrder = 7
    OnKeyPress = EMailPessEditKeyPress
  end
  object DtNascDateTimePicker: TDateTimePicker [21]
    Left = 345
    Top = 120
    Width = 89
    Height = 23
    Date = 45467.000000000000000000
    Time = 0.703898645835579400
    TabOrder = 8
    OnKeyPress = DtNascDateTimePickerKeyPress
  end
  object EnderecoPanel: TPanel [22]
    Left = 8
    Top = 150
    Width = 939
    Height = 300
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 9
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
