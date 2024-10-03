inherited TerminalEdDiagForm: TTerminalEdDiagForm
  Caption = 'TerminalEdDiagForm'
  ClientHeight = 297
  ClientWidth = 654
  ExplicitWidth = 666
  ExplicitHeight = 335
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 225
    Width = 654
    ExplicitTop = 225
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 282
    Width = 654
    ExplicitTop = 282
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
    Left = 351
    Top = 30
    Width = 78
    Height = 15
    Caption = 'Nome na Rede'
  end
  object Label1: TLabel [7]
    Left = 122
    Top = 74
    Width = 27
    Height = 15
    Caption = 'Drive'
  end
  object LetraDoDriveAjudaLabel: TLabel [8]
    Left = 168
    Top = 58
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
    Top = 74
    Width = 65
    Height = 15
    Caption = 'S'#233'rie da NFE'
  end
  object NFSerieAjudaLabel: TLabel [10]
    Left = 77
    Top = 58
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
    Top = 74
    Width = 43
    Height = 15
    Caption = 'Avan'#231'ar'
  end
  object Label3: TLabel [12]
    Left = 439
    Top = 74
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
  object NomeNaRedeObrigatorioLabel: TLabel [14]
    Left = 429
    Top = 22
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
  inherited BasePanel: TPanel
    Top = 245
    Width = 654
    TabOrder = 10
    ExplicitTop = 244
    ExplicitWidth = 650
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 307
      ExplicitLeft = 303
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 420
      ExplicitLeft = 416
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 500
      ExplicitLeft = 496
    end
  end
  object TerminalIdEdit: TEdit [16]
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
  object ApelidoEdit: TEdit [17]
    Left = 206
    Top = 27
    Width = 137
    Height = 23
    MaxLength = 20
    TabOrder = 1
    Text = '123456789 1234567890'
    OnKeyPress = ApelidoEditKeyPress
  end
  object NomeNaRedeEdit: TEdit [18]
    Left = 437
    Top = 27
    Width = 105
    Height = 23
    MaxLength = 15
    TabOrder = 2
    Text = '123456789 12345'
    OnKeyPress = NomeNaRedeEditKeyPress
  end
  object LetraDoDriveComboBox: TComboBox [19]
    Left = 154
    Top = 71
    Width = 49
    Height = 23
    Style = csDropDownList
    TabOrder = 5
    OnKeyPress = LetraDoDriveComboBoxKeyPress
  end
  object NFSerieEdit: TEdit [20]
    Left = 72
    Top = 71
    Width = 41
    Height = 23
    Alignment = taCenter
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 4
    Text = '123'
    OnKeyPress = NFSerieEditKeyPress
  end
  object GavetaTemCheckBox: TCheckBox [21]
    Left = 214
    Top = 72
    Width = 128
    Height = 17
    Caption = 'Gaveta de Dinheiro'
    TabOrder = 6
    OnKeyPress = GavetaTemCheckBoxKeyPress
  end
  object BalancaGroupBox: TGroupBox [22]
    Left = 2
    Top = 104
    Width = 441
    Height = 105
    Caption = 'Modo da Balan'#231'a'
    TabOrder = 8
    DesignSize = (
      441
      105)
    object BalancaModoLabel: TLabel
      Left = 6
      Top = 37
      Width = 32
      Height = 15
      Caption = 'Modo'
    end
    object BalancaAjudaLabel: TLabel
      Left = 401
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
  object BarCodigoGroupBox: TGroupBox [23]
    Left = 456
    Top = 104
    Width = 169
    Height = 105
    Caption = 'Layout C'#243'd.Barras de Balan'#231'a'
    TabOrder = 9
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
  object CuponNLinsFinalEdit: TEdit [24]
    Left = 404
    Top = 71
    Width = 30
    Height = 23
    Alignment = taCenter
    MaxLength = 3
    NumbersOnly = True
    TabOrder = 7
    Text = '23'
    OnKeyPress = CuponNLinsFinalEditKeyPress
  end
  object SempreOffLineCheckBox: TCheckBox [25]
    Left = 547
    Top = 30
    Width = 103
    Height = 17
    Hint = 'Ligue se este terminal nunca tem acesso '#224' Internet'
    CustomHint = BalloonHint1
    Caption = 'Sempre offline'
    TabOrder = 3
    OnKeyPress = SempreOffLineCheckBoxKeyPress
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 80
    Top = 224
  end
  inherited ActionList1_Diag: TActionList
    Left = 168
    Top = 192
  end
  object BalloonHint1: TBalloonHint
    Left = 191
    Top = 200
  end
end
