inherited LoginPergForm: TLoginPergForm
  Caption = 'Login'
  ClientHeight = 562
  ClientWidth = 788
  WindowState = wsMaximized
  ExplicitWidth = 800
  ExplicitHeight = 600
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 458
    Width = 788
    Height = 52
    Alignment = taCenter
    AutoSize = False
    Layout = tlCenter
    ExplicitTop = 100
    ExplicitWidth = 379
    ExplicitHeight = 52
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 547
    Width = 788
    ExplicitTop = 547
  end
  object Logo1Image: TImage [2]
    Left = 0
    Top = 0
    Width = 788
    Height = 100
    Align = alTop
    Center = True
    ExplicitTop = 41
    ExplicitWidth = 628
  end
  inherited BasePanel: TPanel
    Top = 510
    Width = 788
    ExplicitTop = 509
    ExplicitWidth = 784
    DesignSize = (
      788
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 497
      ExplicitLeft = 493
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 610
      ExplicitLeft = 606
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 690
      ExplicitLeft = 686
    end
    object SenhaMudarBitBtn_LoginPerg: TBitBtn
      Left = 395
      Top = 6
      Width = 96
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Alterar a Senha'
      TabOrder = 3
      OnClick = MensCopyAct_DiagExecute
      ExplicitLeft = 391
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 100
    Width = 788
    Height = 358
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 784
    ExplicitHeight = 357
    object ControlesPanel: TPanel
      Left = 61
      Top = -22
      Width = 452
      Height = 415
      BevelOuter = bvNone
      Caption = '  '
      TabOrder = 0
      Visible = False
      object NomeDeUsuarioStatusLabel: TLabel
        Left = 76
        Top = 76
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
      object ObsLabel: TLabel
        Left = 76
        Top = 282
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
      object AvisoSenhaLabel: TLabel
        Left = 170
        Top = 259
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
      object TopoPanel: TPanel
        Left = 0
        Top = 0
        Width = 452
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        Caption = ' '
        TabOrder = 1
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
          Width = 443
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
      object Senha1LabeledEdit: TLabeledEdit
        Left = 76
        Top = 108
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
      object NomeDeUsuarioLabeledEdit: TLabeledEdit
        Left = 76
        Top = 53
        Width = 300
        Height = 23
        EditLabel.Width = 92
        EditLabel.Height = 15
        EditLabel.Caption = 'Nome de Usu'#225'rio'
        MaxLength = 20
        TabOrder = 0
        Text = ''
        OnChange = NomeDeUsuarioLabeledEditChange
        OnExit = NomeDeUsuarioLabeledEditExit
        OnKeyPress = NomeDeUsuarioLabeledEditKeyPress
      end
      object Senha2LabeledEdit: TLabeledEdit
        Left = 76
        Top = 163
        Width = 300
        Height = 23
        EditLabel.Width = 77
        EditLabel.Height = 15
        EditLabel.Caption = 'Repita a Senha'
        MaxLength = 20
        PasswordChar = '*'
        TabOrder = 3
        Text = ''
        Visible = False
        OnChange = Senha1LabeledEditChange
        OnExit = Senha2LabeledEditExit
        OnKeyPress = Senha2LabeledEditKeyPress
      end
      object Senha3LabeledEdit: TLabeledEdit
        Left = 76
        Top = 218
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
        OnExit = Senha3LabeledEditExit
        OnKeyPress = Senha3LabeledEditKeyPress
      end
      object UsuGerenteExibSenhaCheckBox: TCheckBox
        Left = 75
        Top = 259
        Width = 97
        Height = 17
        Caption = 'E&xibir senha'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = UsuGerenteExibSenhaCheckBoxClick
      end
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 139
    Top = 141
  end
  inherited ActionList1_Diag: TActionList
    Left = 203
    Top = 133
  end
end
