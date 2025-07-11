inherited TerminalEdDiagForm: TTerminalEdDiagForm
  Caption = 'Terminais'
  ClientHeight = 423
  ClientWidth = 931
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 947
  ExplicitHeight = 462
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 351
    Width = 931
    ExplicitTop = 351
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 408
    Width = 931
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 408
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
  object LetraDoDriveLabel: TLabel [7]
    Left = 741
    Top = 237
    Width = 27
    Height = 15
    Caption = 'Drive'
  end
  object LetraDoDriveAjudaLabel: TLabel [8]
    Left = 787
    Top = 221
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
    Left = 620
    Top = 237
    Width = 65
    Height = 15
    Caption = 'S'#233'rie da NFE'
  end
  object NFSerieAjudaLabel: TLabel [10]
    Left = 696
    Top = 221
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
    Top = 371
    Width = 931
    TabOrder = 12
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 371
    ExplicitWidth = 931
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 532
      ExplicitLeft = 532
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 645
      ExplicitLeft = 645
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 725
      ExplicitLeft = 725
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
    Left = 773
    Top = 234
    Width = 49
    Height = 23
    Style = csDropDownList
    TabOrder = 10
    OnKeyPress = LetraDoDriveComboBoxKeyPress
  end
  object NFSerieEdit: TEdit [19]
    Left = 691
    Top = 234
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
    Width = 464
    Height = 120
    Caption = 'Modo da Balan'#231'a'
    TabOrder = 5
    DesignSize = (
      464
      120)
    object BalancaModoUsoLabel: TLabel
      Left = 6
      Top = 29
      Width = 32
      Height = 15
      Caption = 'Modo'
    end
    object BalancaAjudaLabel: TLabel
      Left = 421
      Top = 12
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
    object BalancaLabel: TLabel
      Left = 254
      Top = 29
      Width = 41
      Height = 15
      Caption = 'Modelo'
    end
    object Label3: TLabel
      Left = 6
      Top = 61
      Width = 28
      Height = 15
      Caption = 'Porta'
    end
    object BaudRateLabel: TLabel
      Left = 193
      Top = 61
      Width = 50
      Height = 15
      Caption = 'BaudRate'
    end
    object DataBitsLabel: TLabel
      Left = 326
      Top = 61
      Width = 43
      Height = 15
      Caption = 'DataBits'
    end
    object ParidadeLabel: TLabel
      Left = 6
      Top = 93
      Width = 46
      Height = 15
      Caption = 'Paridade'
    end
    object StopBitsLabel: TLabel
      Left = 129
      Top = 93
      Width = 43
      Height = 15
      Caption = 'StopBits'
    end
    object HandShakingLabel: TLabel
      Left = 239
      Top = 93
      Width = 71
      Height = 15
      Caption = 'HandShaking'
    end
    object BalModoUsoComboBox: TComboBox
      Left = 44
      Top = 26
      Width = 199
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = '3;O USUARIO VAI DIGITAR A QUANTIDADE E O PRECO UNITARIO'
      OnKeyPress = BalModoUsoComboBoxKeyPress
      Items.Strings = (
        '3;O USUARIO VAI DIGITAR A QUANTIDADE E O PRECO UNITARIO')
    end
    object BalComboBox: TComboBox
      Left = 301
      Top = 26
      Width = 156
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'TOLEDO9091_8530_8540'
      OnKeyPress = BalComboBoxKeyPress
      Items.Strings = (
        'TOLEDO9091_8530_8540')
    end
    object BalPortaComboBox: TComboBox
      Left = 38
      Top = 58
      Width = 147
      Height = 23
      Style = csDropDownList
      ItemIndex = 8
      TabOrder = 2
      Text = 'TCP:192.168.0.31:9100'
      OnKeyPress = BalComboBoxKeyPress
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'LPT1'
        'LPT2'
        'LPT3'
        'LPT4'
        'TCP:192.168.0.31:9100')
    end
    object BaudRateComboBox: TComboBox
      Left = 249
      Top = 58
      Width = 71
      Height = 23
      Style = csDropDownList
      ItemIndex = 11
      TabOrder = 3
      Text = '57600'
      OnKeyPress = BalComboBoxKeyPress
      Items.Strings = (
        '110'
        '300'
        '600'
        '1200'
        '2400'
        '4800'
        '9600'
        '14400'
        '19200'
        '38400'
        '56000'
        '57600')
    end
    object DataBitsComboBox: TComboBox
      Left = 374
      Top = 58
      Width = 38
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 4
      Text = '5'
      OnKeyPress = BalComboBoxKeyPress
      Items.Strings = (
        '5'
        '6'
        '7'
        '8')
    end
    object ParidadeComboBox: TComboBox
      Left = 57
      Top = 90
      Width = 65
      Height = 23
      Style = csDropDownList
      ItemIndex = 4
      TabOrder = 5
      Text = 'space'
      OnKeyPress = BalComboBoxKeyPress
      Items.Strings = (
        'none'
        'odd'
        'even'
        'mark'
        'space')
    end
    object StopBitsComboBox: TComboBox
      Left = 179
      Top = 90
      Width = 54
      Height = 23
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 6
      Text = 's1,5'
      OnKeyPress = BalComboBoxKeyPress
      Items.Strings = (
        's1'
        's1,5'
        's2')
    end
    object HandShakingComboBox: TComboBox
      Left = 316
      Top = 90
      Width = 91
      Height = 23
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 7
      Text = 'XON/XOFF'
      OnKeyPress = BalComboBoxKeyPress
      Items.Strings = (
        'Nenhum'
        'XON/XOFF'
        'RTS/CTS'
        'DTR/DSR')
    end
  end
  object BarCodigoGroupBox: TGroupBox [21]
    Left = 473
    Top = 71
    Width = 170
    Height = 120
    Caption = 'Layout C'#243'd.Barras de Balan'#231'a'
    TabOrder = 6
    DesignSize = (
      170
      120)
    object BarCodigoIniLabel: TLabel
      Left = 6
      Top = 41
      Width = 29
      Height = 15
      Caption = 'In'#237'cio'
    end
    object BarCodigoTamLabel: TLabel
      Left = 76
      Top = 41
      Width = 49
      Height = 15
      Caption = 'Tamanho'
    end
    object BarCodigoAjudaLabel: TLabel
      Left = 124
      Top = 22
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
      ExplicitLeft = 123
    end
    object BarCodigoIniEdit: TEdit
      Left = 38
      Top = 38
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
      Top = 38
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
    Left = 672
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
    Left = 618
    Top = 294
    Width = 167
    Height = 17
    Caption = 'Terminal Ativo no Sistema'
    Checked = True
    State = cbChecked
    TabOrder = 11
    OnKeyPress = AtivoCheckBoxKeyPress
  end
  object GavetaGroupBox: TGroupBox [25]
    Left = 649
    Top = 71
    Width = 267
    Height = 120
    Hint = 'Comando para acionamento'
    Caption = 'Gaveta de Dinheiro'
    TabOrder = 7
    object GavComandoLabel: TLabel
      Left = 7
      Top = 74
      Width = 53
      Height = 15
      Caption = 'Comando'
    end
    object GavImprNomeLabel: TLabel
      Left = 8
      Top = 46
      Width = 110
      Height = 15
      Caption = 'Nome da Impressora'
    end
    object GavTemCheckBox: TCheckBox
      Left = 7
      Top = 20
      Width = 71
      Height = 17
      Caption = 'Utiliza'
      TabOrder = 0
      OnKeyPress = GavTemCheckBoxKeyPress
    end
    object GavComandoEdit: TEdit
      Left = 65
      Top = 71
      Width = 121
      Height = 23
      Hint = 'Comando para acionamento'
      MaxLength = 240
      TabOrder = 2
      OnKeyPress = GavComandoEditKeyPress
    end
    object GavComandoToolBar: TToolBar
      Left = 192
      Top = 72
      Width = 69
      Height = 22
      Align = alNone
      Caption = 'GavComandoToolBar'
      Images = SisImgDataModule.ImageList16Flat
      TabOrder = 3
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
    object GavImprNomeEdit: TEdit
      Left = 124
      Top = 43
      Width = 135
      Height = 23
      Hint = 'Comando para acionamento'
      MaxLength = 260
      TabOrder = 1
      OnKeyPress = GavImprNomeEditKeyPress
    end
  end
  object ImpressoraGroupBox: TGroupBox [26]
    Left = 2
    Top = 200
    Width = 602
    Height = 121
    Caption = 'Impressora'
    TabOrder = 8
    object Label1: TLabel
      Left = 6
      Top = 74
      Width = 110
      Height = 15
      Caption = 'Nome da Impressora'
    end
    object Label2: TLabel
      Left = 6
      Top = 58
      Width = 230
      Height = 12
      Caption = 'Spool: Envia ao atalho da impressora no Painel de Controle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      StyleElements = []
    end
    object ImprModoEnvioLabel: TLabel
      Left = 6
      Top = 18
      Width = 80
      Height = 15
      Caption = 'Modo de Envio'
    end
    object ImprModeloLabel: TLabel
      Left = 262
      Top = 18
      Width = 41
      Height = 15
      Caption = 'Modelo'
    end
    object ImprQtdColunasLabel: TLabel
      Left = 518
      Top = 18
      Width = 69
      Height = 15
      Caption = 'Qtd. Colunas'
    end
    object CupomQtdLinsFinal1Label: TLabel
      Left = 253
      Top = 95
      Width = 43
      Height = 15
      Caption = 'Avan'#231'ar'
    end
    object CupomQtdLinsFinal2Label: TLabel
      Left = 337
      Top = 95
      Width = 127
      Height = 15
      Caption = 'linhas no fim do cupom'
    end
    object ImprModoEnvioComboBox: TComboBox
      Left = 6
      Top = 34
      Width = 249
      Height = 23
      CustomHint = BalloonHint1
      Style = csDropDownList
      TabOrder = 0
      OnKeyPress = ImprModoEnvioComboBoxKeyPress
      Items.Strings = (
        'SEM IMPRESSORA'
        'SPOOL DE IMPRESSAO DO WINDOWS')
    end
    object ImprNomeEdit: TEdit
      Left = 6
      Top = 91
      Width = 237
      Height = 23
      Hint = 'Comando para acionamento'
      MaxLength = 260
      TabOrder = 1
      OnKeyPress = ImprNomeEditKeyPress
    end
    object ImprModeloComboBox: TComboBox
      Left = 262
      Top = 34
      Width = 249
      Height = 23
      CustomHint = BalloonHint1
      Style = csDropDownList
      TabOrder = 2
      OnKeyPress = ImprModeloComboBoxKeyPress
      Items.Strings = (
        'IMPRESSORA TEXTO')
    end
    object ImprQtdColunasEdit: TEdit
      Left = 518
      Top = 34
      Width = 69
      Height = 23
      Alignment = taCenter
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 3
      Text = '23'
      OnKeyPress = ImprQtdColunasEditKeyPress
    end
    object CupomQtdLinsFinalEdit: TEdit
      Left = 301
      Top = 92
      Width = 30
      Height = 23
      Alignment = taCenter
      MaxLength = 3
      NumbersOnly = True
      TabOrder = 4
      Text = '23'
      OnKeyPress = CupomQtdLinsFinalEditKeyPress
    end
    object Button1: TButton
      Left = 496
      Top = 80
      Width = 55
      Height = 25
      Caption = 'Teste'
      TabOrder = 5
      OnClick = Button1Click
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 624
    Top = 89
  end
  inherited ActionList1_Diag: TActionList
    Left = 544
    Top = 108
  end
  object BalloonHint1: TBalloonHint
    Left = 495
    Top = 79
  end
end
