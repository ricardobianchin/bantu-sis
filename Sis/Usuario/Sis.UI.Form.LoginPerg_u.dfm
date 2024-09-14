inherited LoginPergForm: TLoginPergForm
  Caption = 'Login'
  ClientHeight = 185
  ClientWidth = 367
  ExplicitWidth = 379
  ExplicitHeight = 223
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 81
    Width = 367
    Height = 52
    Alignment = taCenter
    AutoSize = False
    Layout = tlCenter
    ExplicitTop = 100
    ExplicitWidth = 379
    ExplicitHeight = 52
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 170
    Width = 367
    ExplicitTop = 170
  end
  object SenhaLabeledEdit: TLabeledEdit [2]
    Left = 24
    Top = 72
    Width = 300
    Height = 23
    EditLabel.Width = 32
    EditLabel.Height = 15
    EditLabel.Caption = 'Senha'
    MaxLength = 20
    PasswordChar = '*'
    TabOrder = 2
    Text = ''
    OnChange = SenhaLabeledEditChange
    OnKeyPress = SenhaLabeledEditKeyPress
  end
  object NomeUsuLabeledEdit: TLabeledEdit [3]
    Left = 24
    Top = 24
    Width = 300
    Height = 23
    EditLabel.Width = 92
    EditLabel.Height = 15
    EditLabel.Caption = 'Nome de Usu'#225'rio'
    MaxLength = 20
    TabOrder = 1
    Text = ''
    OnChange = NomeUsuLabeledEditChange
    OnKeyPress = NomeUsuLabeledEditKeyPress
  end
  inherited BasePanel: TPanel
    Top = 133
    Width = 367
    ExplicitTop = 132
    ExplicitWidth = 363
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 108
      ExplicitLeft = 104
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 221
      ExplicitLeft = 217
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 301
      ExplicitLeft = 297
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 192
    Top = 16
  end
  inherited ActionList1_Diag: TActionList
    Left = 264
    Top = 40
  end
end
