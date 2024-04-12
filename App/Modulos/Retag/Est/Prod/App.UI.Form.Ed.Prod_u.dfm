inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 471
  ClientWidth = 778
  ExplicitWidth = 794
  ExplicitHeight = 510
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 414
    Width = 778
    ExplicitTop = 415
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 778
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 399
    Width = 778
    ExplicitTop = 400
  end
  inherited BasePanel: TPanel
    Top = 434
    Width = 778
    ExplicitTop = 435
    ExplicitWidth = 782
    DesignSize = (
      778
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 243
      ExplicitLeft = 247
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 356
      ExplicitLeft = 360
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 436
      ExplicitLeft = 440
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 778
    Height = 384
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 782
    ExplicitHeight = 385
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 786
      Height = 407
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 782
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
