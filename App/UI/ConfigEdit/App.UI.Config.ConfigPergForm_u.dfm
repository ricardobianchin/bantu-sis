object ConfigPergForm: TConfigPergForm
  Left = 0
  Top = 0
  Caption = 'ConfigPergForm'
  ClientHeight = 558
  ClientWidth = 920
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDesktopCenter
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 17
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 920
    Height = 558
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitLeft = 175
    ExplicitWidth = 745
    DesignSize = (
      920
      558)
    object ToolBar1: TToolBar
      Left = 16
      Top = 522
      Width = 417
      Height = 28
      Align = alNone
      Anchors = [akLeft, akBottom]
      ButtonHeight = 30
      ButtonWidth = 139
      Caption = 'ToolBar1'
      Images = SisImgDataModule.ImageList24Flat
      List = True
      ShowCaptions = True
      TabOrder = 0
      Transparent = True
      StyleElements = []
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = OkAct
      end
      object ToolButton2: TToolButton
        Left = 139
        Top = 0
        Action = CancelAct
      end
      object ToolButton3: TToolButton
        Left = 278
        Top = 0
        Action = ReloadAct
      end
    end
    object EhServidorCheckBox: TCheckBox
      AlignWithMargins = True
      Left = 16
      Top = 123
      Width = 191
      Height = 17
      Margins.Left = 15
      Margins.Top = 15
      Margins.Right = 0
      Margins.Bottom = 15
      Caption = 'Esta m'#225'quina '#233' o &servidor'
      TabOrder = 2
      OnClick = EhServidorCheckBoxClick
      OnKeyPress = EhServidorCheckBoxKeyPress
    end
    object ToolBar2: TToolBar
      Left = 268
      Top = 43
      Width = 31
      Height = 29
      Align = alNone
      ButtonWidth = 31
      Caption = 'LoginToolBar'
      Images = SisImgDataModule.ImageListLogin16
      TabOrder = 4
      object ToolButton5: TToolButton
        Left = 0
        Top = 0
        Action = BuscaNomeAction
      end
    end
    object ServerConfigLabeledEdit: TLabeledEdit
      AlignWithMargins = True
      Left = 331
      Top = 135
      Width = 440
      Height = 25
      EditLabel.Width = 180
      EditLabel.Height = 17
      EditLabel.Caption = 'Arquivo config.xml do servidor'
      MaxLength = 20
      TabOrder = 6
      Text = ''
    end
    object UsuGerenteGroupBox: TGroupBox
      Left = 7
      Top = 162
      Width = 300
      Height = 337
      Caption = 'Login do Gerente'
      TabOrder = 1
      Visible = False
      object LoginErroLabel: TLabel
        Left = 2
        Top = 322
        Width = 296
        Height = 13
        Align = alBottom
        Caption = 'LojaErroLabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 192
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        Visible = False
        ExplicitWidth = 69
      end
      object ObsLabel: TLabel
        Left = 9
        Top = 306
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
        Left = 103
        Top = 283
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
      object UsuGerenteNomeExibLabeledEdit: TLabeledEdit
        Left = 8
        Top = 99
        Width = 285
        Height = 25
        EditLabel.Width = 119
        EditLabel.Height = 17
        EditLabel.Caption = 'Nome para exibi'#231#227'o'
        MaxLength = 20
        TabOrder = 1
        Text = ''
        OnChange = UsuGerenteNomeExibLabeledEditChange
        OnKeyPress = UsuGerenteNomeExibLabeledEditKeyPress
      end
      object UsuGerenteNomeUsuLabeledEdit: TLabeledEdit
        Left = 8
        Top = 148
        Width = 285
        Height = 25
        EditLabel.Width = 102
        EditLabel.Height = 17
        EditLabel.Caption = 'Nome de usu'#225'rio'
        MaxLength = 20
        TabOrder = 2
        Text = ''
        OnChange = UsuGerenteNomeUsuLabeledEditChange
        OnKeyPress = UsuGerenteNomeUsuLabeledEditKeyPress
      end
      object UsuGerenteSenha1LabeledEdit: TLabeledEdit
        Left = 8
        Top = 198
        Width = 285
        Height = 25
        EditLabel.Width = 35
        EditLabel.Height = 17
        EditLabel.Caption = 'Senha'
        MaxLength = 20
        PasswordChar = '*'
        TabOrder = 3
        Text = ''
        OnChange = UsuGerenteSenha1LabeledEditChange
        OnKeyPress = UsuGerenteSenha1LabeledEditKeyPress
      end
      object UsuGerenteSenha2LabeledEdit: TLabeledEdit
        Left = 8
        Top = 247
        Width = 285
        Height = 25
        EditLabel.Width = 86
        EditLabel.Height = 17
        EditLabel.Caption = 'Repita a senha'
        MaxLength = 20
        PasswordChar = '*'
        TabOrder = 4
        Text = ''
        OnChange = UsuGerenteSenha2LabeledEditChange
        OnKeyPress = UsuGerenteSenha2LabeledEditKeyPress
      end
      object LoginToolBar: TToolBar
        Left = 329
        Top = 143
        Width = 33
        Height = 29
        Align = alNone
        Caption = 'LoginToolBar'
        Images = SisImgDataModule.ImageListLogin16
        TabOrder = 5
        object ToolButton4: TToolButton
          Left = 0
          Top = 0
          Hint = 'Exibe/Oculta a senha'
          Caption = 'Exibir a senha'
          ImageIndex = 0
        end
      end
      object UsuGerenteExibSenhaCheckBox: TCheckBox
        Left = 8
        Top = 285
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
      object UsuGerenteNomeCompletoLabeledEdit: TLabeledEdit
        Left = 9
        Top = 49
        Width = 285
        Height = 25
        EditLabel.Width = 97
        EditLabel.Height = 17
        EditLabel.Caption = 'Nome Completo'
        MaxLength = 60
        TabOrder = 0
        Text = ''
        OnChange = UsuGerenteNomeExibLabeledEditChange
        OnKeyPress = UsuGerenteNomeCompletoLabeledEditKeyPress
      end
    end
    object LojaIdGroupBox: TGroupBox
      Left = 313
      Top = 162
      Width = 300
      Height = 143
      Caption = 'Loja'
      TabOrder = 3
      Visible = False
      DesignSize = (
        300
        143)
      object AjudaLojaLabel: TLabel
        Left = 246
        Top = 16
        Width = 46
        Height = 13
        Hint = 
          #201' o respons'#225'vel t'#233'cnico quem vai cadastrar os funcion'#225'rios, incl' +
          'uindo da ger'#234'ncia, mas n'#227'o ter'#225' direitos de visualizar informa'#231#245 +
          'es cr'#237'ticas da empresa, como RH ou Financeiro'
        CustomHint = BalloonHint1
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'O que '#233'?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object LojaErroLabel: TLabel
        Left = 2
        Top = 128
        Width = 296
        Height = 13
        Align = alBottom
        Caption = 'LojaErroLabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 192
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        Visible = False
        ExplicitWidth = 69
      end
      object LojaIdLabeledEdit: TLabeledEdit
        Left = 9
        Top = 46
        Width = 53
        Height = 25
        Alignment = taCenter
        EditLabel.Width = 43
        EditLabel.Height = 17
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 3
        NumbersOnly = True
        TabOrder = 0
        Text = '1'
        OnKeyPress = LojaIdLabeledEditKeyPress
      end
      object LojaApelidoLabeledEdit: TLabeledEdit
        Left = 9
        Top = 94
        Width = 201
        Height = 25
        EditLabel.Width = 45
        EditLabel.Height = 17
        EditLabel.Caption = 'Apelido'
        MaxLength = 20
        TabOrder = 1
        Text = ''
        OnKeyPress = LojaApelidoLabeledEditKeyPress
      end
    end
    object ServerConfigSelectButton: TButton
      Left = 778
      Top = 135
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 5
    end
  end
  object ActionList1: TActionList
    Images = SisImgDataModule.ImageList24Flat
    Left = 23
    Top = 96
    object OkAct: TAction
      Caption = 'Salvar e fechar'
      ImageIndex = 0
      OnExecute = OkActExecute
    end
    object CancelAct: TAction
      Caption = 'Fechar sem salvar'
      ImageIndex = 1
      OnExecute = CancelActExecute
    end
    object ReloadAct: TAction
      Caption = 'Desfazer'
      ImageIndex = 2
      Visible = False
    end
  end
  object BalloonHint1: TBalloonHint
    Left = 23
    Top = 24
  end
  object ActionList2: TActionList
    Images = SisImgDataModule.ImageListLogin16
    Left = 23
    Top = 216
    object BuscaNomeAction: TAction
      Caption = 'Buscar nome'
      Hint = 'Descobre o nome da m'#225'quina local'
      ImageIndex = 2
      OnExecute = BuscaNomeActionExecute
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 103
    Top = 96
  end
  object ShowTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = ShowTimerTimer
    Left = 104
    Top = 16
  end
end
