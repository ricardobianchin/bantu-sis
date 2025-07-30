inherited PessFuncionarioEdForm: TPessFuncionarioEdForm
  Caption = 'PessFuncionarioEdForm'
  ClientWidth = 937
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 953
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 937
  end
  inherited ObjetivoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 937
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited BasePanel: TPanel
    Width = 937
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 937
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      TabOrder = 0
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      TabOrder = 1
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      TabOrder = 2
    end
  end
  inherited EnderecoPanel: TPanel
    Top = 183
    Width = 937
    Height = 269
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 183
    ExplicitWidth = 937
    ExplicitHeight = 269
  end
  inherited TitPanel: TPanel
    Width = 937
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 937
  end
  inherited NomePanel: TPanel
    Width = 937
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 937
    inherited NomePessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited ApelidoPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited NomePessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited ApelidoPessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited PesJurPanel: TPanel
    Width = 937
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 937
    inherited NomeFantaPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited NomeFantaPessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited DocsPanel: TPanel
    Width = 937
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 937
    inherited MUFPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited MPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited DtNascPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited EMailPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited CPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited IPessLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited CPessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited IPessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited MPessEditEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited EMailPessEdit: TEdit
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited MUFPessComboBox: TComboBox
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited DtNascMaskEdit: TMaskEdit
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  object UsuarioPanel: TPanel [9]
    Left = 0
    Top = 150
    Width = 937
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 6
    object FunciNomeDeUsuarioLabel: TLabel
      Left = 7
      Top = 5
      Width = 92
      Height = 15
      Caption = 'Nome de Usu'#225'rio'
      FocusControl = FunciNomeDeUsuarioEdit
    end
    object FunciNomeDeUsuarioEdit: TEdit
      Left = 104
      Top = 1
      Width = 161
      Height = 23
      MaxLength = 20
      TabOrder = 0
      OnKeyPress = ApelidoPessEditKeyPress
    end
    object ApagaSenhaCheckBox: TCheckBox
      Left = 273
      Top = 4
      Width = 162
      Height = 17
      Caption = 'Ao fechar, apagar a senha'
      TabOrder = 1
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 192
    Top = 40
  end
  inherited ActionList1_Diag: TActionList
    Left = 72
    Top = 72
  end
end
