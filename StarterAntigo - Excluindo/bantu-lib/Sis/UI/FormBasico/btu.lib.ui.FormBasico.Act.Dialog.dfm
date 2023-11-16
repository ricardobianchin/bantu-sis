inherited FormBasActDialog: TFormBasActDialog
  Caption = 'FormBasActDialog'
  TextHeight = 17
  inherited BasActActionList: TActionList
    object BasDiagOkAct: TAction
      Caption = 'Ok'
      Hint = 'Ok'
      OnExecute = BasDiagOkActExecute
    end
    object BasDiagCancelarAct: TAction
      Caption = 'Cancelar'
      Hint = 'Cancelar'
      OnExecute = BasDiagCancelarActExecute
    end
  end
end
