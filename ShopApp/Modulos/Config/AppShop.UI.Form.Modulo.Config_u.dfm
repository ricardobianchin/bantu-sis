inherited ShopConfigModuloForm: TShopConfigModuloForm
  Caption = 'ShopConfigModuloForm'
  ExplicitHeight = 476
  TextHeight = 15
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
  inherited TopoPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited MenuPageControl: TPageControl
      inherited ConfigImportTabSheet: TTabSheet
        inherited ImportOrigemTitLabel: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited DBImportOrigemComboBox: TComboBox
          StyleElements = [seFont, seClient, seBorder]
        end
      end
    end
  end
end
