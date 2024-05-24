object SplashForm: TSplashForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'SplashForm'
  ClientHeight = 290
  ClientWidth = 605
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Image1: TImage
    Left = 114
    Top = 8
    Width = 377
    Height = 161
    Center = True
  end
  object MensLabel: TLabel
    Left = 26
    Top = 184
    Width = 553
    Height = 89
    Alignment = taCenter
    AutoSize = False
    Caption = 'Iniciando...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
    StyleElements = []
  end
end
