inherited LoginForm: TLoginForm
  Caption = 'Login'
  ClientHeight = 187
  ClientWidth = 375
  Position = poDesktopCenter
  ExplicitWidth = 391
  ExplicitHeight = 226
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 98
    Width = 375
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
    Top = 150
    Width = 375
    ExplicitTop = 150
    ExplicitWidth = 375
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 193
      ExplicitLeft = 189
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 273
      ExplicitLeft = 269
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
