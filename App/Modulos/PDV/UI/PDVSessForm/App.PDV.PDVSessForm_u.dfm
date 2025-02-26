inherited PDVSessForm: TPDVSessForm
  Caption = 'PDVSessForm'
  ClientHeight = 218
  ClientWidth = 788
  Position = poDesktopCenter
  ExplicitWidth = 800
  ExplicitHeight = 256
  TextHeight = 15
  object BasePanel: TPanel [0]
    Left = 0
    Top = 182
    Width = 788
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitTop = 383
    ExplicitWidth = 536
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 788
      Height = 29
      ButtonHeight = 21
      ButtonWidth = 107
      Caption = 'ToolBar1'
      List = True
      ShowCaptions = True
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = RelatAction
        AutoSize = True
      end
    end
  end
  object TopoPanel: TPanel [1]
    Left = 0
    Top = 0
    Width = 788
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 536
  end
  object MeioPanel: TPanel [2]
    Left = 0
    Top = 36
    Width = 788
    Height = 146
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    ExplicitTop = 28
    ExplicitHeight = 268
    object DBGrid1Splitter: TSplitter
      Left = 0
      Top = 105
      Width = 788
      Height = 8
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 200
      ExplicitWidth = 540
    end
    object MensLabel: TLabel
      Left = 0
      Top = 126
      Width = 788
      Height = 20
      Align = alBottom
      Caption = 'MensLabel'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 166
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Visible = False
      WordWrap = True
      StyleElements = [seClient, seBorder]
      ExplicitWidth = 71
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 788
      Height = 105
      Align = alTop
      BorderStyle = bsNone
      DataSource = SessDataSource
      Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgAlwaysShowSelection, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
    object SubPanel: TPanel
      Left = 0
      Top = 113
      Width = 788
      Height = 13
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      ExplicitTop = 206
      ExplicitWidth = 540
      ExplicitHeight = 139
      object Splitter2: TSplitter
        Left = 273
        Top = 0
        Width = 8
        Height = 13
        ExplicitHeight = 140
      end
      object ItemPanel: TPanel
        Left = 0
        Top = 0
        Width = 273
        Height = 13
        Align = alLeft
        BevelOuter = bvNone
        Caption = ' '
        TabOrder = 0
        ExplicitHeight = 139
        object ItemDBGrid: TDBGrid
          Left = 0
          Top = 0
          Width = 273
          Height = 13
          Align = alClient
          BorderStyle = bsNone
          DataSource = ItemDataSource
          Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgAlwaysShowSelection, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
      end
      object PagPanel: TPanel
        Left = 281
        Top = 0
        Width = 507
        Height = 13
        Align = alClient
        BevelOuter = bvNone
        Caption = ' '
        TabOrder = 1
        ExplicitLeft = 0
        ExplicitTop = 384
        ExplicitWidth = 540
        ExplicitHeight = 36
        object PagDBGrid: TDBGrid
          Left = 0
          Top = 0
          Width = 507
          Height = 13
          Align = alClient
          BorderStyle = bsNone
          DataSource = PagDataSource
          Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgAlwaysShowSelection, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
      end
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 192
    Top = 48
  end
  object SessFDMemTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 344
    Top = 44
  end
  object ItemFDMemTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 80
    Top = 104
  end
  object PagFDMemTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 312
    Top = 104
  end
  object ItemDataSource: TDataSource
    DataSet = ItemFDMemTable
    Left = 208
    Top = 100
  end
  object PagDataSource: TDataSource
    DataSet = PagFDMemTable
    Left = 465
    Top = 116
  end
  object SessDataSource: TDataSource
    DataSet = SessFDMemTable
    Left = 456
    Top = 60
  end
  object ActionList1: TActionList
    Left = 40
    Top = 40
    object RelatAction: TAction
      Caption = 'Relat'#243'rio de Caixa'
      OnExecute = RelatActionExecute
    end
  end
end
