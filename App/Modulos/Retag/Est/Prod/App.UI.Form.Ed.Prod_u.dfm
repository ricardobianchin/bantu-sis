inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 484
  ClientWidth = 830
  ExplicitWidth = 842
  ExplicitHeight = 522
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 427
    Width = 830
    ExplicitTop = 427
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 830
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 412
    Width = 830
    ExplicitTop = 412
  end
  inherited BasePanel: TPanel
    Top = 447
    Width = 830
    ExplicitTop = 446
    ExplicitWidth = 826
    DesignSize = (
      830
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 351
      ExplicitLeft = 347
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 464
      ExplicitLeft = 460
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 544
      ExplicitLeft = 540
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 830
    Height = 397
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
