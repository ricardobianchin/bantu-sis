inherited DBImportForm: TDBImportForm
  Caption = 'DBImportForm'
  OnCreate = FormCreate
  ExplicitWidth = 576
  ExplicitHeight = 464
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
  end
  object BasePanel: TPanel [1]
    Left = 0
    Top = 395
    Width = 564
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitTop = 394
  end
  object MeioPanel: TPanel [2]
    Left = 0
    Top = 57
    Width = 564
    Height = 338
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    ExplicitTop = 8
    ExplicitHeight = 57
    object StatusMemo: TMemo
      Left = 0
      Top = 0
      Width = 564
      Height = 338
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
    end
  end
end
