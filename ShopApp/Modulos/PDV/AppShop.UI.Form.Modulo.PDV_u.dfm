inherited ShopPDVModuloForm: TShopPDVModuloForm
  Caption = 'ShopPDVModuloForm'
  TextHeight = 15
  inherited BasePanel: TPanel
    inherited StatusPanel1: TPanel
      inherited OutputLabel: TLabel
        Width = 203
        Height = 27
      end
    end
  end
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
