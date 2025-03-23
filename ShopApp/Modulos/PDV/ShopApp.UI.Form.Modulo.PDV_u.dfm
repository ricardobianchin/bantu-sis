inherited ShopPDVModuloForm: TShopPDVModuloForm
  Caption = 'ShopPDVModuloForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited BasePanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited StatusPanel1: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited StatusLabel1: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited OutputLabel: TLabel
        StyleElements = [seFont, seClient, seBorder]
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
