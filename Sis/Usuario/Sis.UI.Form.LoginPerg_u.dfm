inherited LoginPergForm: TLoginPergForm
  Caption = 'Login'
  ClientHeight = 272
  ClientWidth = 354
  ExplicitWidth = 366
  ExplicitHeight = 310
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 168
    Width = 354
    Height = 52
    Alignment = taCenter
    AutoSize = False
    Layout = tlCenter
    ExplicitTop = 100
    ExplicitWidth = 379
    ExplicitHeight = 52
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 257
    Width = 354
    ExplicitTop = 170
  end
  object SenhaLabeledEdit: TLabeledEdit [2]
    Left = 27
    Top = 88
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
    Left = 27
    Top = 40
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
    Top = 220
    Width = 354
    ExplicitTop = 132
    ExplicitWidth = 363
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 95
      ExplicitLeft = 104
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 208
      ExplicitLeft = 217
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 288
      ExplicitLeft = 297
    end
  end
  object TipoPanel: TPanel [5]
    Left = 0
    Top = 0
    Width = 354
    Height = 19
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 3
    ExplicitWidth = 407
    object ModoTitLabel: TLabel
      Left = 0
      Top = 0
      Width = 38
      Height = 19
      Align = alLeft
      Caption = 'Modo: '
      ExplicitHeight = 15
    end
    object LoginPergModoLabel: TLabel
      Left = 38
      Top = 0
      Width = 316
      Height = 19
      Align = alClient
      Caption = 'LoginPergModoLabel'
      ExplicitLeft = 6
      ExplicitTop = 4
      ExplicitWidth = 114
      ExplicitHeight = 15
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 163
  end
  inherited ActionList1_Diag: TActionList
    Left = 163
    Top = 56
  end
end
