inherited RetagEstProdFabrTabSheetDataSetForm: TRetagEstProdFabrTabSheetDataSetForm
  Caption = 'RetagEstProdFabrTabSheetDataSetForm'
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    inherited TitToolBar1_BasTabSheet: TToolBar
      Height = 29
      ExplicitHeight = 29
    end
  end
  inherited ActionList1_ActBasForm: TActionList
    inherited InsAction_DatasetTabSheet: TAction
      OnExecute = InsAction_DatasetTabSheetExecute
    end
    inherited AltAction_DatasetTabSheet: TAction
      OnExecute = AltAction_DatasetTabSheetExecute
    end
    inherited ExclAction_DatasetTabSheetAction1: TAction
      OnExecute = ExclAction_DatasetTabSheetAction1Execute
    end
  end
end
