inherited LoginPergForm: TLoginPergForm
  Caption = 'Login'
  ClientHeight = 389
  ClientWidth = 428
  ExplicitWidth = 444
  ExplicitHeight = 428
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 285
    Width = 428
    Height = 52
    Alignment = taCenter
    AutoSize = False
    Layout = tlCenter
    ExplicitTop = 100
    ExplicitWidth = 379
    ExplicitHeight = 52
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 374
    Width = 428
    ExplicitTop = 374
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
  object TipoPanel: TPanel [5]
    Left = 0
    Top = 0
    Width = 428
    Height = 19
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 3
    object ModoTitLabel: TLabel
      Left = 0
      Top = 0
      Width = 38
      Height = 15
      Align = alLeft
      Caption = 'Modo: '
    end
    object LoginPergModoLabel: TLabel
      Left = 38
      Top = 0
      Width = 114
      Height = 15
      Align = alClient
      Caption = 'LoginPergModoLabel'
    end
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
  object Senha3LabeledEdit: TLabeledEdit [7]
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
    OnExit = Senha3LabeledEditExit
    OnKeyPress = Senha3LabeledEditKeyPress
  end
  object UsuGerenteExibSenhaCheckBox: TCheckBox [8]
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
  object Senha1LabeledEdit: TLabeledEdit [9]
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
  object Senha2LabeledEdit: TLabeledEdit [10]
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
  inherited BasePanel: TPanel
    Top = 337
    Width = 428
    ExplicitTop = 337
    ExplicitWidth = 428
    DesignSize = (
      428
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 149
      ExplicitLeft = 149
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 262
      ExplicitLeft = 262
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 342
      ExplicitLeft = 342
    end
    object SenhaMudarBitBtn_LoginPerg: TBitBtn
      Left = 47
      Top = 6
      Width = 96
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Alterar a Senha'
      TabOrder = 3
      OnClick = MensCopyAct_DiagExecute
    end
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
