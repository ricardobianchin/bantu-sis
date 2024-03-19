inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 486
  ClientWidth = 838
  ExplicitWidth = 850
  ExplicitHeight = 524
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 429
    Width = 838
    ExplicitTop = 429
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
    Top = 414
    Width = 838
    ExplicitTop = 414
  end
  inherited BasePanel: TPanel
    Top = 449
    Width = 838
    ExplicitTop = 448
    ExplicitWidth = 834
    DesignSize = (
      838
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 367
      ExplicitLeft = 363
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 480
      ExplicitLeft = 476
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 560
      ExplicitLeft = 556
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 838
    Height = 399
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 834
    ExplicitHeight = 398
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 838
      Height = 390
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 834
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
