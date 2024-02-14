inherited ProdFabrEdForm: TProdFabrEdForm
  Caption = 'ProdFabrEdForm'
  ClientHeight = 298
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 241
  end
  inherited LabeledEdit1: TLabeledEdit
    OnChange = LabeledEdit1Change
    OnKeyPress = LabeledEdit1KeyPress
  end
  inherited BasePanel: TPanel
    Top = 261
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 168
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 281
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 361
    end
  end
end
