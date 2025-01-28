inherited ShopVendaPDVFrame: TShopVendaPDVFrame
  Width = 1000
  Height = 313
  ExplicitWidth = 1000
  ExplicitHeight = 313
  inherited MeioPanel: TPanel
    Width = 1000
    Height = 280
    ExplicitWidth = 1000
    ExplicitHeight = 280
    object InputPanel: TPanel
      Left = 0
      Top = 189
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
      Left = 0
      Top = 105
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
    object TotalPanel: TPanel
      Left = 24
      Top = 15
      Width = 289
      Height = 68
      BevelOuter = bvNone
      Caption = '  '
      Color = 16574927
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
      StyleElements = []
      DesignSize = (
        289
        68)
      object TotalLiquidoLabel: TLabel
        Left = 8
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
        Left = 8
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
        ExplicitTop = 59
      end
    end
  end
  object BasePanel: TPanel
    Left = 0
    Top = 280
    Width = 1000
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
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
        Caption = 'PgUp: Finalize'
        ImageIndex = 3
        OnClick = PagamentoToolButtonClick
      end
      object ToolButton2: TToolButton
        Left = 441
        Top = 0
        AutoSize = True
        Caption = 'C - Cliente'
        ImageIndex = 4
      end
      object ToolButton1: TToolButton
        Left = 513
        Top = 0
        AutoSize = True
        Caption = 'D - CPF'
        ImageIndex = 5
      end
      object ToolButton3: TToolButton
        Left = 569
        Top = 0
        AutoSize = True
        Caption = 'E - Entrega'
        ImageIndex = 6
      end
      object GavetaToolButton: TToolButton
        Left = 642
        Top = 0
        AutoSize = True
        Caption = 'G - Gaveta'
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
