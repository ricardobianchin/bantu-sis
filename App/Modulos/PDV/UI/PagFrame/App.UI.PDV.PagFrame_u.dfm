inherited PagPDVFrame: TPagPDVFrame
  Width = 800
  Height = 303
  ExplicitWidth = 800
  ExplicitHeight = 303
  inherited MeioPanel: TPanel
    Left = 16
    Top = 16
    Width = 600
    Height = 233
    Align = alNone
    BevelOuter = bvRaised
    ExplicitLeft = 16
    ExplicitTop = 16
    ExplicitWidth = 600
    ExplicitHeight = 233
    object MensLabel: TLabel
      Left = 1
      Top = 171
      Width = 598
      Height = 20
      Align = alBottom
      Alignment = taCenter
      Caption = 'MensLabel'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 192
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      WordWrap = True
      StyleElements = [seClient, seBorder]
      ExplicitWidth = 71
    end
    object TotPanel: TPanel
      Left = 1
      Top = 1
      Width = 598
      Height = 107
      Align = alTop
      Caption = ' '
      TabOrder = 0
      object PagoLabel: TLabel
        Left = 5
        Top = 27
        Width = 42
        Height = 23
        Caption = 'Pago:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        StyleElements = [seClient, seBorder]
      end
      object TotLabel: TLabel
        Left = 5
        Top = 3
        Width = 40
        Height = 23
        Caption = 'Total:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        StyleElements = [seClient, seBorder]
      end
      object FaltaLabel: TLabel
        Left = 5
        Top = 51
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
      object TrocoLabel: TLabel
        Left = 5
        Top = 75
        Width = 46
        Height = 23
        Caption = 'Troco:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        StyleElements = [seClient, seBorder]
      end
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 108
      Width = 598
      Height = 63
      Align = alClient
      BorderStyle = bsNone
      DataSource = VendaPagDataSource
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
      OnKeyDown = DBGrid1KeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'Ordem'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PagamentoFormaTipoDescrRed'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Descr'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Devido'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Cancelado'
          Width = 100
          Visible = True
        end>
    end
    object BasePanel: TPanel
      Left = 1
      Top = 191
      Width = 598
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 2
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 598
        Height = 25
        AutoSize = True
        ButtonHeight = 23
        ButtonWidth = 182
        Caption = 'ToolBar1'
        Flat = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        List = True
        ParentFont = False
        ShowCaptions = True
        TabOrder = 0
        StyleElements = []
        object VoltarToolButton: TToolButton
          Left = 0
          Top = 0
          AutoSize = True
          Caption = 'Esc - Voltar'
          ImageIndex = 1
          OnClick = VoltarToolButtonClick
        end
        object PagPergToolButton: TToolButton
          Left = 82
          Top = 0
          AutoSize = True
          Caption = 'Insert - Novo Pagamento'
          ImageIndex = 0
          OnClick = PagPergToolButtonClick
        end
        object CancelarToolButton: TToolButton
          Left = 245
          Top = 0
          Caption = 'Delete - Cancelar Pagamento'
          ImageIndex = 1
          OnClick = CancelarToolButtonClick
        end
      end
    end
  end
  object VendaPagDataSource: TDataSource
    DataSet = VendaPagFDMemTable
    Left = 264
    Top = 56
  end
  object VendaPagFDMemTable: TFDMemTable
    Active = True
    AfterScroll = VendaPagFDMemTableAfterScroll
    FieldDefs = <
      item
        Name = 'Ordem'
        DataType = ftSmallint
      end
      item
        Name = 'PagamentoFormaTipoDescrRed'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Descr'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'Devido'
        DataType = ftCurrency
        Precision = 19
      end
      item
        Name = 'Cancelado'
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
    Left = 113
    Top = 41
    Content = {
      41444253100000001C030000FF00010001FF02FF03040024000000560065006E
      0064006100500061006700460044004D0065006D005400610062006C00650005
      0024000000560065006E0064006100500061006700460044004D0065006D0054
      00610062006C006500060000000000070000080032000000090000FF0AFF0B04
      000A0000004F007200640065006D0005000A0000004F007200640065006D000C
      00010000000E000D000F000110000111000112000113000114000115000A0000
      004F007200640065006D00FEFF0B04003400000050006100670061006D006500
      6E0074006F0046006F0072006D0061005400690070006F004400650073006300
      720052006500640005003400000050006100670061006D0065006E0074006F00
      46006F0072006D0061005400690070006F004400650073006300720052006500
      64000C00020000000E0016001700080000000F00011000011100011200011300
      0114000115003400000050006100670061006D0065006E0074006F0046006F00
      72006D0061005400690070006F00440065007300630072005200650064001800
      08000000FEFF0B04000A0000004400650073006300720005000A000000440065
      007300630072000C00030000000E0016001700500000000F0001100001110001
      12000113000114000115000A00000044006500730063007200180050000000FE
      FF0B04000C000000440065007600690064006F0005000C000000440065007600
      690064006F000C00040000000E0019001A00130000001B00040000000F000110
      000111000112000113000114000115000C000000440065007600690064006F00
      1C00130000001D0004000000FEFF0B040012000000430061006E00630065006C
      00610064006F00050012000000430061006E00630065006C00610064006F000C
      00050000000E001E000F00011000011100011200011300011400011500120000
      00430061006E00630065006C00610064006F00FEFEFF1FFEFF20FEFF21FF2223
      000000000025002400FF2601000800000031323334353637380300341CDCDF02
      00000004000000FEFEFEFEFEFF27FEFF28290002000000FF2AFEFEFE0E004D00
      61006E0061006700650072001E00550070006400610074006500730052006500
      67006900730074007200790012005400610062006C0065004C00690073007400
      0A005400610062006C00650008004E0061006D006500140053006F0075007200
      630065004E0061006D0065000A0054006100620049004400240045006E006600
      6F0072006300650043006F006E00730074007200610069006E00740073001E00
      4D0069006E0069006D0075006D00430061007000610063006900740079001800
      43006800650063006B004E006F0074004E0075006C006C00140043006F006C00
      75006D006E004C006900730074000C0043006F006C0075006D006E0010005300
      6F007500720063006500490044000E006400740049006E007400310036001000
      4400610074006100540079007000650014005300650061007200630068006100
      62006C006500120041006C006C006F0077004E0075006C006C00080042006100
      7300650014004F0041006C006C006F0077004E0075006C006C0012004F004900
      6E0055007000640061007400650010004F0049006E0057006800650072006500
      1A004F0072006900670069006E0043006F006C004E0061006D00650018006400
      740041006E007300690053007400720069006E0067000800530069007A006500
      140053006F007500720063006500530069007A00650014006400740043007500
      7200720065006E0063007900120050007200650063006900730069006F006E00
      0A005300630061006C0065001E0053006F007500720063006500500072006500
      63006900730069006F006E00160053006F007500720063006500530063006100
      6C00650012006400740042006F006F006C00650061006E001C0043006F006E00
      730074007200610069006E0074004C0069007300740010005600690065007700
      4C006900730074000E0052006F0077004C00690073007400060052006F007700
      0A0052006F0077004900440016007200730055006E006300680061006E006700
      650064001A0052006F0077005000720069006F00720053007400610074006500
      10004F0072006900670069006E0061006C001800520065006C00610074006900
      6F006E004C006900730074001C0055007000640061007400650073004A006F00
      750072006E0061006C001200530061007600650050006F0069006E0074000E00
      4300680061006E00670065007300}
    object VendaPagFDMemTableOrdem: TSmallintField
      Alignment = taCenter
      DisplayWidth = 7
      FieldName = 'Ordem'
    end
    object VendaPagFDMemTablePagamentoFormaTipoDescrRed: TStringField
      DisplayWidth = 8
      FieldName = 'PagamentoFormaTipoDescrRed'
      Size = 8
    end
    object VendaPagFDMemTableDescr: TStringField
      DisplayWidth = 80
      FieldName = 'Descr'
      Size = 80
    end
    object VendaPagFDMemTableDevido: TCurrencyField
      DisplayWidth = 10
      FieldName = 'Devido'
      DisplayFormat = '###,###,##0.00'
    end
    object VendaPagFDMemTableCancelado: TBooleanField
      Alignment = taCenter
      FieldName = 'Cancelado'
      DisplayValues = 'CANCELADO;'
    end
  end
end
