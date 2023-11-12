inherited RetagPrincForm: TRetagPrincForm
  BorderStyle = bsNone
  Caption = 'RetagPrincForm'
  ClientHeight = 481
  ClientWidth = 644
  Color = 1641478
  Font.Color = 10905156
  StyleElements = []
  ExplicitWidth = 644
  ExplicitHeight = 481
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 0
    Top = 0
    Width = 644
    Height = 21
    Align = alTop
    Caption = 'Retaguarda'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 10905156
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    StyleElements = []
    ExplicitWidth = 80
  end
  object CloseTimer: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = CloseTimerTimer
    Left = 232
    Top = 64
  end
end
