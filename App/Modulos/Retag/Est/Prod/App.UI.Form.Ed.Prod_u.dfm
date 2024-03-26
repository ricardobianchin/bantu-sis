inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 483
  ClientWidth = 826
  ExplicitWidth = 842
  ExplicitHeight = 522
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 426
    Width = 826
    ExplicitTop = 426
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 826
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 411
    Width = 826
    ExplicitTop = 411
  end
  inherited BasePanel: TPanel
    Top = 446
    Width = 826
    ExplicitTop = 446
    ExplicitWidth = 826
    DesignSize = (
      826
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 343
      ExplicitLeft = 343
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 456
      ExplicitLeft = 456
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 536
      ExplicitLeft = 536
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 826
    Height = 396
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
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
