inherited PessEdBasForm: TPessEdBasForm
  Caption = 'PessEdBasForm'
  ClientHeight = 282
  ClientWidth = 988
  ExplicitWidth = 1000
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 210
    Width = 988
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 230
    Width = 988
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
  object Label1: TLabel [5]
    Left = 326
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
    FocusControl = Edit1
  end
  object MPessLabel: TLabel [8]
    Left = 473
    Top = 93
    Width = 56
    Height = 15
    Caption = 'Inscr.Mun.'
    FocusControl = Edit2
  end
  object Label2: TLabel [9]
    Left = 702
    Top = 93
    Width = 77
    Height = 15
    Caption = #211'rg'#227'o Emissor'
    FocusControl = Edit3
  end
  object Label3: TLabel [10]
    Left = 8
    Top = 124
    Width = 79
    Height = 15
    Caption = 'Nome Fantasia'
    FocusControl = Edit4
  end
  inherited BasePanel: TPanel
    Top = 245
    Width = 988
    ExplicitWidth = 984
    DesignSize = (
      988
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 589
      ExplicitLeft = 585
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 702
      ExplicitLeft = 698
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 782
      ExplicitLeft = 778
    end
  end
  object NomePessEdit: TEdit [12]
    Left = 47
    Top = 29
    Width = 480
    Height = 23
    MaxLength = 60
    TabOrder = 1
    OnChange = NomePessEditChange
    OnKeyPress = NomePessEditKeyPress
  end
  object NomeFantaPessEdit: TEdit [13]
    Left = 94
    Top = 58
    Width = 226
    Height = 23
    MaxLength = 60
    TabOrder = 2
    OnChange = NomePessEditChange
    OnKeyPress = NomePessEditKeyPress
  end
  object ApelidoPessEdit: TEdit [14]
    Left = 392
    Top = 58
    Width = 161
    Height = 23
    MaxLength = 20
    TabOrder = 3
    OnChange = NomePessEditChange
    OnKeyPress = NomePessEditKeyPress
  end
  object CPessEdit: TEdit [15]
    Left = 68
    Top = 90
    Width = 161
    Height = 23
    MaxLength = 20
    TabOrder = 4
    OnChange = NomePessEditChange
    OnKeyPress = NomePessEditKeyPress
  end
  object Edit1: TEdit [16]
    Left = 305
    Top = 90
    Width = 161
    Height = 23
    MaxLength = 20
    TabOrder = 5
    OnChange = NomePessEditChange
    OnKeyPress = NomePessEditKeyPress
  end
  object Edit2: TEdit [17]
    Left = 534
    Top = 90
    Width = 161
    Height = 23
    MaxLength = 20
    TabOrder = 6
    OnChange = NomePessEditChange
    OnKeyPress = NomePessEditKeyPress
  end
  object Edit3: TEdit [18]
    Left = 786
    Top = 90
    Width = 161
    Height = 23
    MaxLength = 20
    TabOrder = 7
    OnChange = NomePessEditChange
    OnKeyPress = NomePessEditKeyPress
  end
  object Edit4: TEdit [19]
    Left = 94
    Top = 121
    Width = 226
    Height = 23
    MaxLength = 60
    TabOrder = 8
    OnChange = NomePessEditChange
    OnKeyPress = NomePessEditKeyPress
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 64
    Top = 128
  end
  inherited ActionList1_Diag: TActionList
    Left = 160
    Top = 160
  end
end
