object OutputForm: TOutputForm
  Left = 0
  Top = 0
  Caption = 'Acompanhamento'
  ClientHeight = 543
  ClientWidth = 380
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object BasePanel: TPanel
    Left = 0
    Top = 502
    Width = 380
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 380
    Height = 502
    Align = alClient
    ReadOnly = True
    TabOrder = 1
  end
  object ShowTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = ShowTimerTimer
    Left = 192
    Top = 280
  end
end
