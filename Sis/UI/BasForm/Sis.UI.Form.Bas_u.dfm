object BasForm: TBasForm
  Left = 0
  Top = 0
  Caption = 'BasForm'
  ClientHeight = 419
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDesigned
  ShowHint = True
  OnShow = FormShow
  TextHeight = 15
  object ShowTimer_BasForm: TTimer
    Enabled = False
    Interval = 100
    OnTimer = ShowTimer_BasFormTimer
    Left = 200
    Top = 80
  end
end
