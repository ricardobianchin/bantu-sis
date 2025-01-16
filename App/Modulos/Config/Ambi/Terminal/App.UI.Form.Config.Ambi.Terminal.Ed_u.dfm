inherited TerminalEdDiagForm: TTerminalEdDiagForm
  Caption = 'Terminais'
  ClientHeight = 343
  ClientWidth = 848
  ExplicitWidth = 860
  ExplicitHeight = 381
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 271
    Width = 848
    ExplicitTop = 271
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 328
    Width = 848
    ExplicitTop = 328
  end
  object ObjetivoLabel: TLabel [2]
    Left = 2
    Top = 8
    Width = 27
    Height = 15
    Caption = '         '
  end
  object TerminalIdTitLabel: TLabel [3]
    Left = 2
    Top = 30
    Width = 39
    Height = 15
    Caption = 'C'#243'digo'
  end
  object ApelidoLabel: TLabel [4]
    Left = 97
    Top = 30
    Width = 106
    Height = 15
    Caption = 'Nome para Exibi'#231#227'o'
  end
  object ApelidoAjudaLabel: TLabel [5]
    Left = 307
    Top = 14
    Width = 35
    Height = 12
    CustomHint = BalloonHint1
    Alignment = taRightJustify
    Caption = 'O que '#233'?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object NomeNaRedeLabel: TLabel [6]
    Left = 350
    Top = 30
    Width = 78
    Height = 15
    Caption = 'Nome na Rede'
  end
  object Label1: TLabel [7]
    Left = 378
    Top = 201
    Width = 27
    Height = 15
    Caption = 'Drive'
  end
  object LetraDoDriveAjudaLabel: TLabel [8]
    Left = 424
    Top = 185
    Width = 35
    Height = 12
    CustomHint = BalloonHint1
    Alignment = taRightJustify
    Caption = 'O que '#233'?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object NFSerieLabel: TLabel [9]
    Left = 258
    Top = 201
    Width = 65
    Height = 15
    Caption = 'S'#233'rie da NFE'
  end
  object NFSerieAjudaLabel: TLabel [10]
    Left = 333
    Top = 185
    Width = 35
    Height = 12
    CustomHint = BalloonHint1
    Alignment = taRightJustify
    Caption = 'O que '#233'?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object TerminalIdObrigatorioLabel: TLabel [11]
    Left = 42
    Top = 26
    Width = 6
    Height = 20
    Caption = '*'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 166
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
    StyleElements = []
  end
  object NomeNaRedeAjudaLabel: TLabel [12]
    Left = 350
    Top = 50
    Width = 313
    Height = 12
    Caption = 
      'Ou o '#39'Nome'#39' ou o '#39'IP'#39' devem ser preenchidos, ou ambos. IP pode s' +
      'er IPv4 ou IPv6'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
    StyleElements = []
  end
  object IPLabel: TLabel [13]
    Left = 544
    Top = 30
    Width = 10
    Height = 15
    Caption = 'IP'
  end
  inherited BasePanel: TPanel
    Top = 291
    Width = 848
    TabOrder = 12
    ExplicitTop = 290
    ExplicitWidth = 844
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 473
      ExplicitLeft = 469
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 586
      ExplicitLeft = 582
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 666
      ExplicitLeft = 662
    end
  end
  object TerminalIdEdit: TEdit [15]
    Left = 50
    Top = 27
    Width = 41
    Height = 23
    Hint = 'Ligue se este terminal nunca tem acesso '#224' Internet'
    Alignment = taCenter
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 0
    Text = '123'
    OnKeyPress = TerminalIdEditKeyPress
  end
  object ApelidoEdit: TEdit [16]
    Left = 206
    Top = 27
    Width = 137
    Height = 23
    MaxLength = 20
    TabOrder = 1
    Text = '123456789 1234567890'
    OnKeyPress = ApelidoEditKeyPress
  end
  object NomeNaRedeEdit: TEdit [17]
    Left = 432
    Top = 27
    Width = 105
    Height = 23
    MaxLength = 15
    TabOrder = 2
    Text = '123456789 12345'
    OnKeyPress = NomeNaRedeEditKeyPress
  end
  object LetraDoDriveComboBox: TComboBox [18]
    Left = 410
    Top = 198
    Width = 49
    Height = 23
    Style = csDropDownList
    TabOrder = 10
    OnKeyPress = LetraDoDriveComboBoxKeyPress
  end
  object NFSerieEdit: TEdit [19]
    Left = 328
    Top = 198
    Width = 41
    Height = 23
    Alignment = taCenter
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 9
    Text = '123'
    OnKeyPress = NFSerieEditKeyPress
  end
  object BalancaGroupBox: TGroupBox [20]
    Left = 2
    Top = 71
    Width = 425
    Height = 90
    Caption = 'Modo da Balan'#231'a'
    TabOrder = 5
    DesignSize = (
      425
      90)
    object BalancaModoLabel: TLabel
      Left = 6
      Top = 37
      Width = 32
      Height = 15
      Caption = 'Modo'
    end
    object BalancaAjudaLabel: TLabel
      Left = 385
      Top = 16
      Width = 35
      Height = 12
      CustomHint = BalloonHint1
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'O que '#233'?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 401
    end
    object BalancaLabel: TLabel
      Left = 254
      Top = 37
      Width = 41
      Height = 15
      Caption = 'Modelo'
    end
    object BalancaModoComboBox: TComboBox
      Left = 44
      Top = 34
      Width = 199
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = '3;O USUARIO VAI DIGITAR A QUANTIDADE E O PRECO UNITARIO'
      OnChange = BalancaModoComboBoxChange
      OnKeyPress = BalancaModoComboBoxKeyPress
      Items.Strings = (
        '3;O USUARIO VAI DIGITAR A QUANTIDADE E O PRECO UNITARIO')
    end
    object BalancaComboBox: TComboBox
      Left = 301
      Top = 34
      Width = 116
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = '3;O USUARIO VAI DIGITAR A QUANTIDADE E O PRECO UNITARIO'
      Items.Strings = (
        '3;O USUARIO VAI DIGITAR A QUANTIDADE E O PRECO UNITARIO')
    end
  end
  object BarCodigoGroupBox: TGroupBox [21]
    Left = 434
    Top = 71
    Width = 169
    Height = 90
    Caption = 'Layout C'#243'd.Barras de Balan'#231'a'
    TabOrder = 6
    DesignSize = (
      169
      90)
    object BarCodigoIniLabel: TLabel
      Left = 6
      Top = 37
      Width = 29
      Height = 15
      Caption = 'In'#237'cio'
    end
    object BarCodigoTamLabel: TLabel
      Left = 76
      Top = 37
      Width = 49
      Height = 15
      Caption = 'Tamanho'
    end
    object BarCodigoAjudaLabel: TLabel
      Left = 128
      Top = 16
      Width = 35
      Height = 12
      CustomHint = BalloonHint1
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'O que '#233'?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object BarCodigoIniEdit: TEdit
      Left = 38
      Top = 34
      Width = 30
      Height = 23
      Alignment = taCenter
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 0
      Text = '23'
      OnKeyPress = BarCodigoIniEditKeyPress
    end
    object BarCodigoTamEdit: TEdit
      Left = 128
      Top = 34
      Width = 30
      Height = 23
      Alignment = taCenter
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 1
      Text = '123'
      OnKeyPress = BarCodigoTamEditKeyPress
    end
  end
  object SempreOffLineCheckBox: TCheckBox [22]
    Left = 673
    Top = 30
    Width = 103
    Height = 17
    Hint = 'Ligue se este terminal nunca tem acesso '#224' Internet'
    CustomHint = BalloonHint1
    Caption = 'Sempre offline'
    TabOrder = 4
    OnKeyPress = SempreOffLineCheckBoxKeyPress
  end
  object IPEdit: TEdit [23]
    Left = 557
    Top = 27
    Width = 105
    Height = 23
    MaxLength = 39
    TabOrder = 3
    Text = '123456789 12345'
    OnKeyPress = IPEditKeyPress
  end
  object AtivoCheckBox: TCheckBox [24]
    Left = 471
    Top = 201
    Width = 167
    Height = 17
    Caption = 'Terminal Ativo no Sistema'
    Checked = True
    State = cbChecked
    TabOrder = 11
    OnKeyPress = AtivoCheckBoxKeyPress
  end
  object GavetaGroupBox: TGroupBox [25]
    Left = 610
    Top = 71
    Width = 223
    Height = 90
    Hint = 'Comando para acionamento'
    Caption = 'Gaveta de Dinheiro'
    TabOrder = 7
    object GavetaComandoLabel: TLabel
      Left = 7
      Top = 64
      Width = 53
      Height = 15
      Caption = 'Comando'
    end
    object GavetaTemCheckBox: TCheckBox
      Left = 7
      Top = 31
      Width = 128
      Height = 17
      Caption = 'Utiliza'
      TabOrder = 0
      OnKeyPress = GavetaTemCheckBoxKeyPress
    end
    object GavetaComandoEdit: TEdit
      Left = 65
      Top = 61
      Width = 74
      Height = 23
      Hint = 'Comando para acionamento'
      MaxLength = 240
      TabOrder = 1
      OnKeyPress = GavetaComandoEditKeyPress
    end
    object ToolBar1: TToolBar
      Left = 144
      Top = 61
      Width = 69
      Height = 22
      Align = alNone
      Caption = 'ToolBar1'
      Images = SisImgDataModule.ImageList16Flat
      TabOrder = 2
      object GavetaCopiarToolButton: TToolButton
        Left = 0
        Top = 0
        Hint = 'Copiar Comando'
        Caption = 'GavetaCopiarToolButton'
        ImageIndex = 5
      end
      object GavetaColarToolButton: TToolButton
        Left = 23
        Top = 0
        Hint = 'Colar comando'
        Caption = 'GavetaColarToolButton'
        ImageIndex = 4
      end
      object GavetaTestarToolButton: TToolButton
        Left = 46
        Top = 0
        Hint = 'Testar acionamento'
        Caption = 'GavetaTestarToolButton'
        ImageIndex = 6
      end
    end
  end
  object ImpressoraGroupBox: TGroupBox [26]
    Left = 2
    Top = 165
    Width = 243
    Height = 90
    Caption = 'Impressora'
    TabOrder = 8
    object Label2: TLabel
      Left = 5
      Top = 56
      Width = 43
      Height = 15
      Caption = 'Avan'#231'ar'
    end
    object Label3: TLabel
      Left = 89
      Top = 56
      Width = 127
      Height = 15
      Caption = 'linhas no fim do cupom'
    end
    object CuponNLinsFinalEdit: TEdit
      Left = 54
      Top = 53
      Width = 30
      Height = 23
      Alignment = taCenter
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 0
      Text = '23'
      OnKeyPress = CuponNLinsFinalEditKeyPress
    end
    object ImpressoraComboBox: TComboBox
      Left = 5
      Top = 24
      Width = 141
      Height = 23
      CustomHint = BalloonHint1
      Style = csDropDownList
      ItemIndex = 2
      TabOrder = 1
      Text = 'IMPRESSORA FISCAL'
      OnKeyPress = ImpressoraComboBoxKeyPress
      Items.Strings = (
        'SEM IMPRESSORA'
        'IMPRESSORA TESTE'
        'IMPRESSORA FISCAL')
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 256
    Top = 231
  end
  inherited ActionList1_Diag: TActionList
    Left = 360
    Top = 247
  end
  object BalloonHint1: TBalloonHint
    Left = 319
    Top = 247
  end
end
