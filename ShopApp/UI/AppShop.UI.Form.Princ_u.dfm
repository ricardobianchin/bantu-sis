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
  object Button1: TButton [4]
    Left = 16
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  inherited ActionList1_ActBasForm: TActionList
    Top = 48
  end
end
