inherited ShopVendaPDVFrame: TShopVendaPDVFrame
  Width = 1000
  Height = 383
  ExplicitWidth = 1000
  ExplicitHeight = 383
  inherited MeioPanel: TPanel
    Width = 1000
    Height = 350
    StyleElements = [seFont, seClient, seBorder]
    ExplicitWidth = 1000
    ExplicitHeight = 280
    object MedeFontesInputPaintBox: TPaintBox
      Left = 513
      Top = 15
      Width = 96
      Height = 59
      Visible = False
    end
    object MedeFontesGridPaintBox: TPaintBox
      Left = 514
      Top = 87
      Width = 96
      Height = 59
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object InputPanel: TPanel
      Left = 8
      Top = 277
      Width = 513
      Height = 65
      BevelOuter = bvLowered
      Caption = '  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -33
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        513
        65)
      object StrBuscaLabel: TLabel
        Left = 42
        Top = 7
        Width = 467
        Height = 45
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Quantidade * C'#243'digo / C'#243'digo'
      end
      object CaretShape: TShape
        Left = 490
        Top = 52
        Width = 19
        Height = 5
        Anchors = [akTop, akRight]
        Brush.Color = clBtnText
        Pen.Style = psClear
      end
    end
    object FitaStringGrid: TStringGrid
      Left = 360
      Top = -1
      Width = 162
      Height = 98
      TabStop = False
      BorderStyle = bsNone
      ColCount = 1
      DefaultRowHeight = 34
      FixedCols = 0
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goRowSelect]
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 1
      StyleElements = []
      OnDrawCell = FitaStringGridDrawCell
      OnEnter = FitaStringGridEnter
    end
    object ItemPanel: TPanel
      Left = 8
      Top = 193
      Width = 513
      Height = 72
      BevelOuter = bvLowered
      Caption = '  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      StyleElements = []
      DesignSize = (
        513
        72)
      object ItemDescrLabel: TLabel
        Left = 5
        Top = 27
        Width = 212
        Height = 40
        Anchors = [akLeft, akBottom]
        Caption = 'ItemDescrLabel'
        StyleElements = []
      end
      object ItemTotalLabel: TLabel
        Left = 305
        Top = 25
        Width = 203
        Height = 40
        Alignment = taRightJustify
        Anchors = [akRight, akBottom]
        Caption = 'ItemTotalLabel'
        StyleElements = []
      end
    end
    object TotalExtPanel: TPanel
      Left = 13
      Top = 7
      Width = 319
      Height = 68
      BevelOuter = bvNone
      Caption = ' '
      Color = 16765337
      ParentBackground = False
      TabOrder = 3
      StyleElements = []
      object TotalExtEsqPanel: TPanel
        Left = 0
        Top = 0
        Width = 15
        Height = 68
        Align = alLeft
        BevelOuter = bvNone
        Caption = ' '
        Color = 16765337
        ParentBackground = False
        TabOrder = 0
        StyleElements = []
        object PaintBox1: TPaintBox
          Left = 0
          Top = 0
          Width = 15
          Height = 15
          Align = alTop
          OnPaint = PaintBox1Paint
          ExplicitTop = 8
        end
        object PaintBox3: TPaintBox
          Left = 0
          Top = 53
          Width = 15
          Height = 15
          Align = alBottom
          OnPaint = PaintBox3Paint
          ExplicitTop = 0
        end
      end
      object TotalExtDirPanel: TPanel
        Left = 304
        Top = 0
        Width = 15
        Height = 68
        Align = alRight
        BevelOuter = bvNone
        Caption = ' '
        Color = 16765337
        ParentBackground = False
        TabOrder = 1
        StyleElements = []
        object PaintBox2: TPaintBox
          Left = 0
          Top = 0
          Width = 15
          Height = 15
          Align = alTop
          OnPaint = PaintBox2Paint
        end
        object PaintBox4: TPaintBox
          Left = 0
          Top = 53
          Width = 15
          Height = 15
          Align = alBottom
          OnPaint = PaintBox4Paint
          ExplicitTop = 0
        end
      end
      object TotalPanel: TPanel
        Left = 15
        Top = 0
        Width = 289
        Height = 68
        Align = alClient
        BevelOuter = bvNone
        Caption = '  '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 2
        StyleElements = []
        ExplicitLeft = 24
        DesignSize = (
          289
          68)
        object TotalLiquidoLabel: TLabel
          Left = 0
          Top = -2
          Width = 231
          Height = 37
          Caption = 'TotalLiquidoLabel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          StyleElements = []
        end
        object VolumesLabel: TLabel
          Left = 0
          Top = 43
          Width = 97
          Height = 21
          Anchors = [akLeft, akBottom]
          Caption = 'VolumesLabel'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          StyleElements = []
        end
      end
    end
    object PaintPanel1: TPanel
      Left = 32
      Top = 98
      Width = 15
      Height = 15
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 4
      object PaintBoxGrid1: TPaintBox
        Left = 0
        Top = 0
        Width = 15
        Height = 15
        Align = alClient
        OnPaint = PaintBoxGrid1Paint
      end
    end
    object PaintPanel2: TPanel
      Left = 56
      Top = 98
      Width = 15
      Height = 15
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 5
      object PaintBoxGrid2: TPaintBox
        Left = 0
        Top = 0
        Width = 15
        Height = 15
        Align = alClient
        OnPaint = PaintBoxGrid2Paint
      end
    end
    object PaintPanel3: TPanel
      Left = 80
      Top = 98
      Width = 15
      Height = 15
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 6
      object PaintBoxGrid3: TPaintBox
        Left = 0
        Top = 0
        Width = 15
        Height = 15
        Align = alClient
        OnPaint = PaintBoxGrid3Paint
      end
    end
    object PaintPanel4: TPanel
      Left = 104
      Top = 98
      Width = 15
      Height = 15
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 7
      object PaintBoxGrid4: TPaintBox
        Left = 0
        Top = 0
        Width = 15
        Height = 15
        Align = alClient
        OnPaint = PaintBoxGrid4Paint
      end
    end
    object ItemPaintPanel1: TPanel
      Left = 32
      Top = 118
      Width = 15
      Height = 15
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 8
      object ItemPaintBox1: TPaintBox
        Left = 0
        Top = 0
        Width = 15
        Height = 15
        Align = alClient
        OnPaint = ItemPaintBox1Paint
      end
    end
    object ItemPaintPanel2: TPanel
      Left = 56
      Top = 118
      Width = 15
      Height = 15
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 9
      object ItemPaintBox2: TPaintBox
        Left = 0
        Top = 0
        Width = 15
        Height = 15
        Align = alClient
        OnPaint = ItemPaintBox2Paint
      end
    end
    object ItemPaintPanel3: TPanel
      Left = 80
      Top = 118
      Width = 15
      Height = 15
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 10
      object ItemPaintBox3: TPaintBox
        Left = 0
        Top = 0
        Width = 15
        Height = 15
        Align = alClient
        OnPaint = ItemPaintBox3Paint
      end
    end
    object ItemPaintPanel4: TPanel
      Left = 104
      Top = 118
      Width = 15
      Height = 15
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 11
      object ItemPaintBox4: TPaintBox
        Left = 0
        Top = 0
        Width = 15
        Height = 15
        Align = alClient
        OnPaint = ItemPaintBox4Paint
      end
    end
    object InputPaintPanel1: TPanel
      Left = 32
      Top = 138
      Width = 15
      Height = 15
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 12
      object InputPaintBox1: TPaintBox
        Left = 0
        Top = 0
        Width = 15
        Height = 15
        Align = alClient
        OnPaint = InputPaintBox1Paint
      end
    end
    object InputPaintPanel2: TPanel
      Left = 56
      Top = 138
      Width = 15
      Height = 15
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 13
      object InputPaintBox2: TPaintBox
        Left = 0
        Top = 0
        Width = 15
        Height = 15
        Align = alClient
        OnPaint = InputPaintBox2Paint
      end
    end
    object InputPaintPanel3: TPanel
      Left = 80
      Top = 138
      Width = 15
      Height = 15
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 14
      object InputPaintBox3: TPaintBox
        Left = 0
        Top = 0
        Width = 15
        Height = 15
        Align = alClient
        OnPaint = InputPaintBox3Paint
      end
    end
    object InputPaintPanel4: TPanel
      Left = 104
      Top = 138
      Width = 15
      Height = 15
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 15
      object InputPaintBox4: TPaintBox
        Left = 0
        Top = 0
        Width = 15
        Height = 15
        Align = alClient
        OnPaint = InputPaintBox4Paint
      end
    end
  end
  object BasePanel: TPanel
    Left = 0
    Top = 350
    Width = 1000
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitTop = 280
    object PDVToolBar: TToolBar
      Left = 32
      Top = 1
      Width = 745
      Height = 23
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 145
      Caption = 'PDVToolBar'
      Flat = False
      List = True
      ShowCaptions = True
      TabOrder = 0
      StyleElements = []
      object VoltouToolButton: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = 'Esc - Voltar'
        ImageIndex = 0
      end
      object ItemCanceleToolButton: TToolButton
        Left = 74
        Top = 0
        AutoSize = True
        Caption = 'Delete: Cancelar Item'
        ImageIndex = 1
        OnClick = ItemCanceleToolButtonClick
      end
      object PagSomenteDinheiroToolButton: TToolButton
        Left = 202
        Top = 0
        AutoSize = True
        Caption = 'PgDn: Somente Dinheiro '
        ImageIndex = 2
        OnClick = PagSomenteDinheiroToolButtonClick
      end
      object PagamentoToolButton: TToolButton
        Left = 351
        Top = 0
        AutoSize = True
        Caption = 'PgUp: Totalize'
        ImageIndex = 3
        OnClick = PagamentoToolButtonClick
      end
      object ToolButton2: TToolButton
        Left = 441
        Top = 0
        AutoSize = True
        Caption = 'F3 - Cliente'
        ImageIndex = 4
      end
      object CPFToolButton: TToolButton
        Left = 517
        Top = 0
        AutoSize = True
        Caption = 'F4 - CPF'
        ImageIndex = 5
      end
      object GavetaToolButton: TToolButton
        Left = 577
        Top = 0
        AutoSize = True
        Caption = 'F6 - Gaveta'
        ImageIndex = 7
        OnClick = GavetaToolButtonClick
      end
    end
  end
  object CaretTimer: TTimer
    OnTimer = CaretTimerTimer
    Left = 152
    Top = 32
  end
end
