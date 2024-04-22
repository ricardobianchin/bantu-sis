inherited RetagEstProdICMSDataSetForm: TRetagEstProdICMSDataSetForm
  Caption = 'RetagEstProdICMSDataSetForm'
  TextHeight = 15
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
