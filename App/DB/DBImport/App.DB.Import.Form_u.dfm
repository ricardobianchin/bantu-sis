inherited DBImportForm: TDBImportForm
  Caption = 'DBImportForm'
  ClientHeight = 511
  ClientWidth = 708
  WindowState = wsMaximized
  ExplicitWidth = 724
  ExplicitHeight = 550
  TextHeight = 15
  object TopoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 708
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitWidth = 620
    object ExecuteBitBtn: TBitBtn
      Left = 537
      Top = 7
      Width = 90
      Height = 25
      Action = ExecuteAction_AppDBImport
      Caption = 'Execute'
      TabOrder = 0
    end
    object ZerarBitBtn: TBitBtn
      Left = 633
      Top = 7
      Width = 90
      Height = 25
      Action = ZerarExecuteAction_AppDBImport
      Caption = 'Apagar Dados'
      TabOrder = 1
    end
  end
  object BasePanel: TPanel [1]
    Left = 0
    Top = 480
    Width = 708
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitTop = 479
    ExplicitWidth = 620
    object ProgressBar1: TProgressBar
      Left = 8
      Top = 8
      Width = 500
      Height = 17
      TabOrder = 0
      Visible = False
    end
  end
  object MeioPanel: TPanel [2]
    Left = 0
    Top = 41
    Width = 708
    Height = 439
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    ExplicitWidth = 620
    ExplicitHeight = 438
    object SplitterStatusMemo: TSplitter
      Left = 0
      Top = 307
      Width = 708
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 185
      ExplicitWidth = 119
    end
    object StatusMemo: TMemo
      Left = 0
      Top = 312
      Width = 708
      Height = 127
      Align = alBottom
      BorderStyle = bsNone
      TabOrder = 0
      ExplicitTop = 311
      ExplicitWidth = 620
    end
    object GridsPanel: TPanel
      Left = 0
      Top = 0
      Width = 708
      Height = 307
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      ExplicitWidth = 620
      ExplicitHeight = 306
      object ProdDBGrid: TDBGrid
        Left = 0
        Top = 0
        Width = 708
        Height = 307
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
    end
    object ZerarExecuteAction_AppDBImport: TAction
      Caption = 'Apagar Dados'
      OnExecute = ZerarExecuteAction_AppDBImportExecute
    end
  end
end
