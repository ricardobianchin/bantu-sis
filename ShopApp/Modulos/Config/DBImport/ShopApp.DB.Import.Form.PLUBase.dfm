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
      TabOrder = 1
    end
  end
  inherited MeioPanel: TPanel
    ExplicitHeight = 181
    inherited GridsPanel: TPanel
      ExplicitHeight = 189
    end
  end
  inherited StatusPanel: TPanel
    ExplicitLeft = -8
    ExplicitTop = 328
    ExplicitWidth = 938
  end
  inherited ActionList_AppDBImport: TActionList
    inherited ValidarAction_AppDBImport: TAction
      OnExecute = ValidarAction_AppDBImportExecute
    end
  end
end
