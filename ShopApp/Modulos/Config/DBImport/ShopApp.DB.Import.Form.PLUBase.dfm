inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientHeight = 343
  ClientWidth = 930
  ExplicitWidth = 942
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
    Top = 256
    Width = 930
    ExplicitTop = 256
    inherited ValidarBitBtn_AppDBImport: TBitBtn
      TabOrder = 5
    end
    inherited EditBitBtn_AppDBImport: TBitBtn
      TabOrder = 4
    end
  end
  inherited MeioPanel: TPanel
    Width = 930
    Height = 215
    ExplicitHeight = 215
    inherited GridsPanel: TPanel
      Width = 930
      Height = 215
      ExplicitHeight = 215
      inherited SplitterRejeicaoGrid: TSplitter
        Top = 64
        Width = 930
        ExplicitTop = 65
      end
      inherited ProdDBGrid: TDBGrid
        Width = 930
        Height = 64
      end
      inherited RejeicaoDBGrid: TDBGrid
        Top = 69
        Width = 930
      end
    end
  end
  inherited StatusPanel: TPanel
    Top = 322
    Width = 930
    ExplicitTop = 322
    inherited ProgressBar1: TProgressBar
      Left = -17
      ExplicitLeft = -17
    end
  end
end
