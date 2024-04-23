inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
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
    end
  end
  inherited MeioPanel: TPanel
    inherited SplitterStatusMemo: TSplitter
      ExplicitTop = 307
      ExplicitWidth = 624
    end
  end
  inherited ActionList_AppDBImport: TActionList
    inherited ExecuteAction_AppDBImport: TAction
      OnExecute = ExecuteAction_AppDBImportExecute
    end
  end
end
