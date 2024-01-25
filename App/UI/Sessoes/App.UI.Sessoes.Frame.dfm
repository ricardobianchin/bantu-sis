object SessoesFrame: TSessoesFrame
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
    ParentBackground = False
    TabOrder = 0
    object TopoPanel: TPanel
      Left = 0
      Top = 0
      Width = 383
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 383
        Height = 29
        ButtonHeight = 21
        ButtonWidth = 110
        Caption = 'ToolBar1'
        Color = clBtnFace
        List = True
        ParentColor = False
        ParentShowHint = False
        ShowCaptions = True
        ShowHint = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = AbrirRetaguardaAction
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
    object AbrirRetaguardaAction: TAction
      Caption = 'Abrir Retaguarda...'
      Visible = False
      OnExecute = AbrirRetaguardaActionExecute
    end
  end
end
