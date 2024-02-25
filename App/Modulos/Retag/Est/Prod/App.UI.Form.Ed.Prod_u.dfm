inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientWidth = 888
  ExplicitWidth = 900
  ExplicitHeight = 334
  TextHeight = 15
  inherited MensLabel: TLabel
    Width = 888
    ExplicitTop = 239
  end
  inherited BasePanel: TPanel
    Width = 888
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 529
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 642
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 722
    end
  end
  object LabeledEdit1: TLabeledEdit [3]
    Left = 8
    Top = 48
    Width = 350
    Height = 23
    EditLabel.Width = 67
    EditLabel.Height = 15
    EditLabel.Caption = 'LabeledEdit1'
    TabOrder = 1
    Text = ''
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 32
    Top = 136
  end
  inherited ActionList1_Diag: TActionList
    Left = 120
    Top = 120
  end
end
