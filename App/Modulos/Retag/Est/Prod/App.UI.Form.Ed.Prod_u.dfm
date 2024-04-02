inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 477
  ClientWidth = 802
  ExplicitWidth = 818
  ExplicitHeight = 516
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 420
    Width = 802
    ExplicitTop = 421
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 802
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 405
    Width = 802
    ExplicitTop = 406
  end
  inherited BasePanel: TPanel
    Top = 440
    Width = 802
    ExplicitTop = 440
    ExplicitWidth = 802
    DesignSize = (
      802
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 291
      ExplicitLeft = 291
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 404
      ExplicitLeft = 404
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 484
      ExplicitLeft = 484
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 802
    Height = 390
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
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
