inherited RetagSaldoDataSetForm: TRetagSaldoDataSetForm
  Caption = 'RetagSaldoDataSetForm'
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
    object ProdHistAction_RetagSaldoDataSetForm: TAction
      Caption = 'Hist'#243'rico do Produto'
      OnExecute = ProdHistAction_RetagSaldoDataSetFormExecute
    end
    object ProdHistsFecharAction_RetagSaldoDataSetForm: TAction
      Caption = 'Fechar Todos os Hist'#243'ricos'
      OnExecute = ProdHistsFecharAction_RetagSaldoDataSetFormExecute
    end
  end
end
