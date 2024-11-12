inherited PDVModuloBasForm: TPDVModuloBasForm
  Caption = 'PDVModuloBasForm'
  TextHeight = 15
  inherited TitleBarActionList_ModuloBasForm: TActionList
    object PrecoPergAction_ModuloBasForm: TAction
      Caption = 'Consulta &Pre'#231'o'
    end
  end
  inherited PopupMenu1: TPopupMenu
    object N1: TMenuItem
      Caption = '-'
    end
    object ConsultaPreo1: TMenuItem
      Action = PrecoPergAction_ModuloBasForm
    end
  end
end
