inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 478
  ClientWidth = 806
  ExplicitWidth = 822
  ExplicitHeight = 517
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
    ExplicitTop = 441
    ExplicitWidth = 806
    DesignSize = (
      806
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 303
      ExplicitLeft = 303
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 416
      ExplicitLeft = 416
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 496
      ExplicitLeft = 496
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
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 810
      Height = 390
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 806
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
