inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 470
  ClientWidth = 774
  ExplicitWidth = 786
  ExplicitHeight = 508
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 413
    Width = 774
    ExplicitTop = 413
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 774
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 398
    Width = 774
    ExplicitTop = 398
  end
  inherited BasePanel: TPanel
    Top = 433
    Width = 774
    ExplicitTop = 432
    ExplicitWidth = 770
    DesignSize = (
      774
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 231
      ExplicitLeft = 227
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 344
      ExplicitLeft = 340
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 424
      ExplicitLeft = 420
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 774
    Height = 383
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 770
    ExplicitHeight = 382
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
