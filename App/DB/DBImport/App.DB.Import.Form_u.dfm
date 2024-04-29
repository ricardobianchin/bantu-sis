inherited DBImportForm: TDBImportForm
  Caption = 'DBImportForm'
  ClientHeight = 612
  ClientWidth = 838
  WindowState = wsMaximized
  ExplicitTop = -316
  ExplicitWidth = 850
  ExplicitHeight = 650
  TextHeight = 15
  object TopoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 838
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitWidth = 704
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
    object AtualizarBitBtn_AppDBImport: TBitBtn
      Left = 728
      Top = 7
      Width = 75
      Height = 25
      Action = AtualizarAction_AppDBImport
      Caption = 'Atualizar'
      TabOrder = 2
    end
  end
  object BasePanel: TPanel [1]
    Left = 0
    Top = 532
    Width = 838
    Height = 80
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    DesignSize = (
      838
      80)
    object ProgressBar1: TProgressBar
      Left = 559
      Top = 60
      Width = 276
      Height = 17
      Anchors = [akTop, akRight]
      TabOrder = 0
      Visible = False
    end
    object StatusMemo: TMemo
      Left = 0
      Top = 0
      Width = 838
      Height = 57
      Align = alTop
      BorderStyle = bsNone
      TabOrder = 1
    end
  end
  object MeioPanel: TPanel [2]
    Left = 0
    Top = 41
    Width = 838
    Height = 491
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    ExplicitWidth = 704
    ExplicitHeight = 438
    object SplitterStatusMemo: TSplitter
      Left = 0
      Top = 486
      Width = 838
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 185
      ExplicitWidth = 119
    end
    object GridsPanel: TPanel
      Left = 0
      Top = 0
      Width = 838
      Height = 486
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 704
      ExplicitHeight = 306
      object ProdDBGrid: TDBGrid
        Left = 0
        Top = 0
        Width = 838
        Height = 486
        Align = alClient
        BorderStyle = bsNone
        DataSource = ProdDataSource
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
    object AtualizarAction_AppDBImport: TAction
      Caption = 'Atualizar'
    end
  end
end
