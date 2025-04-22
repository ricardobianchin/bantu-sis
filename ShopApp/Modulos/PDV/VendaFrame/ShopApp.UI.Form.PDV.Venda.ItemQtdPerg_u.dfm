inherited ItemQtdPergForm: TItemQtdPergForm
  Caption = 'Alterar Quantidade do Item'
  ClientHeight = 300
  ClientWidth = 538
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 554
  ExplicitHeight = 339
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 228
    Width = 538
    ExplicitTop = 228
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 285
    Width = 538
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 285
  end
  object ProdLabel: TLabel [2]
    Left = 2
    Top = 8
    Width = 511
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'ProdLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
    StyleElements = []
  end
  object QtdNumEditBtu: TNumEditBtu [3]
    Left = 104
    Top = 128
    Width = 121
    Height = 28
    AutoExit = True
    Caption = 'Quantidade'
    EditLabel.Width = 78
    EditLabel.Height = 28
    EditLabel.Caption = 'Quantidade'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -15
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    LabelPosition = lpLeft
    LabelSpacing = 4
    ParentFont = False
    ReadOnly = False
    TabOrder = 1
    Text = '0,000'
    OnChange = QtdNumEditBtuChange
    OnKeyPress = QtdNumEditBtuKeyPress
    NCasas = 3
    NCasasEsq = 7
    Valor = 0
    MascEsq = '######0'
  end
  object PrecoNumEditBtu: TNumEditBtu [4]
    Left = 104
    Top = 168
    Width = 121
    Height = 28
    TabStop = False
    AutoExit = True
    Caption = 'Pre'#231'o'
    EditLabel.Width = 37
    EditLabel.Height = 28
    EditLabel.Caption = 'Pre'#231'o'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -15
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    LabelPosition = lpLeft
    LabelSpacing = 4
    ParentFont = False
    ReadOnly = False
    TabOrder = 2
    Text = '0,00'
    NCasas = 2
    NCasasEsq = 7
    Valor = 0
    MascEsq = '######0'
  end
  object PrecoUnitNumEditBtu: TNumEditBtu [5]
    Left = 104
    Top = 88
    Width = 121
    Height = 28
    AutoExit = True
    Caption = 'Pre'#231'o Unit'#225'rio'
    EditLabel.Width = 94
    EditLabel.Height = 28
    EditLabel.Caption = 'Pre'#231'o Unit'#225'rio'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -15
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    LabelPosition = lpLeft
    LabelSpacing = 4
    ParentFont = False
    ReadOnly = False
    TabOrder = 0
    Text = '0,00'
    NCasas = 2
    NCasasEsq = 7
    Valor = 0
    MascEsq = '######0'
  end
  inherited BasePanel: TPanel
    Top = 248
    Width = 538
    TabOrder = 3
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 248
    ExplicitWidth = 538
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 199
      ExplicitLeft = 199
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 328
      ExplicitLeft = 328
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 424
      ExplicitLeft = 424
    end
  end
end
