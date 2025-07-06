object TestaDtControlForm: TTestaDtControlForm
  Left = 0
  Top = 0
  Caption = 'TestaDtControlForm'
  ClientHeight = 164
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 336
    Top = 12
    Width = 34
    Height = 15
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 248
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
end
