inherited AppPessFuncionarioDataSetForm: TAppPessFuncionarioDataSetForm
  Caption = 'AppPessFuncionarioDataSetForm'
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
    object OpcaoSisAction_FunciDataSetForm: TAction
      Caption = 'Op'#231#245'es do Sistema'
      OnExecute = OpcaoSisAction_FunciDataSetFormExecute
    end
    object PerfilDeUsoAction_FunciDataSetForm: TAction
      Caption = 'Perfil de Uso'
      OnExecute = PerfilDeUsoAction_FunciDataSetFormExecute
    end
  end
end
