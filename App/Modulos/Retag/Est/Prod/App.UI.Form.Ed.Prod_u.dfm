inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 474
  ClientWidth = 790
  ExplicitWidth = 806
  ExplicitHeight = 513
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 417
    Width = 790
    ExplicitTop = 418
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 790
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 402
    Width = 790
    ExplicitTop = 403
  end
  inherited BasePanel: TPanel
    Top = 437
    Width = 790
    ExplicitTop = 438
    ExplicitWidth = 794
    DesignSize = (
      790
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 267
      ExplicitLeft = 275
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 380
      ExplicitLeft = 388
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 460
      ExplicitLeft = 468
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 790
    Height = 387
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 794
    ExplicitHeight = 388
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 798
      Height = 390
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 794
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
