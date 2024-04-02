inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 478
  ClientWidth = 806
  ExplicitWidth = 818
  ExplicitHeight = 516
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 421
    Width = 806
    ExplicitTop = 421
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 806
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 406
    Width = 806
    ExplicitTop = 406
  end
  inherited BasePanel: TPanel
    Top = 441
    Width = 806
    ExplicitTop = 440
    ExplicitWidth = 802
    DesignSize = (
      806
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 299
      ExplicitLeft = 295
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 412
      ExplicitLeft = 408
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 492
      ExplicitLeft = 488
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 806
    Height = 391
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 802
    ExplicitHeight = 390
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 806
      Height = 390
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 802
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
