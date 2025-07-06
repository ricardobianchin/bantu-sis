inherited PerfilDeUsoDataSetForm: TPerfilDeUsoDataSetForm
  Caption = 'PerfilDeUsoDataSetForm'
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
    object OpcaoSisAction_PerfilDeUsoDataSetForm: TAction
      Caption = 'Op'#231#245'es do Sistema'
      OnExecute = OpcaoSisAction_PerfilDeUsoDataSetFormExecute
    end
  end
  inherited SelectActionList_DataSetForm: TActionList
    Left = 448
    Top = 64
  end
end
