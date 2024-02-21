inherited ProdTipoEdForm: TProdTipoEdForm
  Caption = 'ProdTipoEdForm'
  ClientHeight = 298
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 241
  end
  object LabeledEdit1: TLabeledEdit [2]
    Left = 8
    Top = 48
    Width = 260
    Height = 23
    EditLabel.Width = 67
    EditLabel.Height = 15
    EditLabel.Caption = 'LabeledEdit1'
    MaxLength = 40
    TabOrder = 1
    Text = ''
    OnChange = LabeledEdit1Change
    OnKeyPress = LabeledEdit1KeyPress
  end
  inherited BasePanel: TPanel
    Top = 261
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 140
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 253
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 333
    end
  end
end
