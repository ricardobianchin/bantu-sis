inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 485
  ClientWidth = 834
  ExplicitWidth = 846
  ExplicitHeight = 523
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 428
    Width = 834
    ExplicitTop = 428
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 834
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 413
    Width = 834
    ExplicitTop = 413
  end
  inherited BasePanel: TPanel
    Top = 448
    Width = 834
    ExplicitTop = 447
    ExplicitWidth = 830
    DesignSize = (
      834
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 359
      ExplicitLeft = 355
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 472
      ExplicitLeft = 468
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 552
      ExplicitLeft = 548
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 834
    Height = 398
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 830
    ExplicitHeight = 397
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 834
      Height = 390
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 830
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
