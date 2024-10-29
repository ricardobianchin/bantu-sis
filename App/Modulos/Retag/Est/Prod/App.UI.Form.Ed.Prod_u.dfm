inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 469
  ClientWidth = 770
  ExplicitWidth = 786
  ExplicitHeight = 508
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 412
    Width = 770
    ExplicitTop = 413
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 770
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 397
    Width = 770
    ExplicitTop = 398
  end
  inherited BasePanel: TPanel
    Top = 432
    Width = 770
    ExplicitTop = 432
    ExplicitWidth = 770
    DesignSize = (
      770
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 219
      ExplicitLeft = 223
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 332
      ExplicitLeft = 336
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 412
      ExplicitLeft = 416
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 770
    Height = 382
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 774
      Height = 407
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 770
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
