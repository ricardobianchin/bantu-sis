inherited RetaguardaModuloBasForm: TRetaguardaModuloBasForm
  Caption = 'RetaguardaModuloBasForm'
  ClientWidth = 604
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
    Height = 103
    Align = alTop
    Caption = ' '
    TabOrder = 1
    object MenuPageControl: TPageControl
      Left = 1
      Top = 1
      Width = 602
      Height = 101
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
        object EstoqueToolBar: TToolBar
          Left = 0
          Top = 0
          Width = 594
          Height = 54
          AutoSize = True
          ButtonHeight = 54
          ButtonWidth = 102
          Caption = 'EstoqueToolBar'
          Ctl3D = False
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = RetagImgDM.ImageList_32_32
          ShowCaptions = True
          TabOrder = 0
          StyleElements = []
          object ToolButton2: TToolButton
            Left = 0
            Top = 0
            Action = RetagEstoqueProdTipoAction
          end
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Teste'
        ImageIndex = 1
      end
    end
  end
  object RetagActionList: TActionList
    Images = RetagImgDM.ImageList_32_32
    Left = 104
    Top = 216
    object RetagEstoqueProdTipoAction: TAction
      Category = 'Estoque'
      Caption = 'Tipos de Produtos'
      ImageIndex = 0
      OnExecute = RetagEstoqueProdTipoActionExecute
    end
  end
end
