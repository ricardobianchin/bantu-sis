inherited ShopPDVModuloForm: TShopPDVModuloForm
  Caption = 'ShopPDVModuloForm'
  TextHeight = 15
  inherited TitleBarActionList_ModuloBasForm: TActionList
    Left = 408
    Top = 56
  end
  inherited PDVActionList: TActionList
    inherited PrecoBuscaAction_PDVModuloBasForm: TAction
      OnExecute = PrecoBuscaAction_PDVModuloBasFormExecute
    end
  end
end
