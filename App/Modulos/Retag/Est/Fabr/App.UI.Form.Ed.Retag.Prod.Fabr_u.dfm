inherited ProdFabrEdForm: TProdFabrEdForm
  Caption = 'ProdFabrEdForm'
  TextHeight = 15
  inherited BasePanel: TPanel
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 164
      ExplicitLeft = 160
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 277
      ExplicitLeft = 273
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 357
      ExplicitLeft = 353
    end
  end
  inherited LabeledEdit1: TLabeledEdit
    EditLabel.ExplicitLeft = 0
    EditLabel.ExplicitTop = -18
    OnChange = LabeledEdit1Change
    OnKeyPress = LabeledEdit1KeyPress
  end
end
