inherited TabSheetDataSetBasForm: TTabSheetDataSetBasForm
  Align = alClient
  Caption = 'TabSheetDataSetBasForm'
  ClientWidth = 700
  WindowState = wsMaximized
  ExplicitWidth = 700
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    Top = 446
    Width = 700
    Height = 31
    Align = alBottom
    AutoSize = False
    ExplicitTop = 446
    ExplicitWidth = 700
    ExplicitHeight = 31
    inherited TitToolBar1_BasTabSheet: TToolBar
      Width = 700
      Height = 27
      AutoSize = False
      ButtonHeight = 30
      ButtonWidth = 59
      HotImages = SisImgDataModule.ImageList24Flat
      ExplicitWidth = 700
      ExplicitHeight = 27
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 73
        Height = 30
        BevelOuter = bvNone
        Caption = ' '
        TabOrder = 0
        Visible = False
      end
    end
  end
  object DBGrid1: TDBGrid [1]
    Left = 0
    Top = 0
    Width = 700
    Height = 446
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyPress = DBGrid1KeyPress
  end
  object SelectPanel: TPanel [2]
    Left = 264
    Top = 256
    Width = 73
    Height = 29
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    Visible = False
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 73
      Height = 29
      Align = alClient
      ButtonHeight = 30
      ButtonWidth = 31
      Caption = 'ToolBar1'
      Images = SisImgDataModule.ImageList24FlatSelect
      TabOrder = 0
      object OkToolButton_DataSetForm: TToolButton
        Left = 0
        Top = 0
        Action = OkAction
      end
      object CancelToolButton_DataSetForm: TToolButton
        Left = 31
        Top = 0
        Action = CancelAction
      end
    end
  end
  inherited ActionList1_ActBasForm: TActionList
    object AtuAction_DatasetTabSheet: TAction
      Caption = 'Atualizar'
      OnExecute = AtuAction_DatasetTabSheetExecute
    end
    object InsAction_DatasetTabSheet: TAction
      Caption = 'Inserir'
      OnExecute = InsAction_DatasetTabSheetExecute
    end
    object AltAction_DatasetTabSheet: TAction
      Caption = 'Alterar'
      OnExecute = AltAction_DatasetTabSheetExecute
    end
    object ExclAction_DatasetTabSheet: TAction
      Caption = 'Excluir'
    end
  end
  object DataSource1: TDataSource
    Left = 176
    Top = 104
  end
  object FiltroAtualizarTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = FiltroAtualizarTimerTimer
    Left = 56
    Top = 112
  end
  object SelectActionList_DataSetForm: TActionList
    Images = SisImgDataModule.ImageList24FlatSelect
    Left = 424
    Top = 136
    object OkAction: TAction
      Caption = 'OkAction'
      Hint = 'Escolher o Registro Selecionado'
      ImageIndex = 1
      OnExecute = OkActionExecute
    end
    object CancelAction: TAction
      Caption = 'Cancelar'
      Hint = 'Cancelar'
      ImageIndex = 0
      OnExecute = CancelActionExecute
    end
  end
end
