inherited PDVModuloBasForm: TPDVModuloBasForm
  Caption = 'PDVModuloBasForm'
  ClientHeight = 280
  ExplicitHeight = 280
  TextHeight = 15
  inherited BasePanel: TPanel
    Top = 251
    ExplicitTop = 251
    inherited StatusPanel1: TPanel
      inherited OutputLabel: TLabel
        Width = 203
        Height = 27
      end
    end
  end
  object PrincToolBar_PDVModuloBasForm: TToolBar [2]
    Left = 0
    Top = 30
    Width = 620
    Height = 29
    Caption = 'PrincToolBar_PDVModuloBasForm'
    List = True
    ShowCaptions = True
    TabOrder = 2
  end
  inherited PopupMenu1: TPopupMenu
    object N1: TMenuItem
      Caption = '-'
    end
    object ConsultaPreo1: TMenuItem
      Caption = 'Consulta &Pre'#231'o'
    end
  end
  object PDVActionList: TActionList
    Left = 280
    Top = 56
    object PrecoBuscaAction_PDVModuloBasForm: TAction
      Caption = 'Consulta &Pre'#231'o'
    end
    object CaixaSessaoAbrirTentarAction: TAction
      Category = 'CaixaSessao'
      Caption = 'Abrir o Caixa'
      OnExecute = CaixaSessaoAbrirTentarActionExecute
    end
  end
end
