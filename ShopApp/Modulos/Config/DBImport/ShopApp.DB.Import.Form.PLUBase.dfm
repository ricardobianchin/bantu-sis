inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientHeight = 343
  ExplicitWidth = 950
  ExplicitHeight = 382
  TextHeight = 15
  inherited TopoPanel: TPanel
    ExplicitWidth = 934
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
    ExplicitTop = 256
    ExplicitWidth = 934
    inherited ValidarBitBtn_AppDBImport: TBitBtn
      TabOrder = 5
    end
    inherited EditBitBtn_AppDBImport: TBitBtn
      TabOrder = 4
    end
  end
  inherited MeioPanel: TPanel
    Height = 215
    ExplicitWidth = 934
    ExplicitHeight = 215
    inherited GridsPanel: TPanel
      Height = 215
      ExplicitWidth = 934
      ExplicitHeight = 215
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
    Top = 322
    ExplicitTop = 322
    ExplicitWidth = 934
    DesignSize = (
      934
      21)
    inherited ProgressBar1: TProgressBar
      Left = -9
      ExplicitLeft = -9
    end
  end
end
