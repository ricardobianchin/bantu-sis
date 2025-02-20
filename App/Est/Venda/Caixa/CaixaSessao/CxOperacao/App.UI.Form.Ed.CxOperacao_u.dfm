inherited CxOperacaoEdForm: TCxOperacaoEdForm
  Caption = 'CxOperacaoEdForm'
  ClientHeight = 302
  ClientWidth = 647
  ExplicitWidth = 663
  ExplicitHeight = 341
  TextHeight = 15
  inherited MensLabel: TLabel
    Top = 230
    Width = 647
    ExplicitTop = 230
  end
  inherited ObjetivoLabel: TLabel
    Left = 0
    Top = 0
    Width = 647
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
    Top = 250
    Width = 647
    ExplicitTop = 250
  end
  inherited BasePanel: TPanel
    Top = 265
    Width = 647
    ExplicitTop = 265
    ExplicitWidth = 647
    DesignSize = (
      647
      37)
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 204
      ExplicitLeft = 200
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 317
      ExplicitLeft = 313
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 418
      ExplicitLeft = 414
    end
  end
  object MeioPanel: TPanel [4]
    Left = 0
    Top = 17
    Width = 647
    Height = 213
    Align = alClient
    BevelOuter = bvNone
    Caption = '  '
    TabOrder = 1
    ExplicitWidth = 643
    ExplicitHeight = 212
    object ObsPanel: TPanel
      Left = 0
      Top = 130
      Width = 647
      Height = 83
      Align = alBottom
      BevelOuter = bvNone
      Caption = '  '
      TabOrder = 0
      ExplicitTop = 129
      ExplicitWidth = 643
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
        Width = 647
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
