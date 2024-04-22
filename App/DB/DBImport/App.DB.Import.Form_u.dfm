inherited DBImportForm: TDBImportForm
  Caption = 'DBImportForm'
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
    ExplicitWidth = 560
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
    ExplicitWidth = 560
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
    ExplicitWidth = 560
    ExplicitHeight = 337
    object StatusMemo: TMemo
      Left = 0
      Top = 185
      Width = 564
      Height = 153
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
      ExplicitTop = 112
      ExplicitHeight = 226
    end
    object GridsPanel: TPanel
      Left = 0
      Top = 0
      Width = 564
      Height = 185
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      object ProdDBGrid: TDBGrid
        Left = 0
        Top = 0
        Width = 564
        Height = 185
        Align = alClient
        BorderStyle = bsNone
        DataSource = ProdDataSource
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
    end
  end
  object ProdDataSource: TDataSource
    Left = 304
    Top = 89
  end
end
