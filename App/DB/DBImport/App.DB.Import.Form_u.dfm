inherited DBImportForm: TDBImportForm
  Caption = 'DBImportForm'
  ClientHeight = 512
  ClientWidth = 628
  WindowState = wsMaximized
  ExplicitTop = -181
  ExplicitWidth = 640
  ExplicitHeight = 550
  TextHeight = 15
  object TopoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 628
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object ExecuteBitBtn: TBitBtn
      Left = 536
      Top = 7
      Width = 75
      Height = 25
      Action = ExecuteAction_AppDBImport
      Caption = 'Execute'
      TabOrder = 0
    end
  end
  object BasePanel: TPanel [1]
    Left = 0
    Top = 481
    Width = 628
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
    Top = 41
    Width = 628
    Height = 440
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    ExplicitTop = 38
    object SplitterStatusMemo: TSplitter
      Left = 0
      Top = 308
      Width = 628
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 185
      ExplicitWidth = 119
    end
    object StatusMemo: TMemo
      Left = 0
      Top = 313
      Width = 628
      Height = 127
      Align = alBottom
      BorderStyle = bsNone
      TabOrder = 0
      ExplicitTop = 312
    end
    object GridsPanel: TPanel
      Left = 0
      Top = 0
      Width = 628
      Height = 308
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      ExplicitWidth = 564
      ExplicitHeight = 185
      object ProdDBGrid: TDBGrid
        Left = 0
        Top = 0
        Width = 628
        Height = 308
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
    Top = 57
  end
  object ActionList_AppDBImport: TActionList
    Left = 400
    Top = 81
    object ExecuteAction_AppDBImport: TAction
      Caption = 'Execute'
      OnExecute = ExecuteAction_AppDBImportExecute
    end
  end
end
