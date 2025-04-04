object TestForm: TTestForm
  Left = 0
  Top = 0
  Caption = 'This form is a demo to how to detect the pressim of the Tab key'
  ClientHeight = 231
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OnKeyUp = FormKeyUp
  TextHeight = 15
  object Label1: TLabel
    Left = 200
    Top = 32
    Width = 34
    Height = 15
    Caption = 'Label1'
  end
  object MaskEdit1: TMaskEdit
    Left = 32
    Top = 32
    Width = 121
    Height = 23
    TabOrder = 0
    Text = 'MaskEdit1'
    OnKeyDown = MaskEdit1KeyDown
  end
  object MaskEdit2: TMaskEdit
    Left = 32
    Top = 72
    Width = 121
    Height = 23
    TabOrder = 1
    Text = 'MaskEdit2'
  end
end
