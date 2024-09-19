inherited AppPessFuncionarioDataSetForm: TAppPessFuncionarioDataSetForm
  Caption = 'AppPessFuncionarioDataSetForm'
  TextHeight = 15
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
