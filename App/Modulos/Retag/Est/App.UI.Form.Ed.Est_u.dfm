inherited EstEdBasForm: TEstEdBasForm
  Caption = 'EstEdBasForm'
  ClientHeight = 333
  ClientWidth = 595
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 611
  ExplicitHeight = 372
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 261
    Width = 595
  end
  inherited ObjetivoLabel: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 281
    Width = 595
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited BasePanel: TPanel
    Top = 296
    Width = 595
    StyleElements = [seFont, seClient, seBorder]
    DesignSize = (
      595
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 180
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 293
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 394
    end
  end
  object CodLabeledEdit: TLabeledEdit [4]
    Left = 48
    Top = 32
    Width = 137
    Height = 23
    EditLabel.Width = 39
    EditLabel.Height = 23
    EditLabel.Caption = 'C'#243'digo'
    LabelPosition = lpLeft
    LabelSpacing = 4
    TabOrder = 1
    Text = ''
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 40
    Top = 80
  end
  inherited ActionList1_Diag: TActionList
    Left = 160
    Top = 104
  end
end
