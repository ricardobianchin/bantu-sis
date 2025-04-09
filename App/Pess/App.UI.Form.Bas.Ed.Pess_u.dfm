inherited PessEdBasForm: TPessEdBasForm
  Caption = 'PessEdBasForm'
  ClientHeight = 530
  ClientWidth = 941
  StyleElements = [seFont, seClient, seBorder]
  OnKeyUp = FormKeyUp
  ExplicitWidth = 957
  ExplicitHeight = 569
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 495
    Width = 941
    ExplicitTop = 495
  end
  inherited ObjetivoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 515
    Width = 941
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 515
  end
  inherited BasePanel: TPanel
    Top = 458
    Width = 941
    TabOrder = 1
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 458
    ExplicitWidth = 941
    DesignSize = (
      941
      37)
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
    object MUFPessLabel: TLabel
      Left = 710
      Top = 4
      Width = 94
      Height = 15
      Caption = 'UF '#211'rg'#227'o Emissor'
    end
    object MPessLabel: TLabel
      Left = 476
      Top = 4
      Width = 69
      Height = 15
      Alignment = taRightJustify
      Caption = #211'rg'#227'o Emiss.'
      FocusControl = MPessEditEdit
    end
    object DtNascPessLabel: TLabel
      Left = 316
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
      Left = 240
      Top = 4
      Width = 56
      Height = 15
      Alignment = taRightJustify
      Caption = 'Identidade'
    end
    object CPessEdit: TEdit
      Left = 68
      Top = 0
      Width = 161
      Height = 23
      MaxLength = 20
      NumbersOnly = True
      TabOrder = 0
      OnChange = CPessEditChange
      OnExit = CPessEditExit
      OnKeyDown = CPessEditKeyDown
      OnKeyPress = CPessEditKeyPress
    end
    object IPessEdit: TEdit
      Left = 300
      Top = 0
      Width = 161
      Height = 23
      MaxLength = 20
      TabOrder = 1
      OnKeyPress = IPessEditKeyPress
    end
    object MPessEditEdit: TEdit
      Left = 551
      Top = 0
      Width = 147
      Height = 23
      MaxLength = 20
      TabOrder = 2
      OnKeyPress = MPessEditEditKeyPress
    end
    object AtivoPessCheckBox: TCheckBox
      Left = 476
      Top = 36
      Width = 48
      Height = 17
      Hint = 'Registro Ativo no Sistema'
      Caption = 'Ativo'
      TabOrder = 4
      OnKeyPress = AtivoPessCheckBoxKeyPress
    end
    object EMailPessEdit: TEdit
      Left = 50
      Top = 33
      Width = 255
      Height = 23
      MaxLength = 60
      TabOrder = 5
      OnKeyPress = EMailPessEditKeyPress
    end
    object Button1: TButton
      Left = 166
      Top = 13
      Width = 26
      Height = 17
      Caption = 'cnpj'
      TabOrder = 6
      TabStop = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 198
      Top = 13
      Width = 26
      Height = 17
      Caption = 'cpf'
      TabOrder = 7
      TabStop = False
      OnClick = Button2Click
    end
    object MUFPessComboBox: TComboBox
      Left = 812
      Top = 0
      Width = 61
      Height = 23
      MaxLength = 2
      TabOrder = 3
      Text = 'MUFPessComboBox'
      OnKeyPress = MUFPessComboBoxKeyPress
    end
    object DtNascMaskEdit: TMaskEdit
      Left = 378
      Top = 33
      Width = 80
      Height = 23
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 8
      Text = '  /  /    '
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
