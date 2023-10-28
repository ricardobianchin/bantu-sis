object PrincForm: TPrincForm
  Left = 0
  Top = 0
  Caption = 'DarosPDV'
  ClientHeight = 547
  ClientWidth = 595
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object DtHCompileLabel: TLabel
    Left = 8
    Top = 520
    Width = 89
    Height = 13
    Caption = 'DtHCompileLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object StatusMemo: TMemo
    Left = 16
    Top = 224
    Width = 569
    Height = 281
    BorderStyle = bsNone
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
    StyleElements = [seFont, seBorder]
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 160
    Top = 104
  end
  object ShowTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = ShowTimerTimer
    Left = 296
    Top = 144
  end
end
