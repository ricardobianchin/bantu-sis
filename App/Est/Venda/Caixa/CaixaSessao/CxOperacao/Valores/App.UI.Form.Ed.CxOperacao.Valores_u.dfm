inherited CxOperValoresEdForm: TCxOperValoresEdForm
  Caption = 'CxOperValoresEdForm'
  ClientHeight = 329
  ClientWidth = 578
  ExplicitWidth = 590
  ExplicitHeight = 367
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 257
    Width = 578
    ExplicitTop = 257
  end
  inherited ObjetivoLabel: TLabel
    Width = 578
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 277
    Width = 578
    ExplicitTop = 277
  end
  inherited BasePanel: TPanel
    Top = 292
    Width = 578
    ExplicitTop = 291
    ExplicitWidth = 574
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 196
      ExplicitLeft = 192
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 309
      ExplicitLeft = 305
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 410
      ExplicitLeft = 406
    end
  end
  inherited MeioPanel: TPanel
    Width = 578
    Height = 240
    ExplicitWidth = 578
    ExplicitHeight = 240
    inherited ObsPanel: TPanel
      Top = 157
      Width = 578
      ExplicitTop = 156
      ExplicitWidth = 574
      inherited Label2: TLabel
        Width = 578
      end
      inherited ObsMemo: TMemo
        Width = 578
        ExplicitWidth = 574
      end
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 578
      Height = 116
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource1
      Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgAlwaysShowSelection, dgCancelOnExit, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnColEnter = DBGrid1ColEnter
      OnColumnMoved = DBGrid1ColumnMoved
      OnKeyPress = DBGrid1KeyPress
      Columns = <
        item
          Expanded = False
          FieldName = 'Id'
          Title.Alignment = taCenter
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'Descr'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor'
          Title.Alignment = taRightJustify
          Width = 81
          Visible = True
        end>
    end
    object TotPanel: TPanel
      Left = 0
      Top = 116
      Width = 578
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = ' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      StyleElements = [seClient, seBorder]
      ExplicitTop = 115
      ExplicitWidth = 574
      object TotNumEditBtu: TNumEditBtu
        Left = 72
        Top = 3
        Width = 121
        Height = 28
        Alignment = taCenter
        AutoExit = True
        Caption = 'Total R$'
        EditLabel.Width = 54
        EditLabel.Height = 28
        EditLabel.Caption = 'Total R$'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -15
        EditLabel.Font.Name = 'Segoe UI'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 6
        ParentFont = False
        ReadOnly = False
        TabOrder = 0
        Text = '0,00'
        NCasas = 2
        NCasasEsq = 9
        Valor = 0
        MascEsq = '###,##,##0'
      end
    end
  end
  object FDMemTable1: TFDMemTable
    Active = True
    AfterPost = FDMemTable1AfterPost
    OnNewRecord = FDMemTable1NewRecord
    FieldDefs = <
      item
        Name = 'Id'
        DataType = ftInteger
      end
      item
        Name = 'Descr'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'Valor'
        DataType = ftCurrency
        Precision = 19
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
    Left = 424
    Top = 32
    object FDMemTable1Id: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'C'#243'digo'
      FieldName = 'Id'
      Visible = False
    end
    object FDMemTable1Descr: TStringField
      DisplayLabel = 'Forma de Pagamento'
      FieldName = 'Descr'
      Size = 200
    end
    object FDMemTable1Valor: TCurrencyField
      FieldName = 'Valor'
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 328
    Top = 40
  end
end
