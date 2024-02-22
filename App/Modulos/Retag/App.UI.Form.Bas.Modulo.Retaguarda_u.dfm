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
    Height = 122
    Align = alTop
    Caption = ' '
    TabOrder = 1
    object MenuPageControl: TPageControl
      Left = 1
      Top = 1
      Width = 602
      Height = 120
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
          Width = 480
          Height = 97
          Caption = 'Produtos'
          TabOrder = 0
          object EstProdEnvTermPanel: TPanel
            Left = 2
            Top = 65
            Width = 119
            Height = 21
            BevelOuter = bvNone
            Caption = '  '
            TabOrder = 0
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
          ButtonHeight = 46
          ButtonWidth = 66
          Caption = 'EstoqueToolBar'
          Ctl3D = False
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = RetagImgDM.ImageList_24_24
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
    inherited Panel1: TPanel
      inherited OutputLabel: TLabel
        Width = 203
        Height = 23
      end
    end
  end
  object PageControl1: TPageControl [3]
    Left = 0
    Top = 152
    Width = 604
    Height = 299
    Align = alClient
    TabOrder = 3
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 184
    Top = 192
  end
  inherited PopupMenu1: TPopupMenu
    Left = 280
    Top = 152
  end
  object RetagActionList: TActionList
    Images = RetagImgDM.ImageList_24_24
    Left = 456
    Top = 240
    object RetagEstProdAction: TAction
      Category = 'Estoque'
      Caption = 'Produtos'
      Hint = 'Produtos'
      ImageIndex = 5
      OnExecute = RetagEstProdActionExecute
    end
    object RetagEstProdEnviarTermAction: TAction
      Category = 'Estoque'
      Caption = 'Envia aos Terminais'
      OnExecute = RetagEstProdEnviarTermActionExecute
    end
    object RetagEstProdFabrAction: TAction
      Category = 'Estoque'
      Caption = 'Fabricantes'
      Hint = 'Fabricantes dos Produtos'
      ImageIndex = 1
      OnExecute = RetagEstProdFabrActionExecute
    end
    object RetagEstProdTipoAction: TAction
      Category = 'Estoque'
      Caption = 'Tipos'
      Hint = 'Tipos de Produtos'
      ImageIndex = 2
      OnExecute = RetagEstProdTipoActionExecute
    end
    object RetagAjuBemAction: TAction
      Category = 'Ajuda'
      Caption = 'Bem-vindo'
      ImageIndex = 0
      OnExecute = RetagAjuBemActionExecute
    end
    object RetagEstProdUnidAction: TAction
      Category = 'Estoque'
      Caption = 'Unidades'
      Hint = 'Unidades de Medida'
      ImageIndex = 3
      OnExecute = RetagEstProdUnidActionExecute
    end
  end
  object BalloonHint1: TBalloonHint
    Delay = 100
    Left = 344
    Top = 192
  end
end
