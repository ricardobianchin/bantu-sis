inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 562
  ClientWidth = 838
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
      Left = 375
      ExplicitLeft = 371
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 488
      ExplicitLeft = 484
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 568
      ExplicitLeft = 564
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 838
    Height = 475
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 838
      Height = 475
      Align = alClient
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
    end
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
