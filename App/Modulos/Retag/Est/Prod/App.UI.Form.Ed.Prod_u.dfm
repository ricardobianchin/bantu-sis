inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 562
  ClientWidth = 838
  ExplicitTop = -139
  ExplicitWidth = 850
  ExplicitHeight = 600
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 505
    Width = 838
    ExplicitTop = 505
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 838
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 490
    Width = 838
    ExplicitTop = 490
  end
  inherited BasePanel: TPanel
    Top = 525
    Width = 838
    ExplicitTop = 524
    ExplicitWidth = 834
    DesignSize = (
      838
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 383
      ExplicitLeft = 379
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 496
      ExplicitLeft = 492
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 576
      ExplicitLeft = 572
    end
  end
  object ComunsPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 838
    Height = 346
    Align = alTop
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 111
    Top = 96
  end
  inherited ActionList1_Diag: TActionList
    Left = 272
    Top = 104
  end
end
