inherited RetaguardaModuloBasForm: TRetaguardaModuloBasForm
  BorderStyle = bsSizeable
  Caption = 'RetaguardaModuloBasForm'
  ClientHeight = 438
  ClientWidth = 592
  Menu = MainMenu1
  OnDestroy = FormDestroy
  ExplicitWidth = 604
  ExplicitHeight = 496
  TextHeight = 15
  inherited TitleBarPanel: TPanel
    Width = 592
    ExplicitWidth = 604
    DesignSize = (
      592
      30)
    inherited ToolBar1: TToolBar
      Left = 502
    end
  end
  object MenuPanel: TPanel [1]
    Left = 0
    Top = 30
    Width = 592
    Height = 122
    Align = alTop
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 604
    object MenuPageControl: TPageControl
      Left = 1
      Top = 1
      Width = 590
      Height = 120
      ActivePage = EstoqueTabSheet
      Align = alClient
      Style = tsFlatButtons
      TabOrder = 0
      ExplicitWidth = 602
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
          object ToolBar6: TToolBar
            Left = 2
            Top = 17
            Width = 476
            Height = 54
            ButtonHeight = 46
            ButtonWidth = 55
            Caption = 'EstoqueToolBar'
            Ctl3D = False
            EdgeInner = esNone
            EdgeOuter = esNone
            Images = RetagImgDM.ImageList_24_24
            ShowCaptions = True
            TabOrder = 1
            object ToolButton8: TToolButton
              Left = 0
              Top = 0
              Action = RetagEstProdAction
            end
          end
        end
      end
      object ProdTabsTabSheet: TTabSheet
        Caption = 'Par'#226'metros dos Produtos'
        ImageIndex = 2
        object ToolBar5: TToolBar
          Left = 0
          Top = 0
          Width = 582
          Height = 54
          ButtonHeight = 46
          ButtonWidth = 67
          Caption = 'EstoqueToolBar'
          Ctl3D = False
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = RetagImgDM.ImageList_24_24
          ShowCaptions = True
          TabOrder = 0
          ExplicitWidth = 594
          object ToolButton4: TToolButton
            Left = 0
            Top = 0
            Action = RetagEstProdFabrAction
          end
          object ToolButton5: TToolButton
            Left = 67
            Top = 0
            Action = RetagEstProdTipoAction
          end
          object ToolButton6: TToolButton
            Left = 134
            Top = 0
            Action = RetagEstProdUnidAction
          end
          object ToolButton7: TToolButton
            Left = 201
            Top = 0
            Action = RetagEstProdICMSAction
          end
        end
      end
      object AjudaTabSheet: TTabSheet
        Caption = 'Ajuda'
        ImageIndex = 1
        object ToolBar3: TToolBar
          Left = 0
          Top = 0
          Width = 582
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
          ExplicitWidth = 594
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
    Top = 413
    Width = 592
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
    Width = 592
    Height = 261
    Align = alClient
    TabOrder = 3
    ExplicitWidth = 604
    ExplicitHeight = 299
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 184
    Top = 192
  end
  inherited TitleBarActionList_ModuloBasForm: TActionList
    inherited OcultarAction_ModuloBasForm: TAction
      Caption = 'Ocultar esta janela'
    end
  end
  inherited PopupMenu1: TPopupMenu
    Left = 280
    Top = 152
  end
  object RetagActionList: TActionList
    Images = RetagImgDM.ImageList_24_24
    Left = 464
    Top = 184
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
      Caption = 'Setores'
      Hint = 'Setores dos produtos'
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
    object RetagEstProdICMSAction: TAction
      Category = 'Estoque'
      Caption = 'ICMS'
      Hint = 'Al'#237'quotas (Percentuais) de ICMS. '
      ImageIndex = 4
      OnExecute = RetagEstProdICMSActionExecute
    end
  end
  object BalloonHint1: TBalloonHint
    Delay = 100
    Left = 344
    Top = 192
  end
  object MainMenu1: TMainMenu
    Left = 48
    Top = 176
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Produtos1: TMenuItem
        Action = RetagEstProdAction
      end
      object Preos1: TMenuItem
        Caption = 'Pre'#231'os'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Fabricantes1: TMenuItem
        Action = RetagEstProdFabrAction
      end
      object Setores1: TMenuItem
        Action = RetagEstProdTipoAction
      end
      object Unidades1: TMenuItem
        Action = RetagEstProdUnidAction
      end
      object ICMS1: TMenuItem
        Action = RetagEstProdICMSAction
      end
    end
    object Estoque1: TMenuItem
      Caption = 'Estoque'
      object Entradadenotas1: TMenuItem
        Caption = 'Entrada de notas'
      end
      object Entradadenotas2: TMenuItem
        Caption = 'Venda'
      end
      object Inventrios1: TMenuItem
        Caption = 'Invent'#225'rios'
      end
      object Baixa1: TMenuItem
        Caption = 'Baixa'
        Hint = 'Furto ou roubo, uso pr'#243'prio, perda de validade, deteriora'#231#227'o'
      end
      object Balanas1: TMenuItem
        Caption = 'Balan'#231'as'
      end
    end
    object Estoque2: TMenuItem
      Caption = 'Relat'#243'rios'
    end
    object Configuraes1: TMenuItem
      Caption = 'Configura'#231#245'es'
      object Estabelecimento1: TMenuItem
        Caption = 'Estabelecimento'
      end
      object Usurios1: TMenuItem
        Caption = 'Usu'#225'rios'
      end
      object PerfisdeUsurio1: TMenuItem
        Caption = 'Perfis de Usu'#225'rio'
      end
    end
    object N2: TMenuItem
      Caption = 'Aplicativo'
      object OcultarActionModuloBasForm1: TMenuItem
        Action = OcultarAction_ModuloBasForm
      end
      object Fechar1: TMenuItem
        Action = FecharAction_ModuloBasForm
      end
    end
  end
end
