inherited PDVModuloBasForm: TPDVModuloBasForm
  Caption = 'PDVModuloBasForm'
  TextHeight = 15
  inherited TitleBarActionList_ModuloBasForm: TActionList
    object PrecoBuscaAction_ModuloBasForm: TAction
      Caption = 'Consulta &Pre'#231'o'
    end
  end
  inherited PopupMenu1: TPopupMenu
    object N1: TMenuItem
      Caption = '-'
    end
    object ConsultaPreo1: TMenuItem
      Action = PrecoBuscaAction_ModuloBasForm
    end
  end
end
