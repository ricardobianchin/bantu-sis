inherited ProdRejEdForm: TProdRejEdForm
  Caption = 'Resolver Rejei'#231#227'o'
  ClientWidth = 988
  ExplicitWidth = 1000
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 988
  end
  inherited AlteracaoTextoLabel: TLabel
    Width = 988
  end
  inherited BasePanel: TPanel
    Width = 988
    ExplicitTop = 230
    ExplicitWidth = 984
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 653
      ExplicitLeft = 649
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 766
      ExplicitLeft = 762
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 846
      ExplicitLeft = 842
    end
  end
  object ProdDBGrid: TDBGrid [3]
    Left = 0
    Top = 0
    Width = 988
    Height = 211
    Align = alClient
    BorderStyle = bsNone
    DataSource = ProdDataSource
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnColEnter = ProdDBGridColEnter
    OnEditButtonClick = ProdDBGridEditButtonClick
  end
  object ProdDataSource: TDataSource
    Left = 368
    Top = 136
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 440
    Top = 80
    object FDMemTable1id: TIntegerField
      FieldName = 'id'
    end
    object FDMemTable1descr: TStringField
      FieldName = 'descr'
      OnSetText = FDMemTable1descrSetText
      OnValidate = FDMemTable1descrValidate
      Size = 120
    end
  end
end
