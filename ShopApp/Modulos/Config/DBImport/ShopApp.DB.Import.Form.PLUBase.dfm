inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'ShopDBImportFormPLUBase'
  TextHeight = 15
  inherited TopoPanel: TPanel
    object MoldeFileSelectPanel: TPanel [0]
      Left = 1
      Top = 8
      Width = 530
      Height = 24
      Caption = 'MoldeFileSelectPanel'
      TabOrder = 0
    end
    inherited ExecuteBitBtn: TBitBtn
      TabOrder = 1
      OnClick = nil
    end
  end
  inherited BasePanel: TPanel
    ExplicitWidth = 624
  end
  inherited MeioPanel: TPanel
    ExplicitWidth = 628
    inherited StatusMemo: TMemo
      ExplicitTop = 185
      ExplicitWidth = 624
      ExplicitHeight = 152
    end
    inherited GridsPanel: TPanel
      ExplicitWidth = 624
    end
  end
end
