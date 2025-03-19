inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientHeight = 340
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 379
  TextHeight = 15
  inherited TopoPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
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
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 253
    inherited FilConfTitLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited FilSelecTitLabel: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited FIlConfComboBox: TComboBox
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited FilSelecComboBox: TComboBox
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited ValidarBitBtn_AppDBImport: TBitBtn
      TabOrder = 5
    end
    inherited EditBitBtn_AppDBImport: TBitBtn
      TabOrder = 4
    end
  end
  inherited MeioPanel: TPanel
    Height = 212
    StyleElements = [seFont, seClient, seBorder]
    ExplicitHeight = 212
    inherited GridsPanel: TPanel
      Height = 212
      StyleElements = [seFont, seClient, seBorder]
      ExplicitHeight = 212
      inherited SplitterRejeicaoGrid: TSplitter
        Top = 61
        ExplicitTop = 65
        ExplicitWidth = 930
      end
      inherited ProdDBGrid: TDBGrid
        Height = 61
      end
      inherited RejeicaoDBGrid: TDBGrid
        Top = 66
      end
    end
  end
  inherited StatusPanel: TPanel
    Top = 319
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 319
    inherited ProgressBar1: TProgressBar
      Left = -53
      ExplicitLeft = -53
    end
  end
end
