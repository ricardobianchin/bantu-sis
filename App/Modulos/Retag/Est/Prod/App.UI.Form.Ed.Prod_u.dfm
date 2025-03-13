inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 469
  ClientWidth = 784
  StyleElements = [seFont, seClient, seBorder]
  ExplicitLeft = -13
  ExplicitWidth = 800
  ExplicitHeight = 508
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 412
    Width = 784
    ExplicitTop = 412
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 784
    Align = alTop
    StyleElements = [seFont, seClient, seBorder]
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 397
    Width = 784
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 397
  end
  inherited BasePanel: TPanel
    Top = 432
    Width = 784
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 432
    ExplicitWidth = 770
    DesignSize = (
      784
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 229
      ExplicitLeft = 215
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 342
      ExplicitLeft = 328
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 422
      ExplicitLeft = 408
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 784
    Height = 382
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 770
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 784
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
