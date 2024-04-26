inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientWidth = 624
  ExplicitWidth = 636
  TextHeight = 15
  inherited TopoPanel: TPanel
    Width = 624
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
    inherited ZerarBitBtn: TBitBtn
      TabOrder = 2
    end
  end
  inherited BasePanel: TPanel
    Width = 624
  end
  inherited MeioPanel: TPanel
    Width = 624
    inherited SplitterStatusMemo: TSplitter
      Width = 624
      ExplicitTop = 307
      ExplicitWidth = 624
    end
    inherited StatusMemo: TMemo
      Width = 624
    end
    inherited GridsPanel: TPanel
      Width = 624
      inherited ProdDBGrid: TDBGrid
        Width = 624
      end
    end
  end
  inherited ActionList_AppDBImport: TActionList
    inherited ExecuteAction_AppDBImport: TAction
      OnExecute = ExecuteAction_AppDBImportExecute
    end
  end
end
