inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 329
  ClientWidth = 888
  ExplicitWidth = 900
  ExplicitHeight = 367
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 272
    Width = 888
  end
  object Label1: TLabel [2]
    Left = 653
    Top = 31
    Width = 55
    Height = 15
    Caption = 'Fabricante'
  end
  object DescrLabeledEdit: TLabeledEdit [3]
    Left = 73
    Top = 48
    Width = 366
    Height = 23
    EditLabel.Width = 51
    EditLabel.Height = 15
    EditLabel.Caption = 'Descri'#231#227'o'
    MaxLength = 120
    TabOrder = 1
    Text = ''
  end
  inherited BasePanel: TPanel
    Top = 292
    Width = 888
    ExplicitTop = 259
    ExplicitWidth = 884
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 521
      ExplicitLeft = 517
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 634
      ExplicitLeft = 630
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 714
      ExplicitLeft = 710
    end
  end
  object LabeledEdit1: TLabeledEdit [5]
    Left = 443
    Top = 48
    Width = 207
    Height = 23
    EditLabel.Width = 102
    EditLabel.Height = 15
    EditLabel.Caption = 'Descri'#231#227'o Reduzida'
    MaxLength = 29
    TabOrder = 2
    Text = ''
  end
  object FabrComboBox: TComboBox [6]
    Left = 653
    Top = 48
    Width = 220
    Height = 23
    TabOrder = 3
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 112
    Top = 136
  end
  inherited ActionList1_Diag: TActionList
    Left = 248
    Top = 136
  end
end
