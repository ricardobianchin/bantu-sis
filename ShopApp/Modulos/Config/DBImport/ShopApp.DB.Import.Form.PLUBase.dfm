inherited ShopDBImportFormPLUBase: TShopDBImportFormPLUBase
  Caption = 'Mercado, Importar PLUBase'
  ClientHeight = 613
  ExplicitTop = -190
  ExplicitHeight = 651
  TextHeight = 15
  inherited TopoPanel: TPanel
    object MoldeFileSelectPanel: TPanel [0]
      Left = 1
      Top = 8
      Width = 530
      Height = 24
      Caption = 'MoldeFileSelectPanel'
      TabOrder = 0
    end
    inherited ExecuteBitBtn: TBitBtn
      TabOrder = 1
    end
  end
  inherited BasePanel: TPanel
    Top = 526
    Height = 66
    ExplicitTop = 546
    ExplicitHeight = 66
    inherited FilConfTitLabel: TLabel
      Left = 6
      Top = 39
      ExplicitLeft = 6
      ExplicitTop = 39
    end
    inherited FilSelecTitLabel: TLabel
      Left = 212
      Top = 39
      Width = 40
      Caption = 'Sele'#231#227'o'
      ExplicitLeft = 212
      ExplicitTop = 39
      ExplicitWidth = 40
    end
    inherited FIlConfComboBox: TComboBox
      Left = 90
      Top = 36
      ExplicitLeft = 90
      ExplicitTop = 36
    end
    inherited AtualizarBitBtn_AppDBImport: TBitBtn
      Left = 374
      Top = 35
      ExplicitLeft = 374
      ExplicitTop = 35
    end
    inherited FilSelecComboBox: TComboBox
      Left = 256
      Top = 36
      ExplicitLeft = 256
      ExplicitTop = 36
    end
    inherited ZerarBitBtn: TBitBtn
      Left = 6
      Top = 3
      Width = 149
      Caption = 'Apagar Dados do Sistema'
      ExplicitLeft = 6
      ExplicitTop = 3
      ExplicitWidth = 149
    end
    inherited ValidarBitBtn_AppDBImport: TBitBtn
      Left = 159
      Top = 3
      ExplicitLeft = 159
      ExplicitTop = 3
    end
    inherited SelecBitBtn_AppDBImport: TBitBtn
      Left = 219
      Top = 3
      ExplicitLeft = 219
      ExplicitTop = 3
    end
  end
  inherited MeioPanel: TPanel
    Height = 485
    ExplicitHeight = 491
    inherited GridsPanel: TPanel
      Height = 485
      ExplicitHeight = 486
      inherited SplitterRejeicaoGrid: TSplitter
        Top = 334
        ExplicitTop = 388
      end
      inherited ProdDBGrid: TDBGrid
        Height = 334
      end
      inherited RejeicaoDBGrid: TDBGrid
        Top = 339
      end
    end
  end
  inherited StatusPanel: TPanel
    Top = 592
    ExplicitLeft = -8
    ExplicitTop = 607
  end
  inherited ActionList_AppDBImport: TActionList
    inherited ExecuteAction_AppDBImport: TAction
      OnExecute = ExecuteAction_AppDBImportExecute
    end
    inherited ZerarExecuteAction_AppDBImport: TAction
      Caption = 'Apagar Dados do Sistema'
    end
    inherited AtualizarAction_AppDBImport: TAction
      OnExecute = AtualizarAction_AppDBImportExecute
    end
    inherited ValidarAction_AppDBImport: TAction
      OnExecute = ValidarAction_AppDBImportExecute
    end
  end
end
