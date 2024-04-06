inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 473
  ClientWidth = 786
  ExplicitWidth = 802
  ExplicitHeight = 512
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 416
    Width = 786
    ExplicitTop = 417
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 786
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 401
    Width = 786
    ExplicitTop = 402
  end
  inherited BasePanel: TPanel
    Top = 436
    Width = 786
    ExplicitTop = 436
    ExplicitWidth = 786
    DesignSize = (
      786
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 259
      ExplicitLeft = 259
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 372
      ExplicitLeft = 372
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 452
      ExplicitLeft = 452
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 786
    Height = 386
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 786
      Height = 390
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
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
