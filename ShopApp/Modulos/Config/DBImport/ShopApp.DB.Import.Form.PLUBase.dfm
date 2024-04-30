inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientHeight = 613
  ExplicitTop = -190
  ExplicitHeight = 651
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
    inherited ZerarBitBtn: TBitBtn
      TabOrder = 3
    end
  end
  inherited BasePanel: TPanel
    Top = 574
  end
  inherited MeioPanel: TPanel
    Height = 512
    ExplicitHeight = 491
    inherited GridsPanel: TPanel
      Height = 512
      ExplicitHeight = 486
      inherited SplitterRejeicaoGrid: TSplitter
        Top = 361
        ExplicitTop = 388
      end
      inherited ProdDBGrid: TDBGrid
        Height = 361
      end
      inherited RejeicaoDBGrid: TDBGrid
        Top = 366
      end
    end
  end
  inherited StatusPanel: TPanel
    Top = 553
    ExplicitTop = 553
  end
  inherited ActionList_AppDBImport: TActionList
    inherited ExecuteAction_AppDBImport: TAction
      OnExecute = ExecuteAction_AppDBImportExecute
    end
    inherited AtualizarAction_AppDBImport: TAction
      OnExecute = AtualizarAction_AppDBImportExecute
    end
    inherited ValidarAction_AppDBImport: TAction
      OnExecute = ValidarAction_AppDBImportExecute
    end
  end
end
