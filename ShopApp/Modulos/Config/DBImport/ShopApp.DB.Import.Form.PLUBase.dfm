inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientHeight = 341
  ExplicitHeight = 380
  TextHeight = 15
  inherited TopoPanel: TPanel
    ExplicitWidth = 922
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
    Top = 254
    ExplicitTop = 254
    inherited ValidarBitBtn_AppDBImport: TBitBtn
      TabOrder = 5
    end
    inherited EditBitBtn_AppDBImport: TBitBtn
      TabOrder = 4
    end
  end
  inherited MeioPanel: TPanel
    Height = 213
    ExplicitWidth = 922
    ExplicitHeight = 214
    inherited GridsPanel: TPanel
      Width = 926
      ExplicitWidth = 922
      inherited SplitterRejeicaoGrid: TSplitter
        Width = 926
        ExplicitTop = 65
        ExplicitWidth = 930
      end
      inherited ProdDBGrid: TDBGrid
        Width = 926
      end
      inherited RejeicaoDBGrid: TDBGrid
        Width = 926
      end
    end
  end
  inherited StatusPanel: TPanel
    Top = 320
    ExplicitTop = 321
    ExplicitWidth = 922
    inherited ProgressBar1: TProgressBar
      Left = -45
      ExplicitLeft = -49
    end
  end
end
