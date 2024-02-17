inherited PergBooleanForm: TPergBooleanForm
  Caption = 'PergBooleanForm'
  TextHeight = 15
  object MensagemLabel: TLabel [1]
    Left = 0
    Top = 0
    Width = 503
    Height = 240
    Align = alClient
    Alignment = taCenter
    Caption = 'MensagemLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
    StyleElements = [seClient, seBorder]
    ExplicitWidth = 114
    ExplicitHeight = 21
  end
  inherited BasePanel: TPanel
    inherited MensCopyBitBtn_DiagBtn: TBitBtn
      Left = 180
      ExplicitLeft = 176
    end
    inherited OkBitBtn_DiagBtn: TBitBtn
      Left = 293
      ExplicitLeft = 289
    end
    inherited CancelBitBtn_DiagBtn: TBitBtn
      Left = 373
      ExplicitLeft = 369
    end
  end
end
