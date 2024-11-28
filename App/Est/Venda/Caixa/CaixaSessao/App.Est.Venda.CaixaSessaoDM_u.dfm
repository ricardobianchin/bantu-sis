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
    Left = 296
    Top = 24
  end
end
