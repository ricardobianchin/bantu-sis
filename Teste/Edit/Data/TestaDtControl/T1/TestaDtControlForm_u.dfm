object TestaDtControlForm: TTestaDtControlForm
  Left = 0
  Top = 0
  Caption = 'TestaDtControlForm'
  ClientHeight = 164
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 168
    Top = 64
    Width = 34
    Height = 15
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 80
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
end
