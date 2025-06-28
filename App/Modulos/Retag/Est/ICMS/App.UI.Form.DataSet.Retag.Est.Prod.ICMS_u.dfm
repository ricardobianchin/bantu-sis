inherited RetagEstProdICMSDataSetForm: TRetagEstProdICMSDataSetForm
  Caption = 'RetagEstProdICMSDataSetForm'
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
  inherited SelectPanel: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited ActionList1_ActBasForm: TActionList
    Left = 312
    Top = 56
    object DesativarAction_DatasetTabSheet: TAction
      Caption = 'Desativar'
      OnExecute = DesativarAction_DatasetTabSheetExecute
    end
    object AtivarAction_DatasetTabSheet: TAction
      Caption = 'Ativar'
      OnExecute = AtivarAction_DatasetTabSheetExecute
    end
  end
end
