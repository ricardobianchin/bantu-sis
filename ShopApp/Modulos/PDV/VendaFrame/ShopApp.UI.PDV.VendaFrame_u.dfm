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
      Left = 112
      Top = 1
      Width = 729
      Height = 29
      Align = alNone
      ButtonHeight = 21
      ButtonWidth = 124
      Caption = 'PDVToolBar'
      List = True
      ShowCaptions = True
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Caption = 'ToolButton1'
        ImageIndex = 0
      end
      object ItemCanceleToolButton: TToolButton
        Left = 124
        Top = 0
        Caption = 'Delete: Cancelar Item'
        ImageIndex = 1
        OnClick = ItemCanceleToolButtonClick
      end
      object ToolButton3: TToolButton
        Left = 248
        Top = 0
        Caption = 'ToolButton3'
        ImageIndex = 2
      end
      object ToolButton4: TToolButton
        Left = 372
        Top = 0
        Caption = 'ToolButton4'
        ImageIndex = 3
      end
      object ToolButton2: TToolButton
        Left = 496
        Top = 0
        Caption = 'ToolButton2'
        ImageIndex = 4
      end
    end
  end
  object CaretTimer: TTimer
    OnTimer = CaretTimerTimer
    Left = 152
    Top = 32
  end
end
