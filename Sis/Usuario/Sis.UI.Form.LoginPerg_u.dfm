inherited LoginPergForm: TLoginPergForm
  Caption = 'Login'
  ClientHeight = 388
  ClientWidth = 424
  ExplicitWidth = 436
  ExplicitHeight = 426
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 284
    Width = 424
    Height = 52
    Alignment = taCenter
    AutoSize = False
    Layout = tlCenter
    ExplicitTop = 100
    ExplicitWidth = 379
    ExplicitHeight = 52
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 373
    Width = 424
    ExplicitTop = 373
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
  object UsuGerenteExibSenhaCheckBox: TCheckBox [7]
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
  object Senha2LabeledEdit: TLabeledEdit [8]
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
  object Senha3LabeledEdit: TLabeledEdit [9]
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
  object TipoPanel: TPanel [10]
    Left = 0
    Top = 0
    Width = 424
    Height = 22
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 3
    object ModoTitLabel: TLabel
      Left = 0
      Top = 0
      Width = 9
      Height = 22
      Align = alLeft
      Caption = '   '
      ExplicitHeight = 15
    end
    object LoginPergModoLabel: TLabel
      Left = 9
      Top = 0
      Width = 415
      Height = 22
      Align = alClient
      Caption = 'LoginPergModoLabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7798858
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      StyleElements = []
      ExplicitWidth = 142
      ExplicitHeight = 20
    end
  end
  inherited BasePanel: TPanel
    Top = 336
    Width = 424
    ExplicitTop = 335
    ExplicitWidth = 420
    DesignSize = (
      424
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 137
      ExplicitLeft = 133
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 250
      ExplicitLeft = 246
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 330
      ExplicitLeft = 326
    end
    object SenhaMudarBitBtn_LoginPerg: TBitBtn
      Left = 35
      Top = 6
      Width = 96
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Alterar a Senha'
      TabOrder = 3
      OnClick = MensCopyAct_DiagExecute
      ExplicitLeft = 31
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
