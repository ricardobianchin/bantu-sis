inherited PDVSessForm: TPDVSessForm
  Caption = 'PDVSessForm'
  ClientHeight = 403
  ClientWidth = 984
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 1000
  ExplicitHeight = 442
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 271
    Width = 984
    Visible = False
    ExplicitTop = 271
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 291
    Width = 984
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 291
  end
  object MeioPanel: TPanel [2]
    Left = 0
    Top = 41
    Width = 984
    Height = 230
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
      Top = 125
      Width = 978
      Height = 8
      Cursor = crVSplit
      Align = alTop
      ExplicitLeft = 0
      ExplicitTop = 200
      ExplicitWidth = 540
    end
    object DBGrid1: TDBGrid
      Left = 3
      Top = 20
      Width = 978
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
      Top = 133
      Width = 978
      Height = 95
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      object Splitter2: TSplitter
        Left = 537
        Top = 0
        Width = 8
        Height = 95
        ExplicitLeft = 273
        ExplicitHeight = 140
      end
      object ItemPanel: TPanel
        Left = 0
        Top = 0
        Width = 537
        Height = 95
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Rotinas de Caixa n'#227'o possuem itens'
        TabOrder = 0
        object ItemDBGrid: TDBGrid
          Left = 0
          Top = 18
          Width = 537
          Height = 77
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
          Columns = <
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ORDEM'
              Title.Alignment = taCenter
              Visible = False
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'ITEM'
              Title.Alignment = taCenter
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'PROD_ID'
              Title.Alignment = taCenter
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCR_RED'
              Width = 200
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QTD'
              Title.Alignment = taRightJustify
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRECO_UNIT'
              Title.Alignment = taRightJustify
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCONTO'
              Title.Alignment = taRightJustify
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRECO'
              Title.Alignment = taRightJustify
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'CANCELADO'
              Title.Alignment = taCenter
              Visible = True
            end>
        end
        object ItensTitPanel: TPanel
          Left = 0
          Top = 0
          Width = 537
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          Caption = '  '
          Color = 13023391
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          StyleElements = []
          object TitItensLabel: TLabel
            Left = 8
            Top = -1
            Width = 27
            Height = 17
            Caption = 'Itens'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
        end
      end
      object PagPanel: TPanel
        Left = 545
        Top = 0
        Width = 433
        Height = 95
        Align = alClient
        BevelOuter = bvNone
        Caption = ' '
        TabOrder = 1
        object PagDBGrid: TDBGrid
          Left = 0
          Top = 18
          Width = 433
          Height = 77
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
          Columns = <
            item
              Expanded = False
              FieldName = 'ORDEM'
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'PAGAMENTO_FORMA_ID'
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'DESCR'
              Width = 200
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR_DEVIDO'
              Title.Alignment = taRightJustify
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VALOR_ENTREGUE'
              Title.Alignment = taRightJustify
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TROCO'
              Title.Alignment = taRightJustify
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'CANCELADO'
              Title.Alignment = taCenter
              Visible = True
            end>
        end
        object PagTitPanel: TPanel
          Left = 0
          Top = 0
          Width = 433
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          Caption = '  '
          Color = 13023391
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          StyleElements = []
          object PagTitLabel: TLabel
            Left = 8
            Top = -1
            Width = 132
            Height = 17
            Caption = 'Formas de Pagamento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
        end
      end
    end
    object SessTitPanel: TPanel
      Left = 3
      Top = 2
      Width = 978
      Height = 18
      Align = alTop
      BevelOuter = bvNone
      Caption = '  '
      Color = 13023391
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      StyleElements = []
      object SessTitLabel: TLabel
        Left = 8
        Top = -1
        Width = 175
        Height = 17
        Caption = 'Vendas e Operacoes de Caixa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object BasePanel: TPanel [3]
    Left = 0
    Top = 306
    Width = 984
    Height = 97
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object ToolBar1: TToolBar
      Left = 15
      Top = 76
      Width = 1000
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
      object DespToolButton: TToolButton
        Left = 370
        Top = 0
        Action = DespAction
        AutoSize = True
      end
      object FechToolButton: TToolButton
        Left = 443
        Top = 0
        Action = FechAction
        AutoSize = True
      end
    end
  end
  object TitleBarPanel: TPanel [4]
    Left = 0
    Top = 0
    Width = 984
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = '   '
    Color = 3813420
    ParentBackground = False
    TabOrder = 2
    StyleElements = []
    DesignSize = (
      984
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
      Left = 937
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
    object DespAction: TAction
      Caption = 'D - Despesa'
      OnExecute = DespActionExecute
    end
    object FechAction: TAction
      Caption = 'F - Fechar o Caixa'
      OnExecute = FechActionExecute
    end
  end
  object SessFDMemTable: TFDMemTable
    AfterOpen = SessFDMemTableAfterOpen
    AfterScroll = SessFDMemTableAfterScroll
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
    Active = True
    FieldDefs = <
      item
        Name = 'ORDEM'
        DataType = ftSmallint
      end
      item
        Name = 'ITEM'
        DataType = ftSmallint
      end
      item
        Name = 'PROD_ID'
        DataType = ftInteger
      end
      item
        Name = 'DESCR_RED'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'QTD'
        DataType = ftCurrency
        Precision = 19
      end
      item
        Name = 'PRECO_UNIT'
        DataType = ftCurrency
        Precision = 19
      end
      item
        Name = 'DESCONTO'
        DataType = ftCurrency
        Precision = 19
      end
      item
        Name = 'PRECO'
        DataType = ftCurrency
        Precision = 19
      end
      item
        Name = 'CANCELADO'
        DataType = ftBoolean
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 48
    Top = 104
    object ItemFDMemTableORDEM: TSmallintField
      FieldName = 'ORDEM'
      Visible = False
    end
    object ItemFDMemTableITEM: TSmallintField
      DisplayLabel = 'Item'
      FieldName = 'ITEM'
    end
    object ItemFDMemTablePROD_ID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'PROD_ID'
    end
    object ItemFDMemTableDESCR_RED: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'DESCR_RED'
      Size = 30
    end
    object ItemFDMemTableQTD: TCurrencyField
      DisplayLabel = 'Qtd'
      FieldName = 'QTD'
      EditFormat = '######0.###'
    end
    object ItemFDMemTablePRECO_UNIT: TCurrencyField
      DisplayLabel = 'Pre'#231'o Unit'#225'rio'
      FieldName = 'PRECO_UNIT'
      EditFormat = '######0.00'
    end
    object ItemFDMemTableDESCONTO: TCurrencyField
      DisplayLabel = 'Desconto'
      FieldName = 'DESCONTO'
      EditFormat = '######0.00'
    end
    object ItemFDMemTablePRECO: TCurrencyField
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'PRECO'
      EditFormat = '######0.00'
    end
    object ItemFDMemTableCANCELADO: TBooleanField
      DisplayLabel = 'Cancelado'
      FieldName = 'CANCELADO'
      DisplayValues = 'Sim;N'#227'o'
    end
  end
  object PagFDMemTable: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 384
    Top = 120
    object PagFDMemTableORDEM: TSmallintField
      FieldName = 'ORDEM'
      Visible = False
    end
    object PagFDMemTablePAGAMENTO_FORMA_ID: TIntegerField
      FieldName = 'PAGAMENTO_FORMA_ID'
      Visible = False
    end
    object PagFDMemTableDESCR: TStringField
      DisplayLabel = 'Forma de Pagamento'
      FieldName = 'DESCR'
      Size = 80
    end
    object PagFDMemTableVALOR_DEVIDO: TCurrencyField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR_DEVIDO'
      EditFormat = '######0.00'
    end
    object PagFDMemTableVALOR_ENTREGUE: TCurrencyField
      DisplayLabel = 'Recebido'
      FieldName = 'VALOR_ENTREGUE'
      EditFormat = '######0.00'
    end
    object PagFDMemTableTROCO: TCurrencyField
      DisplayLabel = 'Troco'
      FieldName = 'TROCO'
      EditFormat = '######0.00'
    end
    object PagFDMemTableCANCELADO: TBooleanField
      DisplayLabel = 'Cancelado'
      FieldName = 'CANCELADO'
      DisplayValues = 'Sim;N'#227'o'
    end
  end
  object ItemDataSource: TDataSource
    DataSet = ItemFDMemTable
    Left = 144
    Top = 108
  end
  object PagDataSource: TDataSource
    DataSet = PagFDMemTable
    Left = 505
    Top = 108
  end
  object SessDataSource: TDataSource
    DataSet = SessFDMemTable
    Left = 536
    Top = 52
  end
  object CarregaDetailTimer: TTimer
    Enabled = False
    Interval = 220
    OnTimer = CarregaDetailTimerTimer
    Left = 240
    Top = 129
  end
end
