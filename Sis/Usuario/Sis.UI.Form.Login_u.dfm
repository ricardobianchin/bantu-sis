inherited LoginForm: TLoginForm
  Caption = 'Login'
  ClientHeight = 186
  ClientWidth = 371
  Position = poDesktopCenter
  ExplicitWidth = 387
  ExplicitHeight = 225
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 97
    Width = 371
    Height = 52
    Alignment = taCenter
    AutoSize = False
    Layout = tlCenter
    ExplicitTop = 100
    ExplicitWidth = 379
    ExplicitHeight = 52
  end
  object SenhaLabeledEdit: TLabeledEdit [1]
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
  object NomeUsuLabeledEdit: TLabeledEdit [2]
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
    Top = 149
    Width = 371
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
