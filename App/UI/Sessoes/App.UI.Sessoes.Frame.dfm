object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 383
  Height = 336
  TabOrder = 0
  object FundoPanel: TPanel
    Left = 0
    Top = 0
    Width = 383
    Height = 336
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    ExplicitLeft = 208
    ExplicitTop = 264
    ExplicitWidth = 185
    ExplicitHeight = 41
    object TopoPanel: TPanel
      Left = 0
      Top = 0
      Width = 383
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitLeft = 104
      ExplicitTop = 96
      ExplicitWidth = 185
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 383
        Height = 29
        ButtonHeight = 21
        ButtonWidth = 47
        Caption = 'ToolBar1'
        List = True
        ShowCaptions = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = NovaSessaoAction
        end
      end
    end
    object BasePanel: TPanel
      Left = 0
      Top = 295
      Width = 383
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
      ExplicitLeft = 104
      ExplicitTop = 96
      ExplicitWidth = 185
    end
    object MeioPanel: TPanel
      Left = 0
      Top = 41
      Width = 383
      Height = 254
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 2
      ExplicitLeft = 104
      ExplicitTop = 96
      ExplicitWidth = 185
      ExplicitHeight = 41
      object SessoesScrollBox: TScrollBox
        Left = 0
        Top = 0
        Width = 383
        Height = 254
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
      end
    end
  end
  object ActionList1: TActionList
    Left = 184
    Top = 97
    object NovaSessaoAction: TAction
      Caption = 'Abrir...'
    end
  end
end
