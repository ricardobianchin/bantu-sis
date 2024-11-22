object CaixaSessaoDM: TCaixaSessaoDM
  Height = 245
  Width = 480
  object CaixaActionList: TActionList
    Left = 216
    Top = 40
    object AbrirAction_CaixaSessaoDM: TAction
      Category = 'Opera'#231#245'es'
      Caption = 'Abrir o Caixa...'
      OnExecute = AbrirAction_CaixaSessaoDMExecute
    end
    object SessoesAbrirAction_CaixaSessaoDM: TAction
      Category = 'Sess'#245'es'
      Caption = 'Sess'#245'es de Caixa'
    end
  end
end
