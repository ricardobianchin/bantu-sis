inherited PessFuncionarioEdForm: TPessFuncionarioEdForm
  Caption = 'PessFuncionarioEdForm'
  ClientWidth = 937
  ExplicitTop = -117
  ExplicitWidth = 949
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 937
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 937
  end
  inherited BasePanel: TPanel
    Width = 937
    ExplicitTop = 457
    ExplicitWidth = 933
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
    ExplicitTop = 183
    ExplicitHeight = 269
  end
  inherited TitPanel: TPanel
    Width = 937
    ExplicitWidth = 933
  end
  inherited NomePanel: TPanel
    Width = 937
    ExplicitWidth = 933
  end
  inherited PesJurPanel: TPanel
    Width = 937
    ExplicitWidth = 933
  end
  inherited DocsPanel: TPanel
    Width = 937
    ExplicitWidth = 933
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
    ExplicitWidth = 933
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
