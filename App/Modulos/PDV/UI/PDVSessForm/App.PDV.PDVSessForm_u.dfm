inherited PDVSessForm: TPDVSessForm
  Caption = 'PDVSessForm'
  ClientHeight = 384
  ClientWidth = 619
  ExplicitWidth = 631
  ExplicitHeight = 422
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 313
    Width = 619
    ExplicitLeft = -8
    ExplicitTop = 267
    ExplicitWidth = 619
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 369
    Width = 619
    ExplicitTop = 319
  end
  object MeioPanel: TPanel [2]
    Left = 0
    Top = 36
    Width = 619
    Height = 277
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 2
    ExplicitLeft = -169
    ExplicitWidth = 788
    ExplicitHeight = 146
    object DBGrid1Splitter: TSplitter
      Left = 0
      Top = 105
      Width = 619
      Height = 8
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 200
      ExplicitWidth = 540
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 619
      Height = 105
      Align = alTop
      BorderStyle = bsNone
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
      Width = 619
      Height = 164
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      ExplicitWidth = 788
      ExplicitHeight = 13
      object Splitter2: TSplitter
        Left = 273
        Top = 0
        Width = 8
        Height = 164
        ExplicitHeight = 140
      end
      object ItemPanel: TPanel
        Left = 0
        Top = 0
        Width = 273
        Height = 164
        Align = alLeft
        BevelOuter = bvNone
        Caption = ' '
        TabOrder = 0
        ExplicitHeight = 13
        object ItemDBGrid: TDBGrid
          Left = 0
          Top = 0
          Width = 273
          Height = 164
          Align = alClient
          BorderStyle = bsNone
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
        Width = 338
        Height = 164
        Align = alClient
        BevelOuter = bvNone
        Caption = ' '
        TabOrder = 1
        ExplicitWidth = 507
        ExplicitHeight = 13
        object PagDBGrid: TDBGrid
          Left = 0
          Top = 0
          Width = 338
          Height = 164
          Align = alClient
          BorderStyle = bsNone
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
  object TopoPanel: TPanel [3]
    Left = 0
    Top = 0
    Width = 619
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitLeft = -169
    ExplicitWidth = 788
  end
  object BasePanel: TPanel [4]
    Left = 0
    Top = 333
    Width = 619
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitLeft = -169
    ExplicitTop = 182
    ExplicitWidth = 788
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 619
      Height = 29
      ButtonHeight = 21
      ButtonWidth = 15
      Caption = 'ToolBar1'
      List = True
      ShowCaptions = True
      TabOrder = 0
      ExplicitWidth = 788
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
      end
    end
  end
  object ToolBarActionList: TActionList
    Left = 328
    Top = 56
    object RelatAction: TAction
      Caption = 'Relat'#243'rio de Caixa'
      OnExecute = RelatActionExecute
    end
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
    Top = 116
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
    Top = 176
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
    Top = 176
  end
  object ItemDataSource: TDataSource
    DataSet = ItemFDMemTable
    Left = 208
    Top = 172
  end
  object PagDataSource: TDataSource
    DataSet = PagFDMemTable
    Left = 465
    Top = 188
  end
  object SessDataSource: TDataSource
    DataSet = SessFDMemTable
    Left = 456
    Top = 132
  end
end
