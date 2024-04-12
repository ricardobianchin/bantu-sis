inherited ProdEdForm: TProdEdForm
  Caption = 'ProdEdForm'
  ClientHeight = 472
  ClientWidth = 782
  ExplicitWidth = 798
  ExplicitHeight = 511
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 415
    Width = 782
    ExplicitTop = 416
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 782
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 0
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 400
    Width = 782
    ExplicitTop = 401
  end
  inherited BasePanel: TPanel
    Top = 435
    Width = 782
    ExplicitTop = 435
    ExplicitWidth = 782
    DesignSize = (
      782
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 247
      ExplicitLeft = 247
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 360
      ExplicitLeft = 360
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 440
      ExplicitLeft = 440
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 15
    Width = 782
    Height = 385
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
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
