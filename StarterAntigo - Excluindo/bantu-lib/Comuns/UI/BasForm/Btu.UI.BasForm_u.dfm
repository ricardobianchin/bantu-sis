object BasForm: TBasForm
  Left = 0
  Top = 0
  Caption = 'BasForm'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object ShowTimerBas: TTimer
    Enabled = False
    Interval = 100
    OnTimer = ShowTimerBasTimer
    Left = 104
    Top = 64
  end
end
