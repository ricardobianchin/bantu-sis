inherited MenuForm: TMenuForm
  BorderStyle = bsNone
  Caption = 'MenuForm'
  ClientHeight = 274
  ClientWidth = 500
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 500
  ExplicitHeight = 274
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 254
    Width = 500
    ExplicitTop = 301
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 239
    Width = 500
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 286
  end
  object FundoPanel_AppMenuForm: TPanel [2]
    Left = 0
    Top = 0
    Width = 500
    Height = 239
    Align = alClient
    Caption = ' '
    TabOrder = 0
    ExplicitWidth = 637
    ExplicitHeight = 286
    object BotoesPanel: TPanel
      Left = 16
      Top = 40
      Width = 569
      Height = 217
      BevelOuter = bvNone
      Caption = '      '
      TabOrder = 0
    end
  end
end
