inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 480
  ClientWidth = 814
  ExplicitWidth = 826
  ExplicitHeight = 518
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 423
    Width = 814
    ExplicitTop = 423
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 814
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 408
    Width = 814
    ExplicitTop = 408
  end
  inherited BasePanel: TPanel
    Top = 443
    Width = 814
    ExplicitTop = 442
    ExplicitWidth = 810
    DesignSize = (
      814
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 319
      ExplicitLeft = 315
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 432
      ExplicitLeft = 428
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 512
      ExplicitLeft = 508
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 814
    Height = 393
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 810
    ExplicitHeight = 392
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 814
      Height = 390
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 810
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
