inherited ShopConfigModuloForm: TShopConfigModuloForm
  Caption = 'ShopConfigModuloForm'
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
end
