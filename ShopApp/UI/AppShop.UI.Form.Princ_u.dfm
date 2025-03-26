inherited ShopPrincForm: TShopPrincForm
  Caption = 'ShopPrincForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited BasePanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited DtHCompilePanel: TPanel
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited ActionList1_ActBasForm: TActionList
    Top = 48
  end
end
