inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientHeight = 340
  ExplicitHeight = 379
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
  inherited BasePanel: TPanel
    Top = 253
    ExplicitTop = 253
    inherited ValidarBitBtn_AppDBImport: TBitBtn
      TabOrder = 5
    end
    inherited EditBitBtn_AppDBImport: TBitBtn
      TabOrder = 4
    end
  end
  inherited MeioPanel: TPanel
    Height = 212
    ExplicitHeight = 212
    inherited GridsPanel: TPanel
      Height = 213
      ExplicitHeight = 212
      inherited SplitterRejeicaoGrid: TSplitter
        Top = 62
        ExplicitTop = 65
        ExplicitWidth = 930
      end
      inherited ProdDBGrid: TDBGrid
        Height = 62
      end
      inherited RejeicaoDBGrid: TDBGrid
        Top = 67
      end
    end
  end
  inherited StatusPanel: TPanel
    Top = 319
    ExplicitTop = 319
    ExplicitWidth = 910
    inherited ProgressBar1: TProgressBar
      Left = -53
      ExplicitLeft = -57
    end
  end
end
