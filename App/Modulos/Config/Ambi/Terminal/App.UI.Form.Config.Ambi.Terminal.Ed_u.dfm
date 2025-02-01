inherited TerminalEdDiagForm: TTerminalEdDiagForm
  Caption = 'Terminais'
  ClientHeight = 511
  ClientWidth = 974
  ExplicitWidth = 986
  ExplicitHeight = 549
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 439
    Width = 974
    ExplicitTop = 439
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 496
    Width = 974
    ExplicitTop = 496
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
    Left = 880
    Top = 333
    Width = 27
    Height = 15
    Caption = 'Drive'
  end
  object LetraDoDriveAjudaLabel: TLabel [8]
    Left = 926
    Top = 317
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
    Left = 759
    Top = 333
    Width = 65
    Height = 15
    Caption = 'S'#233'rie da NFE'
  end
  object NFSerieAjudaLabel: TLabel [10]
    Left = 835
    Top = 317
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
    Top = 459
    Width = 974
    TabOrder = 12
    ExplicitTop = 458
    ExplicitWidth = 970
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 579
      ExplicitLeft = 575
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 692
      ExplicitLeft = 688
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 772
      ExplicitLeft = 768
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
    Left = 912
    Top = 330
    Width = 49
    Height = 23
    Style = csDropDownList
    TabOrder = 10
    OnKeyPress = LetraDoDriveComboBoxKeyPress
  end
  object NFSerieEdit: TEdit [19]
    Left = 830
    Top = 330
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
    Height = 154
    Caption = 'Modo da Balan'#231'a'
    TabOrder = 5
    DesignSize = (
      425
      154)
    object BalancaModoUsoLabel: TLabel
      Left = 6
      Top = 36
      Width = 32
      Height = 15
      Caption = 'Modo'
    end
    object BalancaAjudaLabel: TLabel
      Left = 382
      Top = 17
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
      Top = 36
      Width = 41
      Height = 15
      Caption = 'Modelo'
    end
    object BalModoUsoComboBox: TComboBox
      Left = 44
      Top = 33
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
      Top = 33
      Width = 116
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = '3;O USUARIO VAI DIGITAR A QUANTIDADE E O PRECO UNITARIO'
      OnKeyPress = BalComboBoxKeyPress
      Items.Strings = (
        '3;O USUARIO VAI DIGITAR A QUANTIDADE E O PRECO UNITARIO')
    end
    object NumEditBtu1: TNumEditBtu
      Left = 84
      Top = 62
      Width = 121
      Height = 23
      Alignment = taCenter
      AutoExit = False
      Caption = 'NumEditBtu1'
      EditLabel.Width = 71
      EditLabel.Height = 23
      EditLabel.Caption = 'NumEditBtu1'
      LabelPosition = lpLeft
      LabelSpacing = 4
      ReadOnly = False
      TabOrder = 2
      Text = '0'
      NCasas = 0
      NCasasEsq = 0
      Valor = 0
      MascEsq = '########0'
    end
  end
  object BarCodigoGroupBox: TGroupBox [21]
    Left = 434
    Top = 71
    Width = 170
    Height = 102
    Caption = 'Layout C'#243'd.Barras de Balan'#231'a'
    TabOrder = 6
    DesignSize = (
      170
      102)
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
    Left = 757
    Top = 390
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
    Width = 267
    Height = 102
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
    Left = 86
    Top = 272
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
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 424
    Top = 225
  end
  inherited ActionList1_Diag: TActionList
    Left = 312
    Top = 212
  end
  object BalloonHint1: TBalloonHint
    Left = 215
    Top = 207
  end
end
