inherited DBImportForm: TDBImportForm
  Caption = 'DBImportForm'
  ClientHeight = 427
  ExplicitWidth = 576
  TextHeight = 15
  object TopoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 564
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitWidth = 560
  end
  object BasePanel: TPanel [1]
    Left = 0
    Top = 396
    Width = 564
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitTop = 394
    ExplicitWidth = 560
  end
  object MeioPanel: TPanel [2]
    Left = 0
    Top = 57
    Width = 564
    Height = 339
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    ExplicitWidth = 560
    ExplicitHeight = 337
    object StatusMemo: TMemo
      Left = 0
      Top = 0
      Width = 564
      Height = 338
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
      ExplicitWidth = 560
      ExplicitHeight = 337
    end
  end
end
