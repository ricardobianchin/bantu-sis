inherited RetaguardaModuloBasForm: TRetaguardaModuloBasForm
  Caption = 'RetaguardaModuloBasForm'
  ClientHeight = 458
  ClientWidth = 592
  StyleElements = [seFont, seClient, seBorder]
  OnDestroy = FormDestroy
  ExplicitWidth = 592
  ExplicitHeight = 458
  TextHeight = 15
  inherited TitleBarPanel: TPanel
    Width = 592
    ExplicitWidth = 592
    DesignSize = (
      592
      30)
    inherited ToolBar1: TToolBar
      Left = 498
      ExplicitLeft = 498
    end
  end
  object MenuPanel: TPanel [1]
    Left = 0
    Top = 30
    Width = 592
    Height = 65
    Align = alTop
    Caption = ' '
    TabOrder = 1
    object MenuPageControl: TPageControl
      Left = 1
      Top = 1
      Width = 590
      Height = 63
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
          Width = 582
          Height = 30
          AutoSize = True
          ButtonHeight = 30
          ButtonWidth = 125
          Caption = 'EstoqueToolBar'
          Ctl3D = False
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = RetagImgDM.ImageList_24_24
          List = True
          ShowCaptions = True
          TabOrder = 0
          object EstProdToolButton: TToolButton
            Left = 0
            Top = 0
            Action = RetagEstProdAction
            AutoSize = True
          end
          object EstVenToolButton: TToolButton
            Left = 59
            Top = 0
            AutoSize = True
            Caption = 'Vendas'
          end
          object EstEntrToolButton: TToolButton
            Left = 107
            Top = 0
            Hint = 'Produtos'
            AutoSize = True
            Caption = 'Entrada de Notas'
          end
          object EstInventarioToolButton: TToolButton
            Left = 208
            Top = 0
            Action = RetagEstInventarioAction
            AutoSize = True
          end
          object EstSaidaToolButton: TToolButton
            Left = 277
            Top = 0
            Action = RetagEstSaidaAct
            AutoSize = True
          end
          object EstSaldoToolButton: TToolButton
            Left = 321
            Top = 0
            Action = RetagEstSaldoAct
            AutoSize = True
          end
          object EstCliToolButton: TToolButton
            Left = 361
            Top = 0
            Action = RetagEstVenClienteAction
            AutoSize = True
          end
          object EstFornecedorToolButton: TToolButton
            Left = 414
            Top = 0
            Action = RetagEstEntFornecedorAct
            AutoSize = True
          end
        end
      end
      object FinTabSheet: TTabSheet
        Caption = 'Financeiro'
        ImageIndex = 3
        object FinanceiroToolBar: TToolBar
          Left = 0
          Top = 0
          Width = 582
          Height = 30
          AutoSize = True
          ButtonHeight = 30
          ButtonWidth = 154
          Caption = 'FinanceiroToolBar'
          Ctl3D = False
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = RetagImgDM.ImageList_24_24
          List = True
          ShowCaptions = True
          TabOrder = 0
          object PagamentoFormaToolButton: TToolButton
            Left = 0
            Top = 0
            Action = FinanceiroPagamentoFormaAction
            AutoSize = True
          end
          object FinanceiroDespesaTipoToolButton: TToolButton
            Left = 130
            Top = 0
            Action = FinanceiroDespesaTipoAction
            AutoSize = True
          end
        end
      end
      object EstAuxTabSheet: TTabSheet
        Caption = 'Par'#226'metros'
        ImageIndex = 2
        object EstAuxToolBar: TToolBar
          Left = 0
          Top = 0
          Width = 582
          Height = 30
          AutoSize = True
          ButtonHeight = 30
          ButtonWidth = 130
          Caption = 'EstoqueToolBar'
          Ctl3D = False
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = RetagImgDM.ImageList_24_24
          List = True
          ShowCaptions = True
          TabOrder = 0
          object AuxFabrToolButton: TToolButton
            Left = 0
            Top = 0
            Action = RetagEstProdFabrAction
            AutoSize = True
          end
          object AuxTipoToolButton: TToolButton
            Left = 71
            Top = 0
            Action = RetagEstProdTipoAction
            AutoSize = True
          end
          object AuxUnidToolButton: TToolButton
            Left = 110
            Top = 0
            Action = RetagEstProdUnidAction
            AutoSize = True
          end
          object AuxIcmsToolButton: TToolButton
            Left = 170
            Top = 0
            Action = RetagEstProdICMSAction
            AutoSize = True
          end
          object AuxEstSaiMotivosToolButton: TToolButton
            Left = 209
            Top = 0
            Action = RetagEstSaiMotivoAction
            AutoSize = True
          end
        end
      end
      object AcessoTabSheet: TTabSheet
        Caption = 'Acesso ao Sistema'
        ImageIndex = 4
        object AcessoToolBar: TToolBar
          Left = 0
          Top = 0
          Width = 582
          Height = 30
          AutoSize = True
          ButtonHeight = 30
          ButtonWidth = 103
          Caption = 'AcessoToolBar'
          Ctl3D = False
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = RetagImgDM.ImageList_24_24
          List = True
          ShowCaptions = True
          TabOrder = 0
          object PerfilToolButton: TToolButton
            Left = 0
            Top = 0
            Action = RetagAcessoPerfilAction
            AutoSize = True
          end
          object FuncToolButton: TToolButton
            Left = 77
            Top = 0
            Action = RetagAcessoFuncAction
            AutoSize = True
          end
        end
      end
      object AjudaTabSheet: TTabSheet
        Caption = 'Ajuda'
        ImageIndex = 1
        object AjudaToolBar: TToolBar
          Left = 0
          Top = 0
          Width = 582
          Height = 30
          AutoSize = True
          ButtonHeight = 30
          ButtonWidth = 130
          Caption = 'AjudaToolBar'
          Ctl3D = False
          EdgeInner = esNone
          EdgeOuter = esNone
          Images = RetagImgDM.ImageList_24_24
          List = True
          ShowCaptions = True
          TabOrder = 0
          object AjuBemToolButton: TToolButton
            Left = 0
            Top = 0
            Action = RetagAjuBemAction
          end
          object AjuVersaoDBToolButton: TToolButton
            Left = 130
            Top = 0
            Action = RetagAjuVersaoDBAction
          end
          object ToolButton12: TToolButton
            Left = 260
            Top = 0
            Action = RetagAjuVersaoSisAction
          end
        end
      end
    end
  end
  inherited BasePanel: TPanel
    Top = 429
    Width = 592
    TabOrder = 2
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 429
    ExplicitWidth = 592
    DesignSize = (
      592
      29)
    inherited StatusPanel1: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited StatusLabel1: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited OutputLabel: TLabel
        Width = 203
        Height = 27
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
  object PageControl1: TPageControl [3]
    Left = 0
    Top = 95
    Width = 592
    Height = 334
    Align = alClient
    TabOrder = 3
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 184
    Top = 192
  end
  inherited TitleBarActionList_ModuloBasForm: TActionList
    Left = 392
    Top = 136
  end
  inherited PopupMenu1: TPopupMenu
    Left = 280
    Top = 152
    object N3: TMenuItem
      Caption = '-'
    end
    object Cadastro2: TMenuItem
      Caption = 'Cadastro'
      object Produtos2: TMenuItem
        Action = RetagEstProdAction
      end
      object Preos2: TMenuItem
        Caption = 'Pre'#231'os'
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Fabricantes2: TMenuItem
        Action = RetagEstProdFabrAction
      end
      object Setores2: TMenuItem
        Action = RetagEstProdTipoAction
      end
      object Unidades2: TMenuItem
        Action = RetagEstProdUnidAction
        AutoCheck = True
      end
      object ICMS2: TMenuItem
        Action = RetagEstProdICMSAction
      end
    end
    object Cadastro3: TMenuItem
      Caption = 'Estoque'
      object EntradadeNotas3: TMenuItem
        Caption = 'Entrada de Notas'
      end
      object EntradadeNotas4: TMenuItem
        Caption = 'Vendas'
      end
      object Inventrio1: TMenuItem
        Caption = 'Invent'#225'rio'
      end
      object Inventrio2: TMenuItem
        Caption = 'Baixas de Estoque'
        Hint = 'xxx'
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
    end
    object Acesso1: TMenuItem
      Caption = 'Acesso'
      object DireitosdeAcesso1: TMenuItem
        Caption = 'Direitos de Acesso'
      end
      object Usurios2: TMenuItem
        Caption = 'Usu'#225'rios'
      end
      object PerfildeUso1: TMenuItem
        Caption = 'Perfil de Uso'
      end
    end
  end
  object RetagActionList: TActionList
    Images = RetagImgDM.ImageList_24_24
    Left = 464
    Top = 184
    object RetagEstProdAction: TAction
      Category = 'Estoque'
      Caption = 'Produtos'
      Hint = 'Produtos'
      OnExecute = RetagEstProdActionExecute
    end
    object RetagEstProdEnviarTermAction: TAction
      Category = 'Estoque'
      Caption = 'Envia aos Terminais'
      OnExecute = RetagEstProdEnviarTermActionExecute
    end
    object RetagEstProdFabrAction: TAction
      Category = 'EstAux'
      Caption = 'Fabricantes'
      Hint = 'Fabricantes dos Produtos'
      OnExecute = RetagEstProdFabrActionExecute
    end
    object RetagEstProdTipoAction: TAction
      Category = 'EstAux'
      Caption = 'Tipos'
      Hint = 'Tipos dos produtos'
      OnExecute = RetagEstProdTipoActionExecute
    end
    object RetagAjuBemAction: TAction
      Category = 'Ajuda'
      Caption = 'Bem-vindo'
      OnExecute = RetagAjuBemActionExecute
    end
    object RetagEstProdUnidAction: TAction
      Category = 'EstAux'
      AutoCheck = True
      Caption = 'Unidades'
      Hint = 'Unidades de Medida'
      OnExecute = RetagEstProdUnidActionExecute
    end
    object RetagEstProdICMSAction: TAction
      Category = 'EstAux'
      Caption = 'ICMS'
      Hint = 'Al'#237'quotas (Percentuais) de ICMS. '
      OnExecute = RetagEstProdICMSActionExecute
    end
    object FinanceiroPagamentoFormaAction: TAction
      Category = 'Financeiro'
      Caption = 'Formas de Pagamento'
      Hint = 'Formas de Pagamento'
      OnExecute = FinanceiroPagamentoFormaActionExecute
    end
    object RetagAcessoFuncAction: TAction
      Category = 'Acesso'
      Caption = 'Funcion'#225'rios'
      OnExecute = RetagAcessoFuncActionExecute
    end
    object RetagAjuVersaoDBAction: TAction
      Category = 'Ajuda'
      Caption = 'Vers'#227'o do DB'
      OnExecute = RetagAjuVersaoDBActionExecute
    end
    object RetagAcessoPerfilAction: TAction
      Category = 'Acesso'
      Caption = 'Perfil de Uso'
      OnExecute = RetagAcessoPerfilActionExecute
    end
    object RetagEstVenClienteAction: TAction
      Category = 'Estoque'
      Caption = 'Clientes'
      Hint = 'Clientes'
      OnExecute = RetagEstVenClienteActionExecute
    end
    object FinanceiroDespesaTipoAction: TAction
      Category = 'Financeiro'
      Caption = 'Tipos de Despesa'
      Hint = 'Tipos de Despesa'
      OnExecute = FinanceiroDespesaTipoActionExecute
    end
    object RetagAjuVersaoSisAction: TAction
      Category = 'Ajuda'
      Caption = 'Vers'#227'o do Sistema'
      OnExecute = RetagAjuVersaoSisActionExecute
    end
    object RetagEstEntFornecedorAct: TAction
      Category = 'Estoque'
      Caption = 'Fornecedores'
      OnExecute = RetagEstEntFornecedorActExecute
    end
    object RetagEstSaiMotivoAction: TAction
      Category = 'EstAux'
      Caption = 'Motivos de Sa'#237'das'
      Visible = False
    end
    object RetagEstSaidaAct: TAction
      Category = 'Estoque'
      Caption = 'Sa'#237'das'
      OnExecute = RetagEstSaidaActExecute
    end
    object RetagEstEntradaAction: TAction
      Category = 'Estoque'
      Caption = 'Entrada de Notas'
      OnExecute = RetagEstEntradaActionExecute
    end
    object RetagEstInventarioAction: TAction
      Category = 'Estoque'
      Caption = 'Invent'#225'rios'
      OnExecute = RetagEstInventarioActionExecute
    end
    object RetagEstSaldoAct: TAction
      Category = 'Estoque'
      Caption = 'Saldo'
      OnExecute = RetagEstSaldoActExecute
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
        AutoCheck = True
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
