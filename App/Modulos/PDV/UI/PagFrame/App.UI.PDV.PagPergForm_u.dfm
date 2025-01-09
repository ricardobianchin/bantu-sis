inherited PagPergForm: TPagPergForm
  Caption = 'PagPergForm'
  ClientHeight = 359
  ClientWidth = 788
  StyleElements = [seClient, seBorder]
  ExplicitWidth = 800
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 339
    Width = 788
    ExplicitTop = 339
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 324
    Width = 788
    ExplicitTop = 322
  end
  object CancelarStatusLabel: TLabel [2]
    Left = 318
    Top = 302
    Width = 80
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = 'Item a cancelar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = []
  end
  object FaltaLabel: TLabel [3]
    Left = 5
    Top = 11
    Width = 39
    Height = 23
    Caption = 'Falta:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = [seClient, seBorder]
  end
  object Label1: TLabel [4]
    Left = 53
    Top = 5
    Width = 245
    Height = 32
    Cursor = crHandPoint
    Alignment = taCenter
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Enter / Delete - Cancelar item'
    Color = 14993837
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    Layout = tlCenter
    StyleElements = []
  end
  object FormaPagObsLabel: TLabel [5]
    Left = 0
    Top = 240
    Width = 267
    Height = 15
    Caption = 'Escolha a Forma de Pagamento com as setas ['#8593']['#8595']'
  end
  object PagFormaDBGrid: TDBGrid [6]
    Left = 0
    Top = 41
    Width = 386
    Height = 192
    BorderStyle = bsNone
    DataSource = PagFormaDataSource
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PAGAMENTO_FORMA_ID'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'PAGAMENTO_FORMA_TIPO_ID'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'TIPO_DESCR_RED'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORMA_DESCR'
        Width = 294
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_MINIMO'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'PROMOCAO_PERMITE'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'TEF_USA'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'AUTORIZACAO_EXIGE'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'PESSOA_EXIGE'
        Visible = False
      end>
  end
  object ToolBar1: TToolBar [7]
    Left = 32
    Top = 267
    Width = 354
    Height = 29
    Align = alNone
    ButtonHeight = 27
    ButtonWidth = 95
    Caption = 'ToolBar1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    List = True
    ParentFont = False
    ShowCaptions = True
    TabOrder = 1
    StyleElements = [seClient, seBorder]
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Caption = 'ToolButton1'
      ImageIndex = 0
    end
    object ToolButton2: TToolButton
      Left = 95
      Top = 0
      Caption = 'ToolButton2'
      ImageIndex = 1
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 24
    Top = 80
  end
  inherited ActionList1_Diag: TActionList
    Top = 152
  end
  object PagFormaFDMemTable: TFDMemTable
    Active = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 64
    Top = 144
    object PagFormaFDMemTablePAGAMENTO_FORMA_ID: TIntegerField
      FieldName = 'PAGAMENTO_FORMA_ID'
    end
    object PagFormaFDMemTablePAGAMENTO_FORMA_TIPO_ID: TStringField
      FieldName = 'PAGAMENTO_FORMA_TIPO_ID'
      Size = 1
    end
    object PagFormaFDMemTableTIPO_DESCR_RED: TStringField
      FieldName = 'TIPO_DESCR_RED'
      Size = 6
    end
    object PagFormaFDMemTableFORMA_DESCR: TStringField
      FieldName = 'FORMA_DESCR'
      Size = 50
    end
    object PagFormaFDMemTableVALOR_MINIMO: TCurrencyField
      FieldName = 'VALOR_MINIMO'
    end
    object PagFormaFDMemTablePROMOCAO_PERMITE: TBooleanField
      FieldName = 'PROMOCAO_PERMITE'
    end
    object PagFormaFDMemTableTEF_USA: TBooleanField
      FieldName = 'TEF_USA'
    end
    object PagFormaFDMemTableAUTORIZACAO_EXIGE: TBooleanField
      FieldName = 'AUTORIZACAO_EXIGE'
    end
    object PagFormaFDMemTablePESSOA_EXIGE: TBooleanField
      FieldName = 'PESSOA_EXIGE'
    end
  end
  object PagFormaDataSource: TDataSource
    DataSet = PagFormaFDMemTable
    Left = 136
    Top = 80
  end
end
