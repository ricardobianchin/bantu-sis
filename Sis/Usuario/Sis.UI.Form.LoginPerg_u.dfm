inherited LoginPergForm: TLoginPergForm
  Caption = 'Login'
  ClientHeight = 390
  ClientWidth = 432
  ExplicitWidth = 444
  ExplicitHeight = 428
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 286
    Width = 432
    Height = 52
    Alignment = taCenter
    AutoSize = False
    Layout = tlCenter
    ExplicitTop = 100
    ExplicitWidth = 379
    ExplicitHeight = 52
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 375
    Width = 432
    ExplicitTop = 170
  end
  object NomeDeUsuarioStatusLabel: TLabel [2]
    Left = 27
    Top = 68
    Width = 112
    Height = 12
    Caption = 'NomeDeUsuarioStatusLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 192
    Font.Height = -9
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Visible = False
    StyleElements = []
  end
  object ObsLabel: TLabel [3]
    Left = 9
    Top = 274
    Width = 264
    Height = 18
    AutoSize = False
    Caption = 'Todos os campos devem ser preenchidos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object AvisoSenhaLabel: TLabel [4]
    Left = 103
    Top = 251
    Width = 185
    Height = 17
    Caption = 'ATEN'#199#195'O! Exibindo a Senha!'
    Color = 192
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI Black'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    Visible = False
    StyleElements = []
  end
  object Senha1LabeledEdit: TLabeledEdit [5]
    Left = 27
    Top = 100
    Width = 300
    Height = 23
    EditLabel.Width = 32
    EditLabel.Height = 15
    EditLabel.Caption = 'Senha'
    MaxLength = 20
    PasswordChar = '*'
    TabOrder = 2
    Text = ''
    OnChange = Senha1LabeledEditChange
    OnExit = Senha1LabeledEditExit
    OnKeyPress = Senha1LabeledEditKeyPress
  end
  object NomeDeUsuarioLabeledEdit: TLabeledEdit [6]
    Left = 27
    Top = 45
    Width = 300
    Height = 23
    EditLabel.Width = 92
    EditLabel.Height = 15
    EditLabel.Caption = 'Nome de Usu'#225'rio'
    MaxLength = 20
    TabOrder = 1
    Text = ''
    OnChange = NomeDeUsuarioLabeledEditChange
    OnExit = NomeDeUsuarioLabeledEditExit
    OnKeyPress = NomeDeUsuarioLabeledEditKeyPress
  end
  inherited BasePanel: TPanel
    Top = 338
    Width = 432
    ExplicitTop = 132
    ExplicitWidth = 363
    DesignSize = (
      432
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 161
      ExplicitLeft = 107
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 274
      ExplicitLeft = 220
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 354
      ExplicitLeft = 300
    end
    object SenhaMudarBitBtn_LoginPerg: TBitBtn
      Left = 59
      Top = 6
      Width = 96
      Height = 25
      Action = MensCopyAct_Diag
      Anchors = [akTop, akRight]
      Caption = 'Alterar a Senha'
      TabOrder = 3
      ExplicitLeft = 5
    end
  end
  object TipoPanel: TPanel [8]
    Left = 0
    Top = 0
    Width = 432
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
      Width = 394
      Height = 19
      Align = alClient
      Caption = 'LoginPergModoLabel'
      ExplicitLeft = 6
      ExplicitTop = 4
      ExplicitWidth = 114
      ExplicitHeight = 15
    end
  end
  object Senha2LabeledEdit: TLabeledEdit [9]
    Left = 27
    Top = 155
    Width = 300
    Height = 23
    EditLabel.Width = 77
    EditLabel.Height = 15
    EditLabel.Caption = 'Repita a Senha'
    MaxLength = 20
    PasswordChar = '*'
    TabOrder = 4
    Text = ''
    Visible = False
    OnChange = Senha1LabeledEditChange
    OnExit = Senha2LabeledEditExit
    OnKeyPress = Senha2LabeledEditKeyPress
  end
  object Senha3LabeledEdit: TLabeledEdit [10]
    Left = 27
    Top = 210
    Width = 300
    Height = 23
    EditLabel.Width = 77
    EditLabel.Height = 15
    EditLabel.Caption = 'Repita a Senha'
    MaxLength = 20
    PasswordChar = '*'
    TabOrder = 5
    Text = ''
    Visible = False
    OnChange = Senha1LabeledEditChange
  end
  object UsuGerenteExibSenhaCheckBox: TCheckBox [11]
    Left = 8
    Top = 251
    Width = 97
    Height = 17
    Caption = 'E&xibir senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = UsuGerenteExibSenhaCheckBoxClick
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 163
    Top = 37
  end
  inherited ActionList1_Diag: TActionList
    Left = 203
    Top = 93
  end
end
