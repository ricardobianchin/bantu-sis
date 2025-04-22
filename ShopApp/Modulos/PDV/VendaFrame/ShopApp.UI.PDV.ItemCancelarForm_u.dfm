inherited ItemCancelarForm_ShopApp: TItemCancelarForm_ShopApp
  Caption = 'ItemCancelarForm_ShopApp'
  ClientHeight = 319
  ClientWidth = 536
  Font.Height = -15
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 552
  ExplicitHeight = 358
  TextHeight = 20
  inherited MensLabel: TLabel
    Top = 302
    Width = 536
    Height = 17
    Font.Height = -13
    ExplicitTop = 262
    ExplicitWidth = 63
    ExplicitHeight = 17
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 282
    Width = 536
    Height = 20
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 242
    ExplicitWidth = 136
    ExplicitHeight = 20
  end
  object InstrucoesLabel: TLabel [2]
    Left = 8
    Top = 8
    Width = 328
    Height = 20
    Caption = 'Use as setas ['#8593']['#8595'] para escolher o item a cancelar'
  end
  object BotaoCancelarLabel: TLabel [3]
    Left = 142
    Top = 170
    Width = 245
    Height = 32
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Esc - N'#227'o cancelar item'
    Color = 14993837
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    Layout = tlCenter
    StyleElements = []
    OnClick = BotaoCancelarLabelClick
    ExplicitTop = 140
  end
  object BotaoOkLabel: TLabel [4]
    Left = 142
    Top = 213
    Width = 245
    Height = 32
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Enter / Delete - Cancelar item'
    Color = 14993837
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    Layout = tlCenter
    StyleElements = []
    OnClick = BotaoOkLabelClick
    ExplicitTop = 183
  end
  object Label3: TLabel [5]
    Left = 8
    Top = 28
    Width = 80
    Height = 15
    Caption = 'Item a cancelar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object CancelarStatusLabel: TLabel [6]
    Left = 142
    Top = 246
    Width = 80
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = 'Item a cancelar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = []
    ExplicitTop = 216
  end
  object ItemPanel: TPanel [7]
    Left = 8
    Top = 47
    Width = 519
    Height = 97
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    StyleElements = []
    object ItemLabel: TLabel
      Left = 7
      Top = 6
      Width = 504
      Height = 87
      AutoSize = False
      Caption = 'ItemLabel'#13#10'ItemLabel'#13#10'ItemLabel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      StyleElements = []
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 312
    Top = 24
  end
  inherited ActionList1_Diag: TActionList
    Left = 464
    Top = 0
  end
end
