inherited DBImportForm: TDBImportForm
  Caption = 'DBImportForm'
  ClientHeight = 612
  ClientWidth = 938
  WindowState = wsMaximized
  ExplicitTop = -189
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
    object ValidarBitBtn_AppDBImport: TBitBtn
      Left = 683
      Top = 7
      Width = 56
      Height = 25
      Action = ValidarAction_AppDBImport
      Caption = 'Validar'
      TabOrder = 2
    end
  end
  object BasePanel: TPanel [1]
    Left = 0
    Top = 552
    Width = 938
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object ExibirTitLabel: TLabel
      Left = 8
      Top = 11
      Width = 29
      Height = 15
      Caption = 'Exibir'
    end
    object ExibirComboBox: TComboBox
      Left = 42
      Top = 8
      Width = 113
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Todos'
      OnChange = ExibirComboBoxChange
      Items.Strings = (
        'Todos'
        'Com Rejei'#231#227'o')
    end
    object AtualizarBitBtn_AppDBImport: TBitBtn
      Left = 160
      Top = 7
      Width = 56
      Height = 25
      Action = AtualizarAction_AppDBImport
      Caption = 'Atualizar'
      TabOrder = 1
    end
  end
  object MeioPanel: TPanel [2]
    Left = 0
    Top = 41
    Width = 938
    Height = 511
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    ExplicitWidth = 934
    ExplicitHeight = 490
    object GridsPanel: TPanel
      Left = 0
      Top = 0
      Width = 938
      Height = 511
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 934
      ExplicitHeight = 485
      object SplitterRejeicaoGrid: TSplitter
        Left = 0
        Top = 360
        Width = 938
        Height = 5
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 370
      end
      object ProdDBGrid: TDBGrid
        Left = 0
        Top = 0
        Width = 938
        Height = 360
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
      object RejeicaoDBGrid: TDBGrid
        Left = 0
        Top = 365
        Width = 938
        Height = 146
        Align = alBottom
        BorderStyle = bsNone
        DataSource = ProdRejDataSource
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
      end
    end
  end
  object StatusPanel: TPanel [3]
    Left = 0
    Top = 591
    Width = 938
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 3
    ExplicitTop = 592
    DesignSize = (
      938
      21)
    object ProgressBar1: TProgressBar
      Left = 3
      Top = 2
      Width = 276
      Height = 17
      Anchors = [akTop, akRight]
      TabOrder = 0
      Visible = False
    end
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
  object ProdRejDataSource: TDataSource
    Left = 236
    Top = 145
  end
  object ProdDataSource: TDataSource
    Left = 128
    Top = 145
  end
end
