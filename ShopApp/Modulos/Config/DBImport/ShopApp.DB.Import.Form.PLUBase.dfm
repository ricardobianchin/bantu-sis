inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientHeight = 343
  ClientWidth = 926
  ExplicitWidth = 938
  TextHeight = 15
  inherited TopoPanel: TPanel
    Width = 926
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
    Top = 256
    Width = 926
    ExplicitTop = 256
    ExplicitWidth = 926
    inherited ValidarBitBtn_AppDBImport: TBitBtn
      TabOrder = 5
    end
    inherited EditBitBtn_AppDBImport: TBitBtn
      TabOrder = 4
    end
  end
  inherited MeioPanel: TPanel
    Width = 926
    Height = 215
    ExplicitWidth = 926
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
    Top = 322
    Width = 926
    ExplicitWidth = 926
    inherited ProgressBar1: TProgressBar
      Left = -41
      ExplicitLeft = -45
    end
  end
end
