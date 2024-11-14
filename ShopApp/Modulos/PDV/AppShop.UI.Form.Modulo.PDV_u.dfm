inherited ShopPDVModuloForm: TShopPDVModuloForm
  Caption = 'ShopPDVModuloForm'
  TextHeight = 15
  inherited TitleBarActionList_ModuloBasForm: TActionList
    Left = 408
    Top = 56
    inherited PrecoBuscaAction_ModuloBasForm: TAction
      OnExecute = PrecoPergAction_ModuloBasFormExecute
    end
  end
end
