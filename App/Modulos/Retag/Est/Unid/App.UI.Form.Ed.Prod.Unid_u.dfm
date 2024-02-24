inherited ProdUnidEdForm: TProdUnidEdForm
  Caption = 'ProdUnidEdForm'
  ClientHeight = 297
  ClientWidth = 495
  ExplicitWidth = 507
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 240
    Width = 495
    ExplicitTop = 239
  end
  inherited ObjetivoLabel: TLabel
    Width = 9
    Caption = '   '
    ExplicitWidth = 9
  end
  object SiglaLabeledEdit: TLabeledEdit [2]
    Left = 273
    Top = 48
    Width = 80
    Height = 23
    EditLabel.Width = 25
    EditLabel.Height = 15
    EditLabel.Caption = 'Sigla'
    TabOrder = 1
    Text = ''
    OnChange = SiglaLabeledEditChange
    OnKeyPress = SiglaLabeledEditKeyPress
  end
  object DescrLabeledEdit: TLabeledEdit [3]
    Left = 8
    Top = 48
    Width = 260
    Height = 23
    EditLabel.Width = 51
    EditLabel.Height = 15
    EditLabel.Caption = 'Descri'#231#227'o'
    MaxLength = 40
    TabOrder = 0
    Text = ''
    OnChange = DescrLabeledEditChange
    OnKeyPress = DescrLabeledEditKeyPress
  end
  inherited BasePanel: TPanel
    Top = 260
    Width = 495
    TabOrder = 2
    ExplicitWidth = 495
    DesignSize = (
      495
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 128
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 241
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      ExplicitLeft = 321
    end
  end
end
