inherited PessFuncionarioEdForm: TPessFuncionarioEdForm
  Caption = 'PessFuncionarioEdForm'
  ClientWidth = 941
  ExplicitWidth = 953
  ExplicitHeight = 570
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 941
    ExplicitTop = 460
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 941
    ExplicitTop = 480
  end
  inherited BasePanel: TPanel
    Width = 941
    ExplicitWidth = 941
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 490
      ExplicitLeft = 486
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 603
      ExplicitLeft = 599
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 683
      ExplicitLeft = 679
    end
  end
  inherited EnderecoPanel: TPanel
    Top = 183
    Width = 941
    ExplicitTop = 183
    ExplicitWidth = 941
  end
  inherited TitPanel: TPanel
    Width = 941
    ExplicitWidth = 941
  end
  inherited NomePanel: TPanel
    Width = 941
    ExplicitWidth = 941
  end
  inherited PesJurPanel: TPanel
    Width = 941
    ExplicitWidth = 941
  end
  inherited DocsPanel: TPanel
    Width = 941
    ExplicitWidth = 941
  end
  object UsuarioPanel: TPanel [9]
    Left = 0
    Top = 150
    Width = 941
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
