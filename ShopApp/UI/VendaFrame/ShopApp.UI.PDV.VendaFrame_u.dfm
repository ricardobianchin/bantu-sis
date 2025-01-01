inherited ShopVendaPDVFrame: TShopVendaPDVFrame
  Width = 1000
  Height = 400
  ExplicitWidth = 1000
  ExplicitHeight = 400
  inherited MeioPanel: TPanel
    Width = 1000
    Height = 400
    ExplicitWidth = 1000
    ExplicitHeight = 400
    object InputPanel: TPanel
      Left = 0
      Top = 325
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
      Left = 308
      Top = 15
      Width = 162
      Height = 120
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
    end
    object ItemPanel: TPanel
      Left = 0
      Top = 225
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
      Height = 114
      BevelOuter = bvLowered
      Caption = '  '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      StyleElements = []
      DesignSize = (
        289
        114)
      object TotalBrutoLabel: TLabel
        Left = 10
        Top = 11
        Width = 206
        Height = 37
        Caption = 'TotalBrutoLabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        StyleElements = []
      end
      object VolumesLabel: TLabel
        Left = 10
        Top = 83
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
  object CaretTimer: TTimer
    OnTimer = CaretTimerTimer
    Left = 152
    Top = 32
  end
end
