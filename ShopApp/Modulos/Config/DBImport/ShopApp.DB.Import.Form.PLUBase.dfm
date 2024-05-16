inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientWidth = 926
  ExplicitWidth = 938
  TextHeight = 15
  inherited TopoPanel: TPanel
    Width = 926
    ExplicitWidth = 926
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
    ExplicitWidth = 926
    ExplicitHeight = 214
    inherited GridsPanel: TPanel
      Width = 926
      ExplicitWidth = 926
      ExplicitHeight = 214
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
    Width = 926
    ExplicitTop = 321
    ExplicitWidth = 926
    inherited ProgressBar1: TProgressBar
      Left = -29
      ExplicitLeft = -29
    end
  end
end
