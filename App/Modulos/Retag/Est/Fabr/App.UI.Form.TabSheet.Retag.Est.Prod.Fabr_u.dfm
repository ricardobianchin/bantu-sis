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
  end
end
