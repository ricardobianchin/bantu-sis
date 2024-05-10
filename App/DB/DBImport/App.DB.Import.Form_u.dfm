inherited DBImportForm: TDBImportForm
  Caption = 'DBImportForm'
  ClientHeight = 342
  ClientWidth = 934
  WindowState = wsMaximized
  OnCreate = FormCreate
  ExplicitWidth = 946
  ExplicitHeight = 380
  TextHeight = 15
  object TopoPanel: TPanel [0]
    Left = 0
    Top = 0
    Width = 934
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitWidth = 930
    object ExecuteBitBtn: TBitBtn
      Left = 536
      Top = 7
      Width = 56
      Height = 25
      Action = ExecuteAction_AppDBImport
      Caption = 'Importar'
      TabOrder = 0
    end
  end
  object BasePanel: TPanel [1]
    Left = 0
    Top = 255
    Width = 934
    Height = 66
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitTop = 254
    ExplicitWidth = 930
    object FilConfTitLabel: TLabel
      Left = 4
      Top = 43
      Width = 77
      Height = 15
      Caption = 'Conformidade'
    end
    object FilSelecTitLabel: TLabel
      Left = 210
      Top = 43
      Width = 44
      Height = 15
      Caption = 'Inclus'#227'o'
    end
    object FIlConfComboBox: TComboBox
      Left = 88
      Top = 40
      Width = 113
      Height = 23
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Todos'
      OnChange = FIlConfComboBoxChange
      Items.Strings = (
        'Todos'
        'Com Rejei'#231#227'o'
        'Aceitos')
    end
    object AtualizarBitBtn_AppDBImport: TBitBtn
      Left = 375
      Top = 39
      Width = 56
      Height = 25
      Action = AtualizarAction_AppDBImport
      Caption = 'Atualizar'
      TabOrder = 1
    end
    object FilSelecComboBox: TComboBox
      Left = 257
      Top = 40
      Width = 113
      Height = 23
      Style = csDropDownList
      TabOrder = 2
      OnChange = FIlConfComboBoxChange
      Items.Strings = (
        'Todos'
        'Ser'#227'o Importados'
        'Ser'#227'o Ignorados')
    end
    object ZerarBitBtn: TBitBtn
      Left = 4
      Top = 3
      Width = 84
      Height = 25
      Action = ZerarExecuteAction_AppDBImport
      Caption = 'Apagar Dados'
      TabOrder = 3
    end
    object ValidarBitBtn_AppDBImport: TBitBtn
      Left = 93
      Top = 3
      Width = 56
      Height = 25
      Action = ValidarAction_AppDBImport
      Caption = 'Validar'
      TabOrder = 4
    end
    object EditBitBtn_AppDBImport: TBitBtn
      Left = 154
      Top = 3
      Width = 90
      Height = 25
      Action = EditAction_AppDBImport
      Caption = 'Editar Produto'
      TabOrder = 5
    end
    object RejEdBitBtn_AppDBImport: TBitBtn
      Left = 314
      Top = 3
      Width = 105
      Height = 25
      Action = RejEdAction_AppDBImport
      Caption = 'Resolver Rejei'#231#227'o'
      TabOrder = 6
    end
    object InclusaoBitBtn_AppDBImport: TBitBtn
      Left = 248
      Top = 3
      Width = 62
      Height = 25
      Action = InclusaoAction_AppDBImport
      Caption = 'Inclus'#227'o'
      TabOrder = 7
    end
  end
  object MeioPanel: TPanel [2]
    Left = 0
    Top = 41
    Width = 934
    Height = 214
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    ExplicitWidth = 930
    ExplicitHeight = 213
    object GridsPanel: TPanel
      Left = 0
      Top = 0
      Width = 934
      Height = 214
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 930
      ExplicitHeight = 213
      object SplitterRejeicaoGrid: TSplitter
        Left = 0
        Top = 63
        Width = 934
        Height = 5
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 370
        ExplicitWidth = 938
      end
      object ProdDBGrid: TDBGrid
        Left = 0
        Top = 0
        Width = 934
        Height = 63
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
        Top = 68
        Width = 934
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
    Top = 321
    Width = 934
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 3
    ExplicitTop = 320
    ExplicitWidth = 930
    DesignSize = (
      934
      21)
    object ProgressBar1: TProgressBar
      Left = -1
      Top = 2
      Width = 276
      Height = 17
      Anchors = [akTop, akRight]
      TabOrder = 0
      Visible = False
      ExplicitLeft = -5
    end
  end
  object ActionList_AppDBImport: TActionList
    Left = 400
    Top = 81
    object ExecuteAction_AppDBImport: TAction
      Caption = 'Importar'
      OnExecute = ExecuteAction_AppDBImportExecute
    end
    object ZerarExecuteAction_AppDBImport: TAction
      Caption = 'Apagar Dados'
      OnExecute = ZerarExecuteAction_AppDBImportExecute
    end
    object AtualizarAction_AppDBImport: TAction
      Caption = 'Atualizar'
      OnExecute = AtualizarAction_AppDBImportExecute
    end
    object ValidarAction_AppDBImport: TAction
      Caption = 'Validar'
      OnExecute = ValidarAction_AppDBImportExecute
    end
    object EditAction_AppDBImport: TAction
      Caption = 'Editar Produto'
    end
    object RejEdAction_AppDBImport: TAction
      Caption = 'Resolver Rejei'#231#227'o'
      OnExecute = RejEdAction_AppDBImportExecute
    end
    object InclusaoAction_AppDBImport: TAction
      Caption = 'Inclus'#227'o'
      Hint = 'Liga / Desliga se Registro Ser'#225' Importado'
      OnExecute = InclusaoAction_AppDBImportExecute
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
