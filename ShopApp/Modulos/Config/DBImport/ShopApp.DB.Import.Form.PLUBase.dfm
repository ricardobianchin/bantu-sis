inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientWidth = 926
  ExplicitWidth = 942
  ExplicitHeight = 381
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
    ExplicitTop = 255
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
      Width = 930
      Height = 215
      ExplicitWidth = 926
      ExplicitHeight = 214
      inherited SplitterRejeicaoGrid: TSplitter
        Top = 64
        Width = 930
        ExplicitTop = 65
        ExplicitWidth = 930
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
    Width = 926
    ExplicitTop = 321
    ExplicitWidth = 926
    inherited ProgressBar1: TProgressBar
      Left = -25
      ExplicitLeft = -29
    end
  end
end
