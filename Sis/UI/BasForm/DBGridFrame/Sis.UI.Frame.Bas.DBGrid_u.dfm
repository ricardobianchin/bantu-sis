inherited DBGridFrame: TDBGridFrame
  Width = 542
  Height = 272
  ExplicitWidth = 542
  ExplicitHeight = 272
  object DBGrid1: TDBGrid
    Left = 0
    Top = 3
    Width = 526
    Height = 254
    DataSource = DataSource1
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
  end
  object FDMemTable1: TFDMemTable
    BeforeDelete = FDMemTable1BeforeDelete
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 264
    Top = 80
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 128
    Top = 64
  end
end
