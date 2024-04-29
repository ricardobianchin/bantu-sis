inherited DBImportForm: TDBImportForm
  Caption = 'DBImportForm'
  ClientHeight = 612
  ClientWidth = 938
  WindowState = wsMaximized
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
    ExplicitWidth = 704
    object ExecuteBitBtn: TBitBtn
      Left = 559
      Top = 7
      Width = 86
      Height = 25
      Action = ExecuteAction_AppDBImport
      Caption = 'Execute'
      TabOrder = 0
    end
    object ZerarBitBtn: TBitBtn
      Left = 651
      Top = 7
      Width = 86
      Height = 25
      Action = ZerarExecuteAction_AppDBImport
      Caption = 'Apagar Dados'
      TabOrder = 1
    end
    object AtualizarBitBtn_AppDBImport: TBitBtn
      Left = 743
      Top = 7
      Width = 86
      Height = 25
      Action = AtualizarAction_AppDBImport
      Caption = 'Atualizar'
      TabOrder = 2
    end
    object ValidarBitBtn_AppDBImport: TBitBtn
      Left = 835
      Top = 7
      Width = 86
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
    ExplicitWidth = 838
    DesignSize = (
      938
      80)
    object ProgressBar1: TProgressBar
      Left = 659
      Top = 60
      Width = 276
      Height = 17
      Anchors = [akTop, akRight]
      TabOrder = 0
      Visible = False
      ExplicitLeft = 559
    end
    object StatusMemo: TMemo
      Left = 0
      Top = 0
      Width = 938
      Height = 57
      Align = alTop
      BorderStyle = bsNone
      TabOrder = 1
      ExplicitWidth = 838
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
    ExplicitWidth = 704
    ExplicitHeight = 438
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
      ExplicitWidth = 704
      ExplicitHeight = 306
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
