object CaixaSessaoDM: TCaixaSessaoDM
  Height = 245
  Width = 480
  object CaixaSessaoActionList: TActionList
    Left = 216
    Top = 40
    object CaixaSessaoFormAbrirAction_CaixaSessaoDM: TAction
      Category = 'Sess'#245'es'
      Caption = 'Sess'#245'es de Caixa'
    end
  end
  object CxOperacaoActionList: TActionList
    OnExecute = CxOperacaoActionListExecute
    Left = 328
    Top = 40
    object AberturaAction: TAction
      Caption = 'Abrir o Caixa'
      OnExecute = AberturaActionExecute
    end
    object SuprimentoAction: TAction
      Caption = 'Suprimento'
      OnExecute = SuprimentoActionExecute
    end
    object SangriaAction: TAction
      Caption = 'Sangria'
      OnExecute = SangriaActionExecute
    end
    object DespesaAction: TAction
      Caption = 'Despesa'
      OnExecute = DespesaActionExecute
    end
    object ValeAction: TAction
      Caption = 'Vale'
    end
    object FechamentoAction: TAction
      Caption = 'Fechamento'
      OnExecute = FechamentoActionExecute
    end
  end
end
