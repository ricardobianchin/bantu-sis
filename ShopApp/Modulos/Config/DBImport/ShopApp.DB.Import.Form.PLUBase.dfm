inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientHeight = 344
  ClientWidth = 938
  ExplicitHeight = 382
  TextHeight = 15
  inherited TopoPanel: TPanel
    Width = 938
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
    Top = 257
    Width = 938
    ExplicitTop = 256
    inherited ValidarBitBtn_AppDBImport: TBitBtn
      TabOrder = 5
    end
    inherited SelecBitBtn_AppDBImport: TBitBtn
      TabOrder = 4
    end
  end
  inherited MeioPanel: TPanel
    Width = 938
    Height = 216
    ExplicitHeight = 215
    inherited GridsPanel: TPanel
      Height = 216
      ExplicitHeight = 215
      inherited SplitterRejeicaoGrid: TSplitter
        Top = 65
        ExplicitTop = 65
      end
      inherited ProdDBGrid: TDBGrid
        Height = 65
      end
      inherited RejeicaoDBGrid: TDBGrid
        Top = 70
      end
    end
  end
  inherited StatusPanel: TPanel
    Top = 323
    Width = 938
    ExplicitTop = 322
    DesignSize = (
      938
      21)
    inherited ProgressBar1: TProgressBar
      ExplicitLeft = -5
    end
  end
end
