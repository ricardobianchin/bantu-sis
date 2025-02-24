inherited CxOperacaoEdForm: TCxOperacaoEdForm
  Caption = 'CxOperacaoEdForm'
  ClientHeight = 299
  ClientWidth = 635
  ExplicitWidth = 651
  ExplicitHeight = 338
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 227
    Width = 635
    ExplicitTop = 228
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 635
    Height = 17
    Align = alTop
    Font.Height = -13
    ParentFont = False
    WordWrap = True
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 16
    ExplicitHeight = 17
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 247
    Width = 635
    ExplicitTop = 248
  end
  inherited BasePanel: TPanel
    Top = 262
    Width = 635
    ExplicitTop = 263
    ExplicitWidth = 639
    DesignSize = (
      635
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 180
      ExplicitLeft = 188
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 293
      ExplicitLeft = 301
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 394
      ExplicitLeft = 402
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 17
    Width = 635
    Height = 210
    Align = alClient
    BevelOuter = bvNone
    Caption = '  '
    TabOrder = 1
    ExplicitWidth = 639
    ExplicitHeight = 211
    object ObsPanel: TPanel
      Left = 0
      Top = 129
      Width = 643
      Height = 83
      Align = alBottom
      BevelOuter = bvNone
      Caption = '  '
      TabOrder = 0
      ExplicitTop = 128
      ExplicitWidth = 639
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 152
        Height = 15
        Align = alTop
        Caption = 'Observa'#231#245'es (200 caracteres)'
      end
      object ObsMemo: TMemo
        Left = 0
        Top = 15
        Width = 643
        Height = 68
        Align = alClient
        BorderStyle = bsNone
        MaxLength = 200
        TabOrder = 0
        WantReturns = False
      end
    end
  end
  inherited ShowTimer_BasForm: TTimer
    Left = 80
    Top = 160
  end
  inherited ActionList1_Diag: TActionList
    Left = 152
    Top = 160
  end
end
