inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 470
  ClientWidth = 774
  ExplicitWidth = 790
  ExplicitHeight = 509
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 413
    Width = 774
    ExplicitTop = 414
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
    ExplicitTop = 399
  end
  inherited BasePanel: TPanel
    Top = 433
    Width = 774
    ExplicitTop = 433
    ExplicitWidth = 774
    DesignSize = (
      774
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 235
      ExplicitLeft = 235
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 348
      ExplicitLeft = 348
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 428
      ExplicitLeft = 428
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
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 778
      Height = 407
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 774
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
