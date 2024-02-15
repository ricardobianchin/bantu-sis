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
    Height = 130
    Align = alTop
    Caption = ' '
    TabOrder = 1
    object MenuPageControl: TPageControl
      Left = 1
      Top = 1
      Width = 602
      Height = 128
      ActivePage = EstoqueTabSheet
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
          Width = 264
          Height = 97
          Caption = 'Produtos'
          TabOrder = 0
          object EstoqueToolBar: TToolBar
            Left = 2
            Top = 17
            Width = 260
            Height = 54
            AutoSize = True
            ButtonHeight = 54
            ButtonWidth = 67
            Caption = 'EstoqueToolBar'
            Ctl3D = False
            EdgeInner = esNone
            EdgeOuter = esNone
            Images = RetagImgDM.ImageList_32_32
            ShowCaptions = True
            TabOrder = 0
            object ProdToolButton: TToolButton
              Left = 0
              Top = 0
              Action = RetagEstProdAction
            end
            object EstProdFabrToolButton: TToolButton
              Left = 67
              Top = 0
              Action = RetagEstProdFabrAction
            end
            object EstProdTipoToolButton: TToolButton
              Left = 134
              Top = 0
              Action = RetagEstProdTipoAction
            end
          end
          object EstProdEnvTermPanel: TPanel
            Left = 2
            Top = 73
            Width = 119
            Height = 21
            BevelOuter = bvNone
            Caption = '  '
            TabOrder = 1
            object ToolBar4: TToolBar
              Left = 0
              Top = 0
              Width = 119
              Height = 21
              ButtonHeight = 21
              ButtonWidth = 114
              Caption = 'ToolBar4'
              List = True
              ShowCaptions = True
              TabOrder = 0
              object ToolButton2: TToolButton
                Left = 0
                Top = 0
                Action = RetagEstProdEnviarTermAction
              end
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
    ExplicitWidth = 604
  end
  object PageControl1: TPageControl [3]
    Left = 0
    Top = 160
    Width = 604
    Height = 291
    Align = alClient
    TabOrder = 3
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 184
    Top = 192
  end
  inherited PopupMenu1: TPopupMenu
    Left = 272
    Top = 80
  end
  object RetagActionList: TActionList
    Images = RetagImgDM.ImageList_32_32
    Left = 496
    Top = 176
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
      Category = 'Ajuda'
      Caption = 'Bem-vindo'
      ImageIndex = 2
      OnExecute = RetagAjuBemActionExecute
    end
    object RetagEstProdEnviarTermAction: TAction
      Category = 'Estoque'
      Caption = 'Envia aos Terminais'
      OnExecute = RetagEstProdEnviarTermActionExecute
    end
    object RetagEstProdAction: TAction
      Category = 'Estoque'
      Caption = 'Produtos'
      ImageIndex = 3
      OnExecute = RetagEstProdActionExecute
    end
  end
  object BalloonHint1: TBalloonHint
    Delay = 100
    Left = 464
    Top = 256
  end
end
