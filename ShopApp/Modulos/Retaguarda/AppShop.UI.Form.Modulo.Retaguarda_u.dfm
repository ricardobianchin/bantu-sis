inherited ShopRetaguardaModuloForm: TShopRetaguardaModuloForm
  Caption = 'ShopRetaguardaModuloForm'
  StyleElements = [seFont, seClient, seBorder]
  ExplicitLeft = -19
  TextHeight = 15
  inherited MenuPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited BasePanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
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
end
