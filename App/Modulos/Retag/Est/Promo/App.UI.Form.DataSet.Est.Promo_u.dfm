inherited AppPromoDataSetForm: TAppPromoDataSetForm
  Caption = 'AppPromoDataSetForm'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited TitAuxPanel_BasTabSheet: TPanel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited TitToolPanel_BasTabSheet: TPanel
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited DetailPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited SelectPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited ActionList1_ActBasForm: TActionList
    inherited InsItemAction_DatasetTabSheet: TAction
      OnExecute = InsItemAction_DatasetTabSheetExecute
    end
    inherited AltItemAction_DatasetTabSheet: TAction
      OnExecute = AltItemAction_DatasetTabSheetExecute
    end
  end
end
