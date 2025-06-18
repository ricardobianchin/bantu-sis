inherited RetagEstProdDataSetForm: TRetagEstProdDataSetForm
  Caption = 'RetagEstProdDataSetForm'
  ClientHeight = 439
  ClientWidth = 688
  ExplicitWidth = 688
  ExplicitHeight = 439
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    Top = 409
    Width = 688
    ExplicitTop = 409
    ExplicitWidth = 688
    inherited TitAuxPanel_BasTabSheet: TPanel
      Left = 548
      ExplicitLeft = 548
    end
    inherited TitToolPanel_BasTabSheet: TPanel
      Width = 548
      ExplicitWidth = 548
      inherited TitToolBar1_BasTabSheet: TToolBar
        Width = 548
        Align = alBottom
        ExplicitWidth = 548
      end
    end
  end
  inherited DBGrid1: TDBGrid
    Width = 688
    Height = 409
  end
  inherited ActionList1_ActBasForm: TActionList
    object MudaLoteAction_ProdDatasetTabSheet: TAction
      Caption = 'Mudan'#231'a em Lote'
      OnExecute = MudaLoteAction_ProdDatasetTabSheetExecute
    end
  end
end
