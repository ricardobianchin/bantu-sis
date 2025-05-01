inherited ShopRetaguardaModuloForm: TShopRetaguardaModuloForm
  Caption = 'ShopRetaguardaModuloForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited MenuPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited MenuPageControl: TPageControl
      ActivePage = EstoqueTabSheet
      inherited EstoqueTabSheet: TTabSheet
        inherited EstoqueToolBar: TToolBar
          inherited EstProdToolButton: TToolButton
            ExplicitWidth = 59
          end
          inherited EstEntrToolButton: TToolButton
            ExplicitWidth = 101
          end
          inherited EstVenToolButton: TToolButton
            ExplicitWidth = 48
          end
          inherited EstCliToolButton: TToolButton
            ExplicitWidth = 53
          end
          inherited EstFornecedorToolButton: TToolButton
            ExplicitWidth = 82
          end
        end
      end
      inherited EstAuxTabSheet: TTabSheet
        inherited EstAuxToolBar: TToolBar
          inherited AuxFabrToolButton: TToolButton
            ExplicitWidth = 71
          end
          inherited AuxTipoToolButton: TToolButton
            ExplicitWidth = 39
          end
          inherited AuxUnidToolButton: TToolButton
            ExplicitWidth = 60
          end
          inherited AuxIcmsToolButton: TToolButton
            ExplicitWidth = 39
          end
          inherited AuxEstSaiMotivosToolButton: TToolButton
            ExplicitWidth = 106
          end
        end
      end
    end
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
