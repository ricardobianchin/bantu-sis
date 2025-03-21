inherited SelectForm: TSelectForm
  BorderStyle = bsNone
  Caption = 'SelectForm'
  ClientHeight = 347
  ClientWidth = 633
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 633
  ExplicitHeight = 347
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 327
    Width = 633
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 312
    Width = 633
    StyleElements = [seFont, seClient, seBorder]
  end
  object FundoPanel: TPanel [2]
    Left = 0
    Top = 0
    Width = 633
    Height = 312
    Align = alClient
    Caption = ' '
    TabOrder = 0
    ExplicitWidth = 185
    ExplicitHeight = 41
    object BasePanel: TPanel
      Left = 1
      Top = 292
      Width = 631
      Height = 19
      Align = alBottom
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      StyleElements = [seClient, seBorder]
      ExplicitTop = 293
      object QtdRegsLabel: TLabel
        Left = 1
        Top = 2
        Width = 9
        Height = 15
        Caption = '   '
      end
    end
  end
end
