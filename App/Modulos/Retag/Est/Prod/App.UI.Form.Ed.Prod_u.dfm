inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 482
  ClientWidth = 822
  ExplicitWidth = 838
  ExplicitHeight = 521
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 425
    Width = 822
    ExplicitTop = 426
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 822
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 410
    Width = 822
    ExplicitTop = 411
  end
  inherited BasePanel: TPanel
    Top = 445
    Width = 822
    ExplicitTop = 446
    ExplicitWidth = 826
    DesignSize = (
      822
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 335
      ExplicitLeft = 343
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 448
      ExplicitLeft = 456
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 528
      ExplicitLeft = 536
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 822
    Height = 395
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 826
    ExplicitHeight = 396
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 830
      Height = 390
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 826
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
