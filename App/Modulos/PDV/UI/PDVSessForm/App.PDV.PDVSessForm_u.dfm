inherited PDVSessForm: TPDVSessForm
  Caption = 'PDVSessForm'
  ClientHeight = 254
  ClientWidth = 788
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 804
  ExplicitHeight = 293
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 197
    Width = 788
    Visible = False
    ExplicitTop = 197
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 239
    Width = 788
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 239
  end
  object MeioPanel: TPanel [2]
    Left = 0
    Top = 41
    Width = 788
    Height = 156
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    Padding.Left = 3
    Padding.Top = 2
    Padding.Right = 3
    Padding.Bottom = 2
    TabOrder = 1
    object DBGrid1Splitter: TSplitter
      Left = 3
      Top = 127
      Width = 782
      Height = 8
      Cursor = crVSplit
      Align = alTop
      ExplicitLeft = 0
      ExplicitTop = 200
      ExplicitWidth = 540
    end
    object SessDescrLabel: TLabel
      Left = 3
      Top = 2
      Width = 782
      Height = 20
      Align = alTop
      AutoSize = False
      Caption = '        '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      StyleElements = [seClient, seBorder]
      ExplicitWidth = 613
    end
    object DBGrid1: TDBGrid
      Left = 3
      Top = 22
      Width = 782
      Height = 105
      Align = alTop
      BorderStyle = bsNone
      DataSource = SessDataSource
      Options = [dgTitles, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
    object SubPanel: TPanel
      Left = 3
      Top = 135
      Width = 782
      Height = 19
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      object Splitter2: TSplitter
        Left = 273
        Top = 0
        Width = 8
        Height = 19
        ExplicitHeight = 140
      end
      object ItemPanel: TPanel
        Left = 0
        Top = 0
        Width = 273
        Height = 19
        Align = alLeft
        BevelOuter = bvNone
        Caption = ' '
        TabOrder = 0
        object ItemDBGrid: TDBGrid
          Left = 0
          Top = 0
          Width = 273
          Height = 19
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
        Width = 501
        Height = 19
        Align = alClient
        BevelOuter = bvNone
        Caption = ' '
        TabOrder = 1
        object PagDBGrid: TDBGrid
          Left = 0
          Top = 0
          Width = 501
          Height = 19
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
  object BasePanel: TPanel [3]
    Left = 0
    Top = 217
    Width = 788
    Height = 22
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 15
      Top = 0
      Width = 580
      Height = 21
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 125
      Caption = 'ToolBar1'
      List = True
      ShowCaptions = True
      TabOrder = 0
      object RelatToolButton: TToolButton
        Left = 0
        Top = 0
        Action = RelatAction
        AutoSize = True
      end
      object CancelToolButton: TToolButton
        Left = 124
        Top = 0
        Action = CancelAction
        AutoSize = True
      end
      object SuprToolButton: TToolButton
        Left = 209
        Top = 0
        Action = SuprAction
        AutoSize = True
      end
      object SangrToolButton: TToolButton
        Left = 301
        Top = 0
        Action = SangrAction
        AutoSize = True
      end
      object FechToolButton: TToolButton
        Left = 370
        Top = 0
        Action = FechAction
        AutoSize = True
      end
    end
  end
  object TitleBarPanel: TPanel [4]
    Left = 0
    Top = 0
    Width = 788
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = '   '
    Color = 3813420
    ParentBackground = False
    TabOrder = 2
    StyleElements = []
    DesignSize = (
      788
      41)
    object TitleBarCaptionLabel: TLabel
      Left = 161
      Top = 9
      Width = 91
      Height = 21
      Caption = 'Busca Pre'#231'o'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      StyleElements = []
    end
    object ToolBar2: TToolBar
      Left = 741
      Top = 9
      Width = 54
      Height = 29
      Hint = 'Esc - Fechar'
      Align = alNone
      Anchors = [akTop, akRight]
      ButtonHeight = 24
      ButtonWidth = 47
      Caption = 'ToolBar1'
      Color = 3813420
      Flat = False
      Images = SisImgDataModule.ImageList_40_24
      ParentColor = False
      TabOrder = 0
      Transparent = True
      StyleElements = []
      object FecharToolButton: TToolButton
        Left = 0
        Top = 0
        Action = CancelAct_Diag
        ImageIndex = 0
      end
    end
  end
  object ToolBarActionList: TActionList
    Left = 328
    Top = 56
    object RelatAction: TAction
      Caption = 'R - Relat'#243'rio de Caixa'
      OnExecute = RelatActionExecute
    end
    object CancelAction: TAction
      Caption = 'Del - Cancelar'
      Visible = False
      OnExecute = CancelActionExecute
    end
    object SuprAction: TAction
      Caption = 'U - Suprimento'
      OnExecute = SuprActionExecute
    end
    object SangrAction: TAction
      Caption = 'A - Sangria'
      OnExecute = SangrActionExecute
    end
    object FechAction: TAction
      Caption = 'F - Fechar o Caixa'
      OnExecute = FechActionExecute
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
    Left = 440
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
    Left = 48
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
    Left = 224
    Top = 112
  end
  object ItemDataSource: TDataSource
    DataSet = ItemFDMemTable
    Left = 144
    Top = 108
  end
  object PagDataSource: TDataSource
    DataSet = PagFDMemTable
    Left = 313
    Top = 108
  end
  object SessDataSource: TDataSource
    DataSet = SessFDMemTable
    Left = 456
    Top = 132
  end
end
