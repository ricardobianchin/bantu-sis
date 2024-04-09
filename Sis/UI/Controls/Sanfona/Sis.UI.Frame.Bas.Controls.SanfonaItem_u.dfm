inherited SanfonaItemBasFrame: TSanfonaItemBasFrame
  Height = 174
  Align = alTop
  AutoSize = True
  StyleElements = []
  ExplicitHeight = 174
  object FundoPanel: TPanel
    Left = 0
    Top = 0
    Width = 385
    Height = 174
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
      Height = 19
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      object TitLabel: TLabel
        Left = 42
        Top = 1
        Width = 44
        Height = 15
        Caption = 'TitLabel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        StyleElements = []
      end
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 36
        Height = 19
        Align = alLeft
        ButtonHeight = 18
        ButtonWidth = 18
        Caption = 'ToolBar1'
        Images = SisImgDataModule.ImageList_9_9
        TabOrder = 0
        object RetrairToolButton: TToolButton
          Left = 0
          Top = 0
          Action = RetrairAction
        end
        object ExpandirToolButton: TToolButton
          Left = 18
          Top = 0
          Action = ExpandirAction
        end
      end
    end
    object MeioPanel: TPanel
      Left = 1
      Top = 20
      Width = 383
      Height = 153
      Margins.Left = 6
      Margins.Top = 0
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      StyleElements = []
      ExplicitTop = 22
    end
  end
  object ActionList1: TActionList
    Images = SisImgDataModule.ImageList_9_9
    Left = 225
    Top = 1
    object ExpandirAction: TAction
      Caption = 'Expandir'
      ImageIndex = 1
      Visible = False
      OnExecute = ExpandirActionExecute
    end
    object RetrairAction: TAction
      Caption = 'Retrair'
      ImageIndex = 0
      OnExecute = RetrairActionExecute
    end
  end
end
