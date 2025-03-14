inherited CxOperacaoEdForm: TCxOperacaoEdForm
  Caption = 'CxOperacaoEdForm'
  ClientHeight = 299
  ClientWidth = 635
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 651
  ExplicitHeight = 338
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 227
    Width = 635
    ExplicitTop = 227
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
    StyleElements = [seFont, seClient, seBorder]
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 16
    ExplicitHeight = 17
  end
  inherited AlteracaoTextoLabel: TLabel
    Top = 247
    Width = 635
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 247
  end
  inherited BasePanel: TPanel
    Top = 262
    Width = 635
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 262
    ExplicitWidth = 635
    DesignSize = (
      635
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 180
      ExplicitLeft = 180
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 293
      ExplicitLeft = 293
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 394
      ExplicitLeft = 394
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
    object ObsPanel: TPanel
      Left = 0
      Top = 127
      Width = 635
      Height = 83
      Align = alBottom
      BevelOuter = bvNone
      Caption = '  '
      TabOrder = 0
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 635
        Height = 15
        Align = alTop
        Caption = 'Observa'#231#245'es (200 caracteres)'
        ExplicitWidth = 152
      end
      object ObsMemo: TMemo
        Left = 0
        Top = 15
        Width = 635
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
