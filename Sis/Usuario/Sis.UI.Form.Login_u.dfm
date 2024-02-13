inherited LoginForm: TLoginForm
  Caption = 'Login'
  ClientHeight = 185
  ClientWidth = 367
  ExplicitWidth = 383
  ExplicitHeight = 224
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 96
    Width = 367
    Height = 52
    Alignment = taCenter
    AutoSize = False
    Layout = tlCenter
    ExplicitTop = 100
    ExplicitWidth = 379
    ExplicitHeight = 52
  end
  object NomeUsuLabeledEdit: TLabeledEdit [1]
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
  object SenhaLabeledEdit: TLabeledEdit [2]
    Left = 24
    Top = 72
    Width = 300
    Height = 23
    EditLabel.Width = 32
    EditLabel.Height = 15
    EditLabel.Caption = 'Senha'
    MaxLength = 40
    PasswordChar = '*'
    TabOrder = 2
    Text = ''
    OnChange = SenhaLabeledEditChange
    OnKeyPress = SenhaLabeledEditKeyPress
  end
  inherited BasePanel: TPanel
    Top = 148
    Width = 367
    ExplicitTop = 149
    ExplicitWidth = 371
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
