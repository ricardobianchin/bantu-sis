inherited ShopVendaPDVFrame: TShopVendaPDVFrame
  Width = 542
  Height = 311
  ExplicitWidth = 542
  ExplicitHeight = 311
  inherited MeioPanel: TPanel
    Width = 542
    Height = 311
    ExplicitWidth = 542
    ExplicitHeight = 311
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
    object ListBox1: TListBox
      Left = 288
      Top = 0
      Width = 225
      Height = 153
      TabStop = False
      ItemHeight = 15
      TabOrder = 1
      OnEnter = ListBox1Enter
    end
  end
  object CaretTimer: TTimer
    OnTimer = CaretTimerTimer
    Left = 152
    Top = 32
  end
end
