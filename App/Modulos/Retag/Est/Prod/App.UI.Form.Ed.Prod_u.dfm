inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 491
  ClientWidth = 944
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 960
  ExplicitHeight = 530
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 434
    Width = 944
    ExplicitTop = 412
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 944
    Align = alTop
    StyleElements = [seFont, seClient, seBorder]
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 419
    Width = 944
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 397
  end
  inherited BasePanel: TPanel
    Top = 454
    Width = 944
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 432
    ExplicitWidth = 784
    DesignSize = (
      944
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 389
      ExplicitLeft = 229
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 502
      ExplicitLeft = 342
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 582
      ExplicitLeft = 422
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 944
    Height = 404
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    ExplicitWidth = 784
    ExplicitHeight = 382
    object ComunsPanel: TPanel
      Left = 0
      Top = 0
      Width = 944
      Height = 407
      Align = alTop
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 0
      ExplicitWidth = 784
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
