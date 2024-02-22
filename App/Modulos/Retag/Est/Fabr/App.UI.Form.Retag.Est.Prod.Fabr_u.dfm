inherited RetagEstProdFabrForm: TRetagEstProdFabrForm
  Caption = 'RetagEstProdFabrForm'
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    inherited TitToolBar1_BasTabSheet: TToolBar
      Height = 29
      ExplicitHeight = 29
    end
  end
  inherited ActionList1_ActBasForm: TActionList
    inherited ExclAction_DatasetTabSheet: TAction
      OnExecute = ExclAction_DatasetTabSheetExecute
    end
  end
end
