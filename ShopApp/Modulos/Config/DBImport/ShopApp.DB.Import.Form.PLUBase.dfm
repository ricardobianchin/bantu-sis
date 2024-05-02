inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientHeight = 344
  ExplicitHeight = 382
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
    Top = 257
    ExplicitTop = 257
    ExplicitWidth = 938
    inherited ValidarBitBtn_AppDBImport: TBitBtn
      TabOrder = 5
    end
    inherited SelecBitBtn_AppDBImport: TBitBtn
      TabOrder = 4
    end
  end
  inherited MeioPanel: TPanel
    Height = 216
  end
  inherited StatusPanel: TPanel
    Top = 323
  end
end
