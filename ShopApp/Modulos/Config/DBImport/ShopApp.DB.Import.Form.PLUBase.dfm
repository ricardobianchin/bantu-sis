inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientWidth = 930
  ExplicitHeight = 381
  TextHeight = 15
  inherited TopoPanel: TPanel
    Width = 930
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
    Width = 930
    ExplicitTop = 255
    inherited ValidarBitBtn_AppDBImport: TBitBtn
      TabOrder = 5
    end
    inherited EditBitBtn_AppDBImport: TBitBtn
      TabOrder = 4
    end
  end
  inherited MeioPanel: TPanel
    Width = 930
    ExplicitHeight = 214
    inherited GridsPanel: TPanel
      Height = 215
      ExplicitHeight = 214
      inherited SplitterRejeicaoGrid: TSplitter
        Top = 64
        ExplicitTop = 65
      end
      inherited ProdDBGrid: TDBGrid
        Height = 64
      end
      inherited RejeicaoDBGrid: TDBGrid
        Top = 69
      end
    end
  end
  inherited StatusPanel: TPanel
    Width = 930
    ExplicitTop = 321
    inherited ProgressBar1: TProgressBar
      Left = -13
      ExplicitLeft = -17
    end
  end
end
