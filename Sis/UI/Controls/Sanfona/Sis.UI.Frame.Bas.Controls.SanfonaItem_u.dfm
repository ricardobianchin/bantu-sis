inherited SanfonaItemBasFrame: TSanfonaItemBasFrame
  Hint = 'frame'
  Align = alTop
  AutoSize = True
  StyleElements = []
  object FundoPanel: TPanel
    Left = 0
    Top = 0
    Width = 385
    Height = 176
    Hint = 'FundoPanel'
    Align = alTop
    AutoSize = True
    BevelOuter = bvLowered
    Caption = ' '
    TabOrder = 0
    StyleElements = []
    object TopoPanel: TPanel
      Left = 1
      Top = 1
      Width = 383
      Height = 21
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      object TitLabel: TLabel
        Left = 123
        Top = 3
        Width = 41
        Height = 15
        Caption = 'TitLabel'
      end
      object ToolBar1: TToolBar
        Left = 1
        Top = 0
        Width = 116
        Height = 21
        Align = alNone
        ButtonHeight = 21
        ButtonWidth = 58
        Caption = 'ToolBar1'
        List = True
        ShowCaptions = True
        TabOrder = 0
        object ExpandirToolButton: TToolButton
          Left = 0
          Top = 0
          Action = ExpandirAction
        end
        object RetrairToolButton: TToolButton
          Left = 58
          Top = 0
          Action = RetrairAction
        end
      end
    end
    object MeioPanel: TPanel
      Left = 1
      Top = 22
      Width = 383
      Height = 153
      Hint = 'MeioPanel'
      Margins.Left = 6
      Margins.Top = 0
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      StyleElements = []
    end
  end
  object ActionList1: TActionList
    Left = 225
    Top = 1
    object ExpandirAction: TAction
      Caption = 'Expandir'
      Visible = False
      OnExecute = ExpandirActionExecute
    end
    object RetrairAction: TAction
      Caption = 'Retrair'
      OnExecute = RetrairActionExecute
    end
  end
end
