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
      TabOrder = 4
    end
  end
  inherited BasePanel: TPanel
    Top = 591
    inherited ProgressBar1: TProgressBar
      Left = 957
      ExplicitLeft = 957
    end
  end
  inherited MeioPanel: TPanel
    Height = 550
    ExplicitHeight = 491
    inherited GridsPanel: TPanel
      Height = 550
      ExplicitHeight = 486
      inherited SplitterRejeicaoGrid: TSplitter
        Top = 399
        ExplicitTop = 388
      end
      inherited ProdDBGrid: TDBGrid
        Height = 399
      end
      inherited RejeicaoDBGrid: TDBGrid
        Top = 404
      end
    end
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
