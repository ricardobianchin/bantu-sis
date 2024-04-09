inherited RetagEstProdICMSDataSetForm: TRetagEstProdICMSDataSetForm
  Caption = 'RetagEstProdICMSDataSetForm'
  TextHeight = 15
  inherited TitPanel_BasTabSheet: TPanel
    inherited TitToolBar1_BasTabSheet: TToolBar
      Height = 29
      ExplicitHeight = 29
    end
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
