inherited TabSheetDataSetBasForm: TTabSheetDataSetBasForm
  Caption = 'TabSheetDataSetBasForm'
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    Height = 37
    AutoSize = False
    ExplicitHeight = 37
    inherited TitToolBar1_BasTabSheet: TToolBar
      Height = 32
      AutoSize = False
      ExplicitHeight = 32
    end
  end
  object DBGrid1: TDBGrid [1]
    Left = 0
    Top = 37
    Width = 632
    Height = 440
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
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
    Interval = 333
    OnTimer = FiltroAtualizarTimerTimer
    Left = 56
    Top = 112
  end
end
