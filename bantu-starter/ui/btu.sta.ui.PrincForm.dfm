object PrincForm: TPrincForm
  Left = 0
  Top = 0
  Caption = 'DarosPDV'
  ClientHeight = 548
  ClientWidth = 599
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
  object StatusMemo: TMemo
    Left = 16
    Top = 40
    Width = 569
    Height = 481
    ReadOnly = True
    TabOrder = 0
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
