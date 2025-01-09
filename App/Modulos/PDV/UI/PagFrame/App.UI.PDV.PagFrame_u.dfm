inherited PagPDVFrame: TPagPDVFrame
  Width = 556
  Height = 303
  ExplicitWidth = 556
  ExplicitHeight = 303
  inherited MeioPanel: TPanel
    Left = 16
    Top = 16
    Width = 425
    Height = 233
    Align = alNone
    BevelOuter = bvRaised
    ExplicitLeft = 16
    ExplicitTop = 16
    ExplicitWidth = 425
    ExplicitHeight = 233
    object TotPanel: TPanel
      Left = 1
      Top = 1
      Width = 423
      Height = 104
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
      Top = 105
      Width = 423
      Height = 86
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
          Width = 46
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Descr'
          Width = 600
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Cancelado'
          Width = 109
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor'
          Visible = True
        end>
    end
    object BasePanel: TPanel
      Left = 1
      Top = 191
      Width = 423
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 2
      ExplicitLeft = 120
      ExplicitTop = 96
      ExplicitWidth = 185
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 423
        Height = 29
        ButtonHeight = 21
        ButtonWidth = 145
        Caption = 'ToolBar1'
        Flat = False
        List = True
        ShowCaptions = True
        TabOrder = 0
        StyleElements = []
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Caption = 'Insert - Novo Pagamento'
          ImageIndex = 0
          OnClick = ToolButton1Click
        end
      end
    end
  end
  object VendaPagFDMemTable: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'Ordem'
        DataType = ftSmallint
      end
      item
        Name = 'Descr'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'Cancelado'
        DataType = ftBoolean
      end
      item
        Name = 'Valor'
        DataType = ftCurrency
        Precision = 19
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
    Left = 169
    Top = 57
    Content = {
      414442531000000036020000FF00010001FF02FF03040016000000460044004D
      0065006D005400610062006C0065003100050016000000460044004D0065006D
      005400610062006C0065003100060000000000070000080032000000090000FF
      0AFF0B04000A0000004F007200640065006D0005000A0000004F007200640065
      006D000C00010000000E000D000F000110000111000112000113000114000115
      000A0000004F007200640065006D00FEFF0B04000A0000004400650073006300
      720005000A000000440065007300630072000C00020000000E0016001700C800
      00000F000110000111000112000113000114000115000A000000440065007300
      630072001800C8000000FEFF0B040012000000430061006E00630065006C0061
      0064006F00050012000000430061006E00630065006C00610064006F000C0003
      0000000E0019000F000110000111000112000113000114000115001200000043
      0061006E00630065006C00610064006F00FEFF0B04000A000000560061006C00
      6F00720005000A000000560061006C006F0072000C00040000000E001A001B00
      130000001C00040000000F000110000111000112000113000114000115000A00
      0000560061006C006F0072001D00130000001E0004000000FEFEFF1FFEFF20FE
      FF21FF22230000000000FF2400000C0001001D00000043415254414F20444520
      4352454449544F202D2043524544494341524402000000030078029649000000
      00FEFEFEFEFEFF25FEFF26270001000000FF28FEFEFE0E004D0061006E006100
      6700650072001E00550070006400610074006500730052006500670069007300
      74007200790012005400610062006C0065004C006900730074000A0054006100
      62006C00650008004E0061006D006500140053006F0075007200630065004E00
      61006D0065000A0054006100620049004400240045006E0066006F0072006300
      650043006F006E00730074007200610069006E00740073001E004D0069006E00
      69006D0075006D00430061007000610063006900740079001800430068006500
      63006B004E006F0074004E0075006C006C00140043006F006C0075006D006E00
      4C006900730074000C0043006F006C0075006D006E00100053006F0075007200
      63006500490044000E006400740049006E007400310036001000440061007400
      610054007900700065001400530065006100720063006800610062006C006500
      120041006C006C006F0077004E0075006C006C00080042006100730065001400
      4F0041006C006C006F0077004E0075006C006C0012004F0049006E0055007000
      640061007400650010004F0049006E00570068006500720065001A004F007200
      6900670069006E0043006F006C004E0061006D00650018006400740041006E00
      7300690053007400720069006E0067000800530069007A006500140053006F00
      7500720063006500530069007A00650012006400740042006F006F006C006500
      61006E00140064007400430075007200720065006E0063007900120050007200
      650063006900730069006F006E000A005300630061006C0065001E0053006F00
      750072006300650050007200650063006900730069006F006E00160053006F00
      75007200630065005300630061006C0065001C0043006F006E00730074007200
      610069006E0074004C00690073007400100056006900650077004C0069007300
      74000E0052006F0077004C00690073007400060052006F0077000A0052006F00
      77004900440010004F0072006900670069006E0061006C001800520065006C00
      6100740069006F006E004C006900730074001C00550070006400610074006500
      73004A006F00750072006E0061006C001200530061007600650050006F006900
      6E0074000E004300680061006E00670065007300}
    object VendaPagFDMemTableOrdem: TSmallintField
      Alignment = taCenter
      DisplayWidth = 7
      FieldName = 'Ordem'
    end
    object VendaPagFDMemTableDescr: TStringField
      DisplayWidth = 200
      FieldName = 'Descr'
      Size = 200
    end
    object VendaPagFDMemTableCancelado: TBooleanField
      Alignment = taCenter
      FieldName = 'Cancelado'
      DisplayValues = ';CANCELADO'
    end
    object VendaPagFDMemTableValor: TCurrencyField
      DisplayWidth = 10
      FieldName = 'Valor'
      DisplayFormat = '###,###,##0.00'
    end
  end
  object VendaPagDataSource: TDataSource
    DataSet = VendaPagFDMemTable
    Left = 264
    Top = 56
  end
end
