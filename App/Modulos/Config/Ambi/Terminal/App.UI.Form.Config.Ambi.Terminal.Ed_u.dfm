inherited TerminalEdDiagForm: TTerminalEdDiagForm
  Caption = 'Terminais'
  ClientHeight = 347
  ClientWidth = 848
  ExplicitWidth = 860
  ExplicitHeight = 385
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 275
    Width = 848
    ExplicitTop = 275
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 332
    Width = 848
    ExplicitTop = 332
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
    Left = 122
    Top = 77
    Width = 27
    Height = 15
    Caption = 'Drive'
  end
  object LetraDoDriveAjudaLabel: TLabel [8]
    Left = 168
    Top = 61
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
    Left = 2
    Top = 77
    Width = 65
    Height = 15
    Caption = 'S'#233'rie da NFE'
  end
  object NFSerieAjudaLabel: TLabel [10]
    Left = 77
    Top = 61
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
  object Label2: TLabel [11]
    Left = 355
    Top = 77
    Width = 43
    Height = 15
    Caption = 'Avan'#231'ar'
  end
  object Label3: TLabel [12]
    Left = 439
    Top = 77
    Width = 127
    Height = 15
    Caption = 'linhas no fim do cupom'
  end
  object TerminalIdObrigatorioLabel: TLabel [13]
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
  object NomeNaRedeAjudaLabel: TLabel [14]
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
  object IPLabel: TLabel [15]
    Left = 544
    Top = 30
    Width = 10
    Height = 15
    Caption = 'IP'
  end
  object ImpressoraLabel: TLabel [16]
    Left = 584
    Top = 77
    Width = 58
    Height = 15
    Caption = 'Impressora'
  end
  inherited BasePanel: TPanel
    Top = 295
    Width = 848
    TabOrder = 13
    ExplicitTop = 294
    ExplicitWidth = 784
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 473
      ExplicitLeft = 409
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 586
      ExplicitLeft = 522
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 666
      ExplicitLeft = 602
    end
  end
  object TerminalIdEdit: TEdit [18]
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
  object ApelidoEdit: TEdit [19]
    Left = 206
    Top = 27
    Width = 137
    Height = 23
    MaxLength = 20
    TabOrder = 1
    Text = '123456789 1234567890'
    OnKeyPress = ApelidoEditKeyPress
  end
  object NomeNaRedeEdit: TEdit [20]
    Left = 432
    Top = 27
    Width = 105
    Height = 23
    MaxLength = 15
    TabOrder = 2
    Text = '123456789 12345'
    OnKeyPress = NomeNaRedeEditKeyPress
  end
  object LetraDoDriveComboBox: TComboBox [21]
    Left = 154
    Top = 74
    Width = 49
    Height = 23
    Style = csDropDownList
    TabOrder = 6
    OnKeyPress = LetraDoDriveComboBoxKeyPress
  end
  object NFSerieEdit: TEdit [22]
    Left = 72
    Top = 74
    Width = 41
    Height = 23
    Alignment = taCenter
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 5
    Text = '123'
    OnKeyPress = NFSerieEditKeyPress
  end
  object GavetaTemCheckBox: TCheckBox [23]
    Left = 214
    Top = 75
    Width = 128
    Height = 17
    Caption = 'Gaveta de Dinheiro'
    TabOrder = 7
    OnKeyPress = GavetaTemCheckBoxKeyPress
  end
  object BalancaGroupBox: TGroupBox [24]
    Left = 2
    Top = 107
    Width = 425
    Height = 105
    Caption = 'Modo da Balan'#231'a'
    TabOrder = 10
    DesignSize = (
      425
      105)
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
      Left = 6
      Top = 74
      Width = 41
      Height = 15
      Caption = 'Modelo'
    end
    object BalancaModoComboBox: TComboBox
      Left = 44
      Top = 34
      Width = 375
      Height = 23
      Style = csDropDownList
      TabOrder = 0
      OnChange = BalancaModoComboBoxChange
      OnKeyPress = BalancaModoComboBoxKeyPress
      Items.Strings = (
        '3;O USUARIO VAI DIGITAR A QUANTIDADE E O PRECO UNITARIO')
    end
    object BalancaComboBox: TComboBox
      Left = 53
      Top = 71
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
  object BarCodigoGroupBox: TGroupBox [25]
    Left = 434
    Top = 107
    Width = 169
    Height = 105
    Caption = 'Layout C'#243'd.Barras de Balan'#231'a'
    TabOrder = 11
    DesignSize = (
      169
      105)
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
  object CuponNLinsFinalEdit: TEdit [26]
    Left = 404
    Top = 74
    Width = 30
    Height = 23
    Alignment = taCenter
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 8
    Text = '23'
    OnKeyPress = CuponNLinsFinalEditKeyPress
  end
  object SempreOffLineCheckBox: TCheckBox [27]
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
  object IPEdit: TEdit [28]
    Left = 557
    Top = 27
    Width = 105
    Height = 23
    MaxLength = 39
    TabOrder = 3
    Text = '123456789 12345'
    OnKeyPress = IPEditKeyPress
  end
  object ImpressoraComboBox: TComboBox [29]
    Left = 648
    Top = 74
    Width = 141
    Height = 23
    CustomHint = BalloonHint1
    Style = csDropDownList
    ItemIndex = 2
    TabOrder = 9
    Text = 'IMPRESSORA FISCAL'
    OnKeyPress = ImpressoraComboBoxKeyPress
    Items.Strings = (
      'SEM IMPRESSORA'
      'IMPRESSORA TESTE'
      'IMPRESSORA FISCAL')
  end
  object AtivoCheckBox: TCheckBox [30]
    Left = 633
    Top = 144
    Width = 167
    Height = 17
    Caption = 'Terminal Ativo no Sistema'
    TabOrder = 12
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 80
    Top = 195
  end
  inherited ActionList1_Diag: TActionList
    Left = 168
    Top = 195
  end
  object BalloonHint1: TBalloonHint
    Left = 191
    Top = 171
  end
end
