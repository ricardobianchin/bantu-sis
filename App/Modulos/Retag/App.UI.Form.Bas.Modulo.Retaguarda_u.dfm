inherited RetaguardaModuloBasForm: TRetaguardaModuloBasForm
  Caption = 'RetaguardaModuloBasForm'
  ClientWidth = 604
  OnDestroy = FormDestroy
  ExplicitWidth = 604
  TextHeight = 15
  inherited TitleBarPanel: TPanel
    Width = 604
    ExplicitWidth = 604
    DesignSize = (
      604
      30)
  end
  object MenuPanel: TPanel [1]
    Left = 0
    Top = 30
    Width = 604
    Height = 123
    Align = alTop
    Caption = ' '
    TabOrder = 1
    object MenuPageControl: TPageControl
      Left = 1
      Top = 1
      Width = 602
      Height = 121
      ActivePage = AjudaTabSheet
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      object EstoqueTabSheet: TTabSheet
        Caption = 'Estoque'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        object EstProdGroupBox: TGroupBox
          Left = 1
          Top = -3
          Width = 185
          Height = 77
          Caption = 'Produtos'
          TabOrder = 0
          object EstoqueToolBar: TToolBar
            Left = 2
            Top = 17
            Width = 181
            Height = 54
            ButtonHeight = 54
            ButtonWidth = 67
            Caption = 'EstoqueToolBar'
            Ctl3D = False
            EdgeInner = esNone
            EdgeOuter = esNone
            Images = RetagImgDM.ImageList_32_32
            ShowCaptions = True
            TabOrder = 0
            object EstProdFabrToolButton: TToolButton
              Left = 0
              Top = 0
              Action = RetagEstProdFabrAction
            end
            object EstProdTipoToolButton: TToolButton
              Left = 67
              Top = 0
              Action = RetagEstProdTipoAction
            end
          end
        end
      end
      object AjudaTabSheet: TTabSheet
        Caption = 'Ajuda'
        ImageIndex = 1
        object ToolBar3: TToolBar
          Left = 0
          Top = 0
          Width = 594
          Height = 54
          ButtonHeight = 54
          ButtonWidth = 66
          Caption = 'EstoqueToolBar'
          Ctl3D = False
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = RetagImgDM.ImageList_32_32
          ShowCaptions = True
          TabOrder = 0
          ExplicitTop = 8
          object AjuBemToolButton: TToolButton
            Left = 0
            Top = 0
            Action = RetagAjuBemAction
          end
        end
      end
    end
  end
  inherited BasePanel: TPanel
    Width = 604
    TabOrder = 2
    ExplicitTop = 451
    ExplicitWidth = 604
  end
  object PageControl1: TPageControl [3]
    Left = 0
    Top = 153
    Width = 604
    Height = 298
    Align = alClient
    TabOrder = 3
    TabPosition = tpBottom
  end
  object RetagActionList: TActionList
    Images = RetagImgDM.ImageList_32_32
    Left = 104
    Top = 216
    object RetagEstProdTipoAction: TAction
      Category = 'Estoque'
      Caption = 'Tipos'
      ImageIndex = 0
      OnExecute = RetagEstProdTipoActionExecute
    end
    object RetagEstProdFabrAction: TAction
      Category = 'Estoque'
      Caption = 'Fabricantes'
      ImageIndex = 1
      OnExecute = RetagEstProdFabrActionExecute
    end
    object RetagAjuBemAction: TAction
      Caption = 'Bem-vindo'
      ImageIndex = 2
      OnExecute = RetagAjuBemActionExecute
    end
  end
  object BalloonHint1: TBalloonHint
    Left = 216
    Top = 216
  end
  object BalloonHint1CloseTimer: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = BalloonHint1CloseTimerTimer
    Left = 328
    Top = 216
  end
end
