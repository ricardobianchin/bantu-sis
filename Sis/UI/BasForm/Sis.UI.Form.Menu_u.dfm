inherited MenuForm: TMenuForm
  BorderStyle = bsNone
  Caption = 'MenuForm'
  ClientHeight = 321
  ClientWidth = 637
  ExplicitWidth = 637
  ExplicitHeight = 321
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 301
    Width = 637
    ExplicitTop = 301
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 286
    Width = 637
    ExplicitTop = 286
  end
  object FundoPanel_AppMenuForm: TPanel [2]
    Left = 0
    Top = 0
    Width = 637
    Height = 286
    Align = alClient
    Caption = ' '
    TabOrder = 0
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
