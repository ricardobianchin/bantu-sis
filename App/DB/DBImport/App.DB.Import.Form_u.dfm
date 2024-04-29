inherited DBImportForm: TDBImportForm
  Caption = 'DBImportForm'
  ClientHeight = 612
  ClientWidth = 938
  WindowState = wsMaximized
  ExplicitLeft = -319
  ExplicitWidth = 950
  ExplicitHeight = 650
  TextHeight = 15
  object TopoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 938
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitWidth = 934
    object ExecuteBitBtn: TBitBtn
      Left = 536
      Top = 7
      Width = 56
      Height = 25
      Action = ExecuteAction_AppDBImport
      Caption = 'Execute'
      TabOrder = 0
    end
    object ZerarBitBtn: TBitBtn
      Left = 597
      Top = 7
      Width = 84
      Height = 25
      Action = ZerarExecuteAction_AppDBImport
      Caption = 'Apagar Dados'
      TabOrder = 1
    end
    object AtualizarBitBtn_AppDBImport: TBitBtn
      Left = 686
      Top = 7
      Width = 56
      Height = 25
      Action = AtualizarAction_AppDBImport
      Caption = 'Atualizar'
      TabOrder = 2
    end
    object ValidarBitBtn_AppDBImport: TBitBtn
      Left = 747
      Top = 7
      Width = 56
      Height = 25
      Action = ValidarAction_AppDBImport
      Caption = 'Validar'
      TabOrder = 3
    end
  end
  object BasePanel: TPanel [1]
    Left = 0
    Top = 532
    Width = 938
    Height = 80
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitTop = 531
    ExplicitWidth = 934
    DesignSize = (
      938
      80)
    object ProgressBar1: TProgressBar
      Left = 655
      Top = 60
      Width = 276
      Height = 17
      Anchors = [akTop, akRight]
      TabOrder = 0
      Visible = False
      ExplicitLeft = 651
    end
    object StatusMemo: TMemo
      Left = 0
      Top = 0
      Width = 938
      Height = 57
      Align = alTop
      BorderStyle = bsNone
      TabOrder = 1
      ExplicitWidth = 934
    end
  end
  object MeioPanel: TPanel [2]
    Left = 0
    Top = 41
    Width = 938
    Height = 491
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    ExplicitWidth = 934
    ExplicitHeight = 490
    object SplitterStatusMemo: TSplitter
      Left = 0
      Top = 486
      Width = 938
      Height = 5
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 185
      ExplicitWidth = 119
    end
    object GridsPanel: TPanel
      Left = 0
      Top = 0
      Width = 938
      Height = 486
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 934
      ExplicitHeight = 485
      object ProdDBGrid: TDBGrid
        Left = 0
        Top = 0
        Width = 938
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
    object ValidarAction_AppDBImport: TAction
      Caption = 'Validar'
    end
  end
end
