inherited CxOperValoresEdForm: TCxOperValoresEdForm
  Caption = 'CxOperValoresEdForm'
  ClientHeight = 328
  ClientWidth = 574
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 590
  ExplicitHeight = 367
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 256
    Width = 574
    ExplicitTop = 256
  end
  inherited ObjetivoLabel: TLabel
    Width = 574
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 276
    Width = 574
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 276
  end
  inherited BasePanel: TPanel
    Top = 291
    Width = 574
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 290
    ExplicitWidth = 570
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 176
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 289
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 390
    end
  end
  inherited MeioPanel: TPanel
    Width = 574
    Height = 239
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 570
    ExplicitHeight = 238
    inherited ObsPanel: TPanel
      Top = 156
      Width = 574
      StyleElements = [seFont, seClient, seBorder]
      ExplicitTop = 155
      ExplicitWidth = 570
      inherited Label2: TLabel
        Width = 152
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited ObsMemo: TMemo
        Width = 574
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 570
      end
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 574
      Height = 115
      Align = alClient
      BorderStyle = bsNone
      DataSource = DataSource1
      Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgAlwaysShowSelection, dgTitleHotTrack]
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
      Top = 115
      Width = 574
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
      ExplicitTop = 114
      ExplicitWidth = 570
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
