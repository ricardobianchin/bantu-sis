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
      ButtonWidth = 58
      ExplicitHeight = 32
      object FiltroPanel_DataSetTabSheet: TPanel
        Left = 51
        Top = 0
        Width = 121
        Height = 23
        AutoSize = True
        BevelOuter = bvNone
        Caption = ' '
        TabOrder = 0
        object FiltroEdit_DataSetTabSheet: TEdit
          Left = 0
          Top = 0
          Width = 121
          Height = 23
          TabOrder = 0
          OnChange = FiltroEdit_DataSetTabSheetChange
        end
      end
      object AtuToolButton: TToolButton
        Left = 172
        Top = 0
        Action = AtuAction_DatasetTabSheet
        AutoSize = True
      end
      object InsToolButton: TToolButton
        Left = 229
        Top = 0
        Action = InsAction_DatasetTabSheet
        AutoSize = True
      end
      object AltToolButton: TToolButton
        Left = 272
        Top = 0
        Action = AltAction_DatasetTabSheet
        AutoSize = True
      end
      object ExclToolButton: TToolButton
        Left = 318
        Top = 0
        Action = ExclAction_DatasetTabSheetAction1
        AutoSize = True
      end
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
    end
    object AltAction_DatasetTabSheet: TAction
      Caption = 'Alterar'
    end
    object ExclAction_DatasetTabSheetAction1: TAction
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
