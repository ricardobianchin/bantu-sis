inherited PagPergForm: TPagPergForm
  Caption = 'PagPergForm'
  ClientHeight = 332
  ClientWidth = 641
  StyleElements = [seClient, seBorder]
  ExplicitWidth = 653
  ExplicitHeight = 370
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 312
    Width = 641
    ExplicitTop = 312
  end
  inherited AlteracaoTextoLabel: TLabel
    Left = 152
    Top = 20
    Width = 106
    Align = alNone
    ExplicitLeft = 152
    ExplicitTop = 20
  end
  object FaltaLabel: TLabel [2]
    Left = 5
    Top = 6
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
  object FormaPagObsLabel: TLabel [3]
    Left = 0
    Top = 237
    Width = 267
    Height = 15
    Caption = 'Escolha a Forma de Pagamento com as setas ['#8593']['#8595']'
  end
  object MoldeValorLabeledEdit: TLabeledEdit [4]
    Left = 467
    Top = 57
    Width = 108
    Height = 29
    Alignment = taCenter
    EditLabel.Width = 36
    EditLabel.Height = 29
    EditLabel.Caption = 'Valor'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -16
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    LabelPosition = lpLeft
    LabelSpacing = 6
    ParentFont = False
    TabOrder = 0
    Text = '123,45'
    StyleElements = [seClient, seBorder]
    OnChange = MoldeValorLabeledEditChange
    OnKeyPress = MoldeValorLabeledEditKeyPress
  end
  object EntreguePanel: TPanel [5]
    Left = 397
    Top = 105
    Width = 178
    Height = 90
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 3
    object Label1: TLabel
      Left = 17
      Top = 30
      Width = 157
      Height = 15
      Caption = 'Zero = recebeu dinheiro certo'
    end
    object MoldeTrocoLabeledEdit: TLabeledEdit
      Left = 70
      Top = 61
      Width = 108
      Height = 29
      TabStop = False
      Alignment = taCenter
      EditLabel.Width = 38
      EditLabel.Height = 29
      EditLabel.Caption = 'Troco'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Segoe UI'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      LabelPosition = lpLeft
      LabelSpacing = 6
      ParentFont = False
      TabOrder = 0
      Text = '1234567,89'
      StyleElements = [seClient, seBorder]
      OnKeyPress = MoldeValorLabeledEditKeyPress
    end
    object MoldeEntregueLabeledEdit: TLabeledEdit
      Left = 70
      Top = 1
      Width = 108
      Height = 29
      Alignment = taCenter
      EditLabel.Width = 64
      EditLabel.Height = 29
      EditLabel.Caption = 'Recebido'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Segoe UI'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      LabelPosition = lpLeft
      LabelSpacing = 6
      ParentFont = False
      TabOrder = 1
      Text = '123,45'
      StyleElements = [seClient, seBorder]
      OnChange = MoldeEntregueLabeledEditChange
      OnKeyPress = MoldeEntregueLabeledEditKeyPress
    end
  end
  object ToolBar1: TToolBar [6]
    Left = 0
    Top = 286
    Width = 641
    Height = 26
    Align = alBottom
    AutoSize = True
    ButtonHeight = 26
    ButtonWidth = 182
    Caption = 'ToolBar1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    List = True
    ParentFont = False
    ShowCaptions = True
    TabOrder = 2
    StyleElements = [seClient, seBorder]
    ExplicitTop = 285
    ExplicitWidth = 637
    object ValorFaltaToolButton: TToolButton
      Left = 0
      Top = 0
      AutoSize = True
      Caption = 'F3 - Colar Valor que Falta'
      ImageIndex = 0
      OnClick = ValorFaltaToolButtonClick
    end
    object CancelarToolButton: TToolButton
      Left = 182
      Top = 0
      AutoSize = True
      Caption = 'Esc - Voltar'
      ImageIndex = 1
      OnClick = CancelarToolButtonClick
    end
    object OkToolButton: TToolButton
      Left = 272
      Top = 0
      AutoSize = True
      Caption = 'Enter - Gravar Pagamento'
      ImageIndex = 2
    end
  end
  object PagFormaDBGrid: TDBGrid [7]
    Left = 3
    Top = 41
    Width = 345
    Height = 192
    TabStop = False
    BorderStyle = bsNone
    DataSource = PagFormaDataSource
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    Options = [dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnColEnter = PagFormaDBGridColEnter
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
        Width = 250
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
  inherited ShowTimer_BasForm: TTimer
    Left = 24
    Top = 80
  end
  inherited ActionList1_Diag: TActionList
    Top = 152
  end
  object PagFormaDataSource: TDataSource
    DataSet = PagFormaFDMemTable
    Left = 136
    Top = 80
  end
  object PagFormaFDMemTable: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'PAGAMENTO_FORMA_ID'
        DataType = ftInteger
      end
      item
        Name = 'PAGAMENTO_FORMA_TIPO_ID'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'TIPO_DESCR_RED'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'FORMA_DESCR'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'VALOR_MINIMO'
        DataType = ftCurrency
        Precision = 19
      end
      item
        Name = 'PROMOCAO_PERMITE'
        DataType = ftBoolean
      end
      item
        Name = 'TEF_USA'
        DataType = ftBoolean
      end
      item
        Name = 'AUTORIZACAO_EXIGE'
        DataType = ftBoolean
      end
      item
        Name = 'PESSOA_EXIGE'
        DataType = ftBoolean
      end
      item
        Name = 'ACEITA_TROCO'
        DataType = ftBoolean
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 64
    Top = 144
    Content = {
      41444253100000002D060000FF00010001FF02FF030400240000005000610067
      0046006F0072006D006100460044004D0065006D005400610062006C00650005
      002400000050006100670046006F0072006D006100460044004D0065006D0054
      00610062006C006500060000000000070000080032000000090000FF0AFF0B04
      002400000050004100470041004D0045004E0054004F005F0046004F0052004D
      0041005F004900440005002400000050004100470041004D0045004E0054004F
      005F0046004F0052004D0041005F00490044000C00010000000E000D000F0001
      10000111000112000113000114000115002400000050004100470041004D0045
      004E0054004F005F0046004F0052004D0041005F0049004400FEFF0B04002E00
      000050004100470041004D0045004E0054004F005F0046004F0052004D004100
      5F005400490050004F005F004900440005002E00000050004100470041004D00
      45004E0054004F005F0046004F0052004D0041005F005400490050004F005F00
      490044000C00020000000E0016001700010000000F0001100001110001120001
      13000114000115002E00000050004100470041004D0045004E0054004F005F00
      46004F0052004D0041005F005400490050004F005F0049004400180001000000
      FEFF0B04001C0000005400490050004F005F00440045005300430052005F0052
      004500440005001C0000005400490050004F005F00440045005300430052005F
      005200450044000C00030000000E0016001700080000000F0001100001110001
      12000113000114000115001C0000005400490050004F005F0044004500530043
      0052005F00520045004400180008000000FEFF0B04001600000046004F005200
      4D0041005F004400450053004300520005001600000046004F0052004D004100
      5F00440045005300430052000C00040000000E0016001700320000000F000110
      000111000112000113000114000115001600000046004F0052004D0041005F00
      44004500530043005200180032000000FEFF0B040018000000560041004C004F
      0052005F004D0049004E0049004D004F00050018000000560041004C004F0052
      005F004D0049004E0049004D004F000C00050000000E0019001A00130000001B
      00040000000F0001100001110001120001130001140001150018000000560041
      004C004F0052005F004D0049004E0049004D004F001C00130000001D00040000
      00FEFF0B040020000000500052004F004D004F00430041004F005F0050004500
      52004D00490054004500050020000000500052004F004D004F00430041004F00
      5F005000450052004D004900540045000C00060000000E001E000F0001100001
      110001120001130001140001150020000000500052004F004D004F0043004100
      4F005F005000450052004D00490054004500FEFF0B04000E0000005400450046
      005F0055005300410005000E0000005400450046005F005500530041000C0007
      0000000E001E000F000110000111000112000113000114000115000E00000054
      00450046005F00550053004100FEFF0B0400220000004100550054004F005200
      49005A004100430041004F005F00450058004900470045000500220000004100
      550054004F00520049005A004100430041004F005F0045005800490047004500
      0C00080000000E001E000F000110000111000112000113000114000115002200
      00004100550054004F00520049005A004100430041004F005F00450058004900
      47004500FEFF0B04001800000050004500530053004F0041005F004500580049
      004700450005001800000050004500530053004F0041005F0045005800490047
      0045000C00090000000E001E000F000110000111000112000113000114000115
      001800000050004500530053004F0041005F0045005800490047004500FEFF0B
      0400180000004100430045004900540041005F00540052004F0043004F000500
      180000004100430045004900540041005F00540052004F0043004F000C000A00
      00000E001E000F00011000011100011200011300011400011500180000004100
      430045004900540041005F00540052004F0043004F00FEFEFF1FFEFF20FEFF21
      FF22230000000000FF240200080000003132333435363738FEFEFEFEFEFF25FE
      FF26270001000000FF28FEFEFE0E004D0061006E0061006700650072001E0055
      0070006400610074006500730052006500670069007300740072007900120054
      00610062006C0065004C006900730074000A005400610062006C00650008004E
      0061006D006500140053006F0075007200630065004E0061006D0065000A0054
      006100620049004400240045006E0066006F0072006300650043006F006E0073
      0074007200610069006E00740073001E004D0069006E0069006D0075006D0043
      006100700061006300690074007900180043006800650063006B004E006F0074
      004E0075006C006C00140043006F006C0075006D006E004C006900730074000C
      0043006F006C0075006D006E00100053006F007500720063006500490044000E
      006400740049006E007400330032001000440061007400610054007900700065
      001400530065006100720063006800610062006C006500120041006C006C006F
      0077004E0075006C006C000800420061007300650014004F0041006C006C006F
      0077004E0075006C006C0012004F0049006E0055007000640061007400650010
      004F0049006E00570068006500720065001A004F0072006900670069006E0043
      006F006C004E0061006D00650018006400740041006E00730069005300740072
      0069006E0067000800530069007A006500140053006F00750072006300650053
      0069007A006500140064007400430075007200720065006E0063007900120050
      007200650063006900730069006F006E000A005300630061006C0065001E0053
      006F00750072006300650050007200650063006900730069006F006E00160053
      006F0075007200630065005300630061006C00650012006400740042006F006F
      006C00650061006E001C0043006F006E00730074007200610069006E0074004C
      00690073007400100056006900650077004C006900730074000E0052006F0077
      004C00690073007400060052006F0077000A0052006F0077004900440010004F
      0072006900670069006E0061006C001800520065006C006100740069006F006E
      004C006900730074001C0055007000640061007400650073004A006F00750072
      006E0061006C001200530061007600650050006F0069006E0074000E00430068
      0061006E00670065007300}
    object PagFormaFDMemTablePAGAMENTO_FORMA_ID: TIntegerField
      FieldName = 'PAGAMENTO_FORMA_ID'
    end
    object PagFormaFDMemTablePAGAMENTO_FORMA_TIPO_ID: TStringField
      FieldName = 'PAGAMENTO_FORMA_TIPO_ID'
      Size = 1
    end
    object PagFormaFDMemTableTIPO_DESCR_RED: TStringField
      DisplayWidth = 8
      FieldName = 'TIPO_DESCR_RED'
      Size = 8
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
    object PagFormaFDMemTableACEITA_TROCO: TBooleanField
      FieldName = 'ACEITA_TROCO'
    end
  end
end
