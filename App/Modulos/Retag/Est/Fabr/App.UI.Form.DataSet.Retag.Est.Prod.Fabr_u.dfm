inherited RetagEstProdFabrDataSetForm: TRetagEstProdFabrDataSetForm
  Caption = 'RetagEstProdFabrDataSetForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited TitToolBar1_BasTabSheet: TToolBar
      inherited Panel1: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
  inherited SelectPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited ActionList1_ActBasForm: TActionList
    inherited ExclAction_DatasetTabSheet: TAction
      OnExecute = ExclAction_DatasetTabSheetExecute
    end
  end
end
