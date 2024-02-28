inherited SanfonaFrame: TSanfonaFrame
  Width = 621
  Height = 330
  ExplicitWidth = 621
  ExplicitHeight = 330
  object FundoPanel: TPanel
    Left = 0
    Top = 0
    Width = 621
    Height = 330
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object TopoPanel: TPanel
      Left = 0
      Top = 0
      Width = 621
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      object TitLabel: TLabel
        Left = 192
        Top = 4
        Width = 41
        Height = 15
        Caption = 'TitLabel'
      end
      object ToolBar1: TToolBar
        Left = 1
        Top = 1
        Width = 184
        Height = 21
        Align = alNone
        AutoSize = True
        ButtonHeight = 21
        ButtonWidth = 92
        Caption = 'ToolBar1'
        List = True
        ShowCaptions = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Caption = 'Expandir Todos'
          ImageIndex = 0
        end
        object ToolButton2: TToolButton
          Left = 92
          Top = 0
          Caption = 'Retrair Todos'
          ImageIndex = 1
        end
      end
    end
    object ScrollBox1: TScrollBox
      Left = 177
      Top = 22
      Width = 444
      Height = 308
      Hint = 'frame'
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      TabOrder = 1
      ExplicitLeft = 121
      ExplicitWidth = 500
    end
    object TreeView1: TTreeView
      Left = 0
      Top = 22
      Width = 177
      Height = 308
      Align = alLeft
      BorderStyle = bsNone
      Indent = 19
      TabOrder = 2
      OnChange = TreeView1Change
    end
  end
end
